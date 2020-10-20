class Sale::SimpleReportBuilder < Sale::Builder
  include Report 

  def initialize(user)
    @user = user
    @active_companies = @user.active_companies
    reset
  end

  def reset
    @report = Sale::SimpleReport.new
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
        products: products.map do |product|
          { 
            id: product[:id],
            name: product[:name] ,
            price: product[:price]
          }
        end
      }
    end
  end

  def add_company_fiscal_information
    @report.data[:companies].each do |company|
      company[:fiscal_information] = nil
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
          total: sale[:total].to_f + (sale[:total].to_f * 0.16),
          date: sale[:created_at].strftime('%b %Y %m'),
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
            sale_id: concept[:sale_id],
            total: concept[:total].to_f,
            unit_price: concept[:unit_price],
            amount: concept[:amount]
          }
        end
      end
    end
  end

  def add_employee_info
    base_sale_level do |companies, purchase, i, j|
      companies[i][:sales][j][:employee_info] = {}
    end
  end

  def add_client_info
    base_sale_level do |companies, purchase, i, j|
      companies[i][:sales][j][:client_info] = {}
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