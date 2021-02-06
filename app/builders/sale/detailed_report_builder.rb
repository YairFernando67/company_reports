class Sale::DetailedReportBuilder < Sale::Builder
  include Report

  ADDRESS_ATTR = %i[street city state country external_number zip_code].freeze
  COMPANY_ATTR = %i[
    business_name 
    rfc 
    email 
    phone 
    contact 
    fiscal_name 
    created_at
    company_type
    code
    affiliation
  ].freeze
  PRODUCT_ATTR = %i[id name price identifier].freeze

  def initialize(user)
    @user = user
    @active_companies = @user.active_companies
    reset
  end

  def reset
    @report = {}
  end

  def report
    report = @report
    report
  end

  def add_user_info
    Report.add_user_info(@user, @report, ADDRESS_ATTR)
  end

  def add_company_info
    Report.add_company_info(@active_companies, @report, COMPANY_ATTR, PRODUCT_ATTR)
  end

  def add_company_fiscal_information
    base_company_level do |companies, company, i|
      companies[i][:fiscal_information] = company.fiscal_info.slice(:ri, :proof_of_address)
    end
  end

  def add_sales
    base_company_level do |companies, company, i|
      Report.add_sales(companies, company, i)
    end
  end

  def add_sale_concepts
    base_company_level do |companies, company, i|
      Report.add_sale_concepts(companies, company, i)
    end
  end

  def add_employee_info
    base_sale_level do |companies, sale, i, j|
      Report.add_employee_info(companies, sale, i, j)
    end
  end

  def add_client_info
    base_sale_level do |companies, sale, i, j|
      Report.add_client_info(companies, sale, i, j)
    end
  end

  def add_charts
    @report[:charts] = {}
  end

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
