class Companies::ItCompanyDecorator < Companies::BaseDecorator
  def name
    "
      <div class='content'>
        <div class='background-image-2'></div>
        <h3>#{@object.business_name}</h3>
      </div>
    "
  end

  def company_description
    "
      <div class='general'>
        <span>  <i class='material-icons'>confirmation_number</i> #{object.rfc} </span> 
        <span>  <i class='material-icons'>mood</i> #{object.contact} </span> 
        <span>  <i class='material-icons'>email</i> #{object.email} </span> 
        <span>  <i class='material-icons'>local_phone</i> #{object.phone} </span> 
        <span>  <i class='material-icons'>business</i> #{object.fiscal_name} </span> 
      </div>
    "
  end

  def company_details
    active = @object.active ? "<i class='material-icons'>done_all</i>" : "<i class='material-icons'>mood_bad</i>"
    "
      <div class='company-address'>
        <strong>#{@object.company_type_name}</strong> |
        #{active}
        #{[@object.address_street, @object.address_external_number, @object.address_state, @object.address_city, @object.address_country].join(" ")}
        . All rights reserved 2021
      </div>
    "
  end
end