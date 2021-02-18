class Reporter < ReporterBase
  def add_user_info
    report[:user] = user.slice(:email, :name).merge(address_fields).symbolize_keys
  end
  
  def add_company_info
    report[:companies] = active_companies.map do |company|
      company.slice(*config_company_fields).tap do |hash|
        products, fiscal_info = company.products, company.fiscal_info
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
        discount = (sale.total > 800) ? (sale.total.to_f * 0.1) : 0
        employee = sale.seller
        hash = {
          id: sale.id,
          company_name: sale.company_business_name,
          status: sale.status,
          total_before_taxes: sale.total.to_f,
          date: sale.created_at.strftime('%b %Y %m'),
          total: (sale.total.to_f + (sale.total.to_f * 0.16)) - discount
        }.merge(employee_info: employee_info(employee, sale))
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

  def add_client_info(companies, sale, i, j)
    client = sale.buyer
    purchases_info = {
      purchases: client.purchases.size,
      sale_id: sale.id,
      id: client.id,
      total_amount_purchased_before_taxes: client.purchases.map(&:total).inject(:+).to_f,
      total_amount_purchased: (client.purchases.map(&:total).inject(:+).to_f + (client.purchases.map(&:total).inject(:+) * 0.16)).to_f
    }
    address_info = client.address.slice(:street, :external_number, :country, :city, :state)   
    companies[i][:sales][j][:client_info] = client.slice(:name, :email)
                                                      .merge(purchases_info)
                                                      .merge(address_info)
    companies[i][:sales][j][:client_info] = companies[i][:sales][j][:client_info].symbolize_keys
  end

  private

  def address_fields
    user.address.slice(*config_address_fields)
  end

  def employee_info(employee, sale)
    sales_info = {
      sales:  employee.sales.size,
      id: employee.id,
      sale_id: sale.id,
      total_amount_sold_before_taxes: employee.sales.map(&:total).inject(:+).to_f,
      total_amount_sold: (employee.sales.map(&:total).inject(:+).to_f + (employee.sales.map(&:total).inject(:+) * 0.16)).to_f
    }
    address_info = employee.address.slice(*config_address_fields)
    employee.slice(*config_employee_fields)
            .merge(sales_info)
            .merge(address_info)
            .symbolize_keys
  end
end
