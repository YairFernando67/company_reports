# frozen_string_literal: true

class ReporterService < Report::Base
  def add_user_info
    report[:user] = user.slice(:email, :name)
                        .merge(address_fields)
                        .transform_keys! {|k| k.titleize }
                        .symbolize_keys
  end

  def add_company_info
    report[:companies] = active_companies.map do |company|
      company.slice(*config_company_fields).tap do |hash|
        products = company.products
        fiscal_info = company.fiscal_info
        products_array = products.map { |p| p.slice(*config_product_fields) }
        hash.store(:products, products_array)
        hash.store(:fiscal_information, fiscal_info.slice(*config_fiscal_fields))
        hash.store(:address, yield(company.address)) if defined?(yield)
      end.deep_symbolize_keys
    end
  end

  def add_sales
    report[:sales] = active_companies.map do |company|
      sales = company.sales
      sales.map do |sale|
        discount = sale.total > 800 ? (sale.total.to_f * 0.1) : 0
        employee = sale.seller
        hash = {
          id: sale.id,
          company_name: sale.company_business_name,
          status: sale.status,
          total_before_taxes: sale.total.to_f,
          date: sale.created_at.strftime("%b %Y %m"),
          total: (sale.total.to_f + (sale.total.to_f * 0.16)) - discount
        }.merge(employee_info: employee_info(employee, sale))
          .merge(client_info: client_info(sale))
        hash.merge!(yield(sale)) if defined?(yield)
        hash
      end
    end.flatten
  end

  def add_sale_concepts
    report[:sale_concepts] = active_companies.map do |company|
      sales = company.sales
      sales.map do |sale|
        concepts = sale.sale_concepts
        concepts.map do |concept|
          concept.slice(*config_concepts_fields)
            .merge(
              total_before_taxes: concept.total.to_f,
              total: (concept.total.to_f + concept.total.to_f * 0.16),
              iva: concept.total.to_f
            ).deep_symbolize_keys
        end
      end
    end.flatten
  end

  private

  def address_fields
    user.address.slice(*config_address_fields)
  end

  def employee_info(employee, _sale)
    sales_info = {
      sales: employee.sales.size,
      id: employee.id,
      total_amount_sold_before_taxes: employee.sales.map(&:total).inject(:+).to_f,
      total_amount_sold: (employee.sales.map(&:total).inject(:+).to_f + (employee.sales.map(&:total).inject(:+) * 0.16)).to_f
    }
    address_info = address(employee)
    employee.slice(*config_employee_fields)
      .merge(sales_info)
      .merge(address_info)
      .symbolize_keys
  end

  def client_info(sale)
    client = sale.buyer
    purchases_info = {
      purchases: client.purchases.size,
      id: client.id,
      total_amount_purchased_before_taxes: total_bt(client).to_f,
      total_amount_purchased: (total_bt(client).to_f + (total_bt(client) * 0.16)).to_f
    }
    address_info = address(client)
    client.slice(*config_client_fields)
      .merge(purchases_info)
      .merge(address_info)
      .symbolize_keys
  end

  protected

  def total_bt(client)
    @total_bt ||= client.purchases.map(&:total).inject(:+).to_f
  end

  def address(obj)
    obj.address.slice(*config_address_fields)
  end
end
