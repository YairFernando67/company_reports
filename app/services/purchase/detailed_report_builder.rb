class Purchase::DetailedReportBuilder < Purchase::Builder
  include Report

  def initialize(user)
    @user = user
    @active_companies = @user.active_companies
    reset
  end

  def reset
    @report = Purchase::DetailedReport.new
  end

  def report
    report = @report
    report
  end

  def add_user_info
    Report.add_user_info(@user, @report)
  end

  def add_company_info
    @report.data[:companies] = @active_companies.map do |company|
      products = company.products
      {
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
    end
  end

  def add_company_fiscal_information
    base_company_level do |companies, company, i|
      companies[i][:fiscal_information] = company.fiscal_info.slice(:ri, :proof_of_address)
    end
  end

  def add_sales
    base_company_level do |companies, company, i|
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
  end

  def add_sale_concepts
    base_company_level do |companies, company, i|
      sales = company.sales
      sales.each.with_index do |sale, j|        
        concepts = sale.sale_concepts
        companies[i][:sales][j][:sale_concepts] = concepts.map do |concept|
          {
            id: concept[:id],
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
  end

  def add_employee_info
    base_sale_level do |companies, sale, i, j|
      employee = sale.seller
      sales_info = {
        sales:  employee.sales.size,
        total_amount_sold_before_taxes: employee.sales.map(&:total).inject(:+).to_f,
        total_amount_sold: (employee.sales.map(&:total).inject(:+).to_f + (employee.sales.map(&:total).inject(:+) * 0.16)).to_f
      }      
      address_info = employee.address.slice(:street, :external_number, :country, :city, :state)
      companies[i][:sales][j][:employee_info] = employee.slice(:name, :email)
                                                            .merge(sales_info)
                                                            .merge(address_info)
    end
  end

  def add_client_info
    base_sale_level do |companies, sale, i, j|
      client = sale.buyer
      purchases_info = {
        purchases:  client.purchases.size,
        total_amount_purchased_before_taxes: client.purchases.map(&:total).inject(:+).to_f,
        total_amount_sold: (client.purchases.map(&:total).inject(:+).to_f + (client.purchases.map(&:total).inject(:+) * 0.16)).to_f
      }
      address_info = client.address.slice(:street, :external_number, :country, :city, :state)   
      companies[i][:sales][j][:client_info] = client.slice(:name, :email)
                                                        .merge(purchases_info)
                                                        .merge(address_info)
    end
  end

  def add_charts
    @report.data[:charts] = {}
  end

  private

  def base_company_level(&blk)
    companies = @report.data[:companies]
    @active_companies.each.with_index do |company, i|
      blk.call(companies, company, i)
    end
  end

  def base_sale_level(&blk)
    base_company_level do |companies, company, i|
      sales = company.sales
      sales.each.with_index do |sale, j|
        blk.call(companies, sale, i, j)
      end
    end
  end
end