class Sale::SimpleReportBuilder < Sale::Builder
  def add_user_info
    reporter.add_user_info
  end

  def add_company_info
    reporter.add_company_info
  end

  def add_sales
    reporter.add_sales
  end

  def add_sale_concepts
    reporter.add_sale_concepts
  end

  def add_employee_info
    binding.pry
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

  attr_accessor :reporter, :user

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

  def company_fields
    %i[business_name rfc email phone contact]
  end

  def address_fields
    %i[street city state]
  end

  def product_fields
    %i[id name price]
  end

  def fiscal_fields
    %i[]
  end

  def concepts_fields
    %i[id sale_id]
  end

  def employee_fields
    %i[name]
  end
end
