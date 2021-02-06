class Sale::SimpleReportBuilder < Sale::Builder
  include Report 

  ADDRESS_ATTR = %i[street city state].freeze
  COMPANY_ATTR = %i[business_name rfc email phone contact].freeze
  PRODUCT_ATTR = %i[id name price].freeze

  def initialize(user)
    @user = user
    @active_companies = @user.active_companies
    @report = {}
  end

  def add_user_info
    Report.add_user_info(@user, @report, ADDRESS_ATTR)
  end

  def add_company_info
    Report.add_company_info(@active_companies, @report, COMPANY_ATTR, PRODUCT_ATTR)
  end

  def add_company_fiscal_information
    binding.pry
    @report[:companies].each do |company|
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
    @report[:charts] = {}
  end

  attr_accessor :report

  private

  def base_company_level(&blk)
    companies = @report[:companies]
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
