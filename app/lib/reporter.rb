class Reporter
  @@config = {}

  def set_config(company_fields:, address_fields:, product_fields:, fiscal_fields:)
    @@config[object_id][:company_fields] = company_fields.map(&:to_sym)
    @@config[object_id][:address_fields] = address_fields.map(&:to_sym)
    @@config[object_id][:product_fields] = product_fields.map(&:to_sym)
    @@config[object_id][:fiscal_fields] = fiscal_fields.map(&:to_sym)
  end

  def initialize(user, active_companies, report= {})
    @user = user
    @report = report
    @active_companies = active_companies
    @@config[object_id] = {}
  end

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
        {
          id: sale.id,
          company_name: sale.company_business_name,
          status: sale.status,
          total_before_taxes: sale.total.to_f,
          date: sale.created_at.strftime('%b %Y %m'),
        }.merge(yield(sale))
      end
    end.flatten
  end

  def add_sale_concepts(companies, company, i)
    sales = company.sales
    sales.each.with_index do |sale, j|        
      concepts = sale.sale_concepts
      companies[i][:sales][j][:sale_concepts] = concepts.map do |concept|
        {
          id: concept[:id],
          sale_id: concept[:sale_id],
          total_before_taxes: concept[:total].to_f,
          total: (concept[:total].to_f + (concept[:total].to_f * 0.16)),
          unit_price: concept[:unit_price],
          amount: concept[:amount],
          iva: (concept[:total].to_f * 0.16),
          ieps: '0%'
        }
      end
    end
  end

  def add_employee_info(companies, sale, i, j)
    employee = sale.seller
    sales_info = {
      sales:  employee.sales.size,
      id: employee.id,
      sale_id: sale.id,
      total_amount_sold_before_taxes: employee.sales.map(&:total).inject(:+).to_f,
      total_amount_sold: (employee.sales.map(&:total).inject(:+).to_f + (employee.sales.map(&:total).inject(:+) * 0.16)).to_f
    }      
    address_info = employee.address.slice(:street, :external_number, :country, :city, :state)
    companies[i][:sales][j][:employee_info] = employee.slice(:name, :email)
                                                          .merge(sales_info)
                                                          .merge(address_info)
    companies[i][:sales][j][:employee_info] = companies[i][:sales][j][:employee_info].symbolize_keys
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

  attr_accessor :report
  attr_reader :user, :active_companies
  private


  def address_fields
    user.address.slice(*config_address_fields)
  end

  def config_company_fields
    @@config[object_id][:company_fields]
  end

  def config_product_fields
    @@config[object_id][:product_fields]
  end

  def config_address_fields
    @@config[object_id][:address_fields]
  end

  def config_fiscal_fields
    @@config[object_id][:fiscal_fields]
  end

end
