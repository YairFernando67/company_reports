class Sale::FullReportBuilder < Sale::Builder
  include Report
  
  def initialize(user, params={})
    @user = user
    @params = params
    @active_companies = @user.active_companies
    reset
  end

  def reset
    @report = Sale::FullReport.new
  end

  def report
    report = @report
    report
  end

  def add_user_info
    Report.add_user_info(@user, @report)
  end

  def add_company_info
    Report.add_company_info(@active_companies, @report) do |company|
      company.address.slice(:street, :country, :city, :state)
    end
  end

  def add_company_fiscal_information
    base_company_level do |companies, company, i|
      companies[i][:fiscal_information] = company.fiscal_info
                                                  .slice(:ri, :proof_of_address, 
                                                              :incorporation_act, 
                                                              :start_of_operation, 
                                                              :account_statement)
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
end