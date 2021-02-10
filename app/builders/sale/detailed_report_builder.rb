class Sale::DetailedReportBuilder < Sale::Builder
  def add_user_info
    reporter.add_user_info
  end

  def add_company_info
    reporter.add_company_info
  end

  def add_sales
    reporter.add_sales do |sale|
      {
        iva: (sale.total.to_f * 0.16),
        ieps: '0%',
        discount: (sale.total > 800 ? (sale.total.to_f * 0.1) : 0),
        extra_fees: 0,
        total: (sale.total.to_f + (sale.total.to_f * 0.16)) - (sale.total > 800 ? (sale.total.to_f * 0.1) : 0),
        date: sale.created_at.strftime('%b %Y %m'),
        sale_type: sale.sale_type
      }
    end
  end

  def add_sale_concepts
    binding.pry
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
    %i[
        business_name 
        rfc 
        email 
        phone 
        contact 
        fiscal_name 
        created_at
        company_type_name
        company_type_code
        company_type_affiliation
    ]
  end

  def address_fields
    %i[street city state country external_number zip_code]
  end

  def product_fields
    %i[id name price uid]
  end

  def fiscal_fields
    %i[ri proof_of_address]
  end
end
