# frozen_string_literal: true

class ChartsService
  def initialize(companies)
    @companies = companies
  end

  class << self
    def build(companies)
      charts = new(companies)
      charts.build_chart
    end
  end

  def build_chart
    @sales_by_month = {}
    build_sales_base_hash
    get_sales_filtered
    {
      company_sales: companies.map { |company| [company[:business_name], company.sales.size] },
      daily_sales: daily_sales,
      employee_sales: employee_sales,
      client_sales: client_sales,
      company_earnings: @sales_by_month.values
    }
  end

  attr_reader :companies

  private

  def build_months_array
    (get_start_date.to_date..get_end_date.to_date).map { |d| [d.strftime("%Y %B")] }.uniq
  end

  def build_sales_base_hash
    build_months_array.each { |month| @sales_by_month.store(month[0], [month[0], 0]) }
  end

  def get_sales_from_companies
    companies.map do |company|
      company.sales.group_by(&:total)
        .map { |key, val| [key.to_f, val[0][:created_at].strftime("%Y %B")] }
    end
      .flatten(1)
  end

  def daily_sales
    [companies.map do |company|
      company.sales.group_by { |sale| sale.created_at.strftime("%Y %b %m") }.map do |key, val|
        [key, val.size]
      end
    end.flatten!]
  end

  def employee_sales
    [companies.map do |company|
      company.sales.group_by(&:seller_name).map do |key, val|
        [key, val.size]
      end
    end].flatten(2)
  end

  def client_sales
    [companies.map do |company|
      company.sales.group_by(&:buyer_name).map do |key, val|
        [key, val.size]
      end
    end].flatten(2)
  end

  def get_start_date
    Time.current.beginning_of_day - 6.months
  end

  def get_end_date
    Time.current.end_of_day
  end

  def get_sales_filtered
    get_sales_from_companies.each do |total, date|
      @sales_by_month[date][1] += total if @sales_by_month[date]
    end
  end
end
