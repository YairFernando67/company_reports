# frozen_string_literal: true

module Report
  class Base
    @@config = {}

    def set_config(company_fields:, address_fields:, product_fields:, fiscal_fields:, concepts_fields:, employee_fields:, client_fields:)
      @@config[object_id][:company_fields] = company_fields.map(&:to_sym)
      @@config[object_id][:address_fields] = address_fields.map(&:to_sym)
      @@config[object_id][:product_fields] = product_fields.map(&:to_sym)
      @@config[object_id][:fiscal_fields] = fiscal_fields.map(&:to_sym)
      @@config[object_id][:fiscal_fields] = fiscal_fields.map(&:to_sym)
      @@config[object_id][:concepts_fields] = concepts_fields.map(&:to_sym)
      @@config[object_id][:employee_fields] = employee_fields.map(&:to_sym)
      @@config[object_id][:client_fields] = client_fields.map(&:to_sym)
    end

    def initialize(user, active_companies, report={})
      @user = user
      @report = report
      @active_companies = active_companies
      @@config[object_id] = {}
    end

    attr_accessor :report
    attr_reader :user, :active_companies

    private

    def config_company_fields
      @@config[object_id][:company_fields]
    end

    def config_product_fields
      @@config[object_id][:product_fields]
    end

    def config_address_fields
      @@config[object_id][:address_fields]
    end

    def config_fiscal_fields
      @@config[object_id][:fiscal_fields]
    end

    def config_concepts_fields
      @@config[object_id][:concepts_fields]
    end

    def config_employee_fields
      @@config[object_id][:employee_fields]
    end

    def config_client_fields
      @@config[object_id][:client_fields]
    end
  end
end
