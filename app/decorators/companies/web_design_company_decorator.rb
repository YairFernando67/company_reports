class Companies::WebDesignCompanyDecorator < Companies::BaseDecorator

  def name
    "
      <div class='background-image-1'>
        <h2>#{@company.business_name}</h2>
      </div>
    "
  end

  def company_description
    "
      <div class='description'>
        <div class='row'>
          <div class='col s6'>
            <span>  Rfc: <strong>#{company.rfc} </strong> </span> 
          </div>
          <div class='col s6'>
            <span>  Contact: <strong>#{company.contact} </strong> </span> 
          </div>
          <div class='col s6'>
            <span>  Email: <strong>#{company.email} </strong> </span> 
          </div>
          <div class='col s6'>
            <span>  Phone: <strong>#{company.phone} </strong> </span> 
          </div>
          <div class='col s6'>
            <span>  Fiscal Name: <strong>#{company.fiscal_name} </strong> </span> 
          </div>
        </div>
      </div>
    "
  end

  def company_details
    active = @company.active ? "<i class='material-icons'>done</i>" : "<i class='material-icons'>mood_bad</i>"
    "
      <div class='company-details'>
        <span class='company-active'>#{active}</span>
        <div class='company-type'>
          #{@company.company_type_name}
        </div>
        <span class='company-address'>
          #{[@company.address_street, @company.address_external_number, @company.address_city, @company.address_country].join(" ")}
        </span>
      </div>
    "
  end
end