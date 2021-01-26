class CompanyService 

  COMPANY_DECORATORS = {
    "Web Design Solutions": Companies::WebDesignCompanyDecorator,
    "IT Companies": Companies::ItCompanyDecorator
  }

  class << self
    def get_company(company_id)
      company_id = company_id.nil? ? Company.first.id : company_id
      company = Company.find(company_id)
      decorator = COMPANY_DECORATORS[company.company_type_name.to_sym]
      decorator.new(company)
    end
  end
end
