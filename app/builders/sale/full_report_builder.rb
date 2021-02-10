class Sale::FullReportBuilder < Sale::Builder
  def add_user_info
    reporter.add_user_info
  end

  def add_company_info
    reporter.add_company_info do |address|
      address.slice(*address_fields)
    end
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
    @sales_by_month = {}
    months = (get_start_date(@params).to_date..get_end_date(@params).to_date).map { |d| [d.strftime('%Y %B')] }.uniq
    months.delete_at(0) if @params[:start_date].nil? && @params[:end_date].nil?
    months.each { |month| @sales_by_month.store(month[0], [month[0], 0]) }
    sales = @active_companies.map { |company| company.sales.group_by { |s| s.total }.map { |key, val| [key.to_f, val[0][:created_at].strftime('%Y %B')]}}.flatten(1)
    get_sales_filtered(sales)
    @report.data[:charts] = {
      company_sales: @active_companies.map { |company| [company[:business_name], company.sales.size] },
      daily_sales: [@active_companies.map do |company| 
        company.sales.group_by { |sale| sale.created_at.strftime('%Y %b %m') }.map do |key, val| 
          [key, val.size]
        end
      end.flatten!],
      employee_sales: [@active_companies.map do |company| 
        company.sales.group_by { |sale| sale.seller_name }.map do |key, val| 
          [key, val.size]
        end
      end.flatten!],
      client_sales: [@active_companies.map do |company| 
        company.sales.group_by { |sale| sale.buyer_name }.map do |key, val| 
          [key, val.size]
        end
      end.flatten!],
      company_earnings: @sales_by_month.values
    }
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

  def get_start_date(params)
    params[:start_date].nil? ? Time.current.beginning_of_day - 6.months : Time.zone.parse(params[:start_date]).beginning_of_day
  end 

  def get_end_date(params)
    params[:end_date].nil? ? Time.current.end_of_day : Time.zone.parse(params[:end_date]).end_of_day
  end

  def get_sales_filtered(sales)
    sales.each do |total, date|  
      @sales_by_month[date][1] += total if @sales_by_month[date]
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
    %i[ri proof_of_address incorporation_act start_of_operation account_statement]
  end
end
