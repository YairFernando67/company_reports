module Report
  def self.add_user_info(user, report)
    address = user.address.slice(:street, :city, :state, :country)
    report.data[:user] = user.slice(:email, :name).merge(address)
  end

  def self.add_company_info(active_companies, report, &blk)
    report.data[:companies] = active_companies.map do |company|
      products = company.products
      hash = {
        business_name: company[:business_name],
        rfc: company[:rfc],
        email: company[:email],
        phone: company[:phone],
        contact: company[:contact],
        fiscal_name: company[:fiscal_name],
        created_at: company[:created_at],
        company_type: company.company_type_name,
        code: company.company_type_code,
        affiliation: company.company_type_affiliation,
        products: products.map do |product|
          { 
            id: product[:id],
            name: product[:name] ,
            price: product[:price],
            identifier: product[:uid]
          }
        end
      }
      hash.store(:address, blk.call(company)) if block_given?
      hash
    end
  end

  def self.add_sales(companies, company, i)
    sales = company.sales
    companies[i][:sales] = sales.map do |sale|
      {
        id: sale[:id],
        status: sale[:status],
        total_before_taxes: sale[:total].to_f,
        iva: (sale[:total].to_f * 0.16),
        ieps: '0%',
        discount: (sale[:total] > 800 ? (sale[:total].to_f * 0.1) : 0),
        extra_fees: 0,
        total: (sale[:total].to_f + (sale[:total].to_f * 0.16)) - (sale[:total] > 800 ? (sale[:total].to_f * 0.1) : 0),
        date: sale[:created_at].strftime('%b %Y %m'),
        sale_type: sale[:sale_type]
      }
    end
  end

  def self.add_sale_concepts(companies, company, i)
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

  def self.add_employee_info(companies, sale, i, j)
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

  def self.add_client_info(companies, sale, i, j)
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
end