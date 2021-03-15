# frozen_string_literal: true

class Sales::DetailedReportBuilder < Sales::Builder
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
        discount: (sale.total > 800 ? (sale.total.to_f * 0.1) : 0),
        extra_fees: 0,
        sale_type: sale.sale_type
      }
    end
  end

  def add_sale_concepts
    reporter.add_sale_concepts
  end

  def add_charts
    report[:charts] = {}
  end

  def decorate
    Sales::DetailedReportDecorator.decorate(report)
  end

  attr_accessor :reporter, :user

  private

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

  def concepts_fields
    %i[id sale_id amount]
  end

  def employee_fields
    %i[name email]
  end

  def client_fields
    %i[name email phone]
  end
end
