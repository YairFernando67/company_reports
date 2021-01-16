class CompanyService 

  COMPANT_DECORATORS = {
    "Web Design Solutions": Companies::WebDesignCompanyDecorator,
    "IT Companies": Companies::ItCompanyDecorator
  }

  class << self
    def get_companies
      decorated_companies = []
      @companies = Company.all
      @companies.each do |company|
        if company.company_type_name == "Web Design Solutions"
          
        else

        end
      end
    end

    def get_company(company_id)
      company = Company.find(company_id)
      decorator = COMPANT_DECORATORS[company.company_type_name.to_sym]
      decorator.new(company)
    end
  end
end