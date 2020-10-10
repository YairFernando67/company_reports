class Purchase::SimpleReportBuilder < Purchase::Builder
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
    address = @user.address.slice(:street, :city, :state, :country)
    @report.data[:user] = @user.slice(:email, :name).merge(address)
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
    companies = @report.data[:companies]
    @active_companies.each.with_index do |company, i|
      products = company.products
      binding.pry
      companies[i][:purchases] = []
      products.each do |product|
        purchases = product.purchases
        companies[i][:purchases] += purchases.map do |purchase|
          {
            id: purchase[:id],
            status: purchase[:status],
            total: purchase[:total].to_f,
          }
        end
      end
    end
  end

  def add_purchase_concepts
    binding.pry
    # @concepts = []
    # @active_companies.each.with_index do |company, i|
    #   @concepts << company.purchase_concepts.map do |purchase_concept|
    #     {
    #       unit_price: purchase_concept[:unit_price],
    #       amount: purchase_concept[:amount],
    #       total: purchase_concept[:total],
    #     }
    #   end
    # end
    binding.pry
  end
end