class Companies::ItCompanyDecorator < Companies::BaseDecorator
  def name
    "
      <div class='content'>
        <div class='background-image-2'></div>
        <h3>#{@company.business_name}</h3>
      </div>
    "
  end

  def company_description
    "
      <div class='general'>
        <span>  <i class='material-icons'>confirmation_number</i> #{company.rfc} </span> 
        <span>  <i class='material-icons'>mood</i> #{company.contact} </span> 
        <span>  <i class='material-icons'>email</i> #{company.email} </span> 
        <span>  <i class='material-icons'>local_phone</i> #{company.phone} </span> 
        <span>  <i class='material-icons'>business</i> #{company.fiscal_name} </span> 
      </div>
    "
  end

  def company_details
    active = @company.active ? "<i class='material-icons'>done_all</i>" : "<i class='material-icons'>mood_bad</i>"
    "
      <div class='company-address'>
        <strong>#{@company.company_type_name}</strong> |
        #{active}
        #{[@company.address_street, @company.address_external_number, @company.address_state, @company.address_city, @company.address_country].join(" ")}
        . All rights reserved 2021
      </div>
    "
  end
end