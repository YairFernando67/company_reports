class Purchase::SimpleReportBuilder < Purchase::Builder
  include Report 
  
  def initialize(user)
    @user = user
    @active_companies = @user.active_companies
    reset
  end

  def reset
    @report = Purchase::SimpleReport.new
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

  def add_purchases
    base_company_level do |companies, company, i|
      purchases = company.purchases
      companies[i][:purchases] = purchases.map do |purchase|
        {
          id: purchase[:id],
          status: purchase[:status],
          total_before_taxes: purchase[:total].to_f,
          total: purchase[:total].to_f * 0.16,
          seller_info: {},
          buyer_info: {},
          date: purchase[:created_at].strftime('%b %Y %m'),
          purchase_concepts: {}
        }
      end
    end
  end

  def add_purchase_concepts
    base_company_level do |companies, company, i|
      purchases = company.purchases
      purchases.each.with_index do |purchase, j|
        concepts = purchase.purchase_concepts
        companies[i][:purchases][j][:purchase_concepts] = concepts.map do |concept|
          {
            id: concept[:id],
            total: concept[:total].to_f,
            unit_price: concept[:unit_price],
            amount: concept[:amount]
          }
        end
      end
    end
  end

  def add_employee_info
    base_purchase_level do |companies, purchase, i, j|
      concepts = purchase.purchase_concepts
      concepts.each.with_index do |concept, l|
        companies[i][:purchases][j][:purchase_concepts][l][:employee_info] = {}
      end
    end
  end

  def add_client_info
    base_purchase_level do |companies, purchase, i, j|
      concepts = purchase.purchase_concepts
      concepts.each.with_index do |concept, l|
        companies[i][:purchases][j][:purchase_concepts][l][:client_info] = {}
      end
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

  def base_purchase_level(&blk)
    base_company_level do |companies, company, i|
      purchases = company.purchases
      purchases.each.with_index do |purchase, j|
        blk.call(companies, purchase, i, j)
      end
    end
  end
end