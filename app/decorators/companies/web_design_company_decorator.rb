class Companies::WebDesignCompanyDecorator < Companies::BaseDecorator

  def name
    "
      <div class='background-image-1'>
        <h2>#{@object.business_name}</h2>
      </div>
    "
  end

  def company_description
    "
      <div class='description'>
        <div class='row'>
          <div class='col s6'>
            <span>  Rfc: <strong>#{object.rfc} </strong> </span> 
          </div>
          <div class='col s6'>
            <span>  Contact: <strong>#{object.contact} </strong> </span> 
          </div>
          <div class='col s6'>
            <span>  Email: <strong>#{object.email} </strong> </span> 
          </div>
          <div class='col s6'>
            <span>  Phone: <strong>#{object.phone} </strong> </span> 
          </div>
          <div class='col s6'>
            <span>  Fiscal Name: <strong>#{object.fiscal_name} </strong> </span> 
          </div>
        </div>
      </div>
    "
  end

  def company_details
    active = @object.active ? "<i class='material-icons'>done</i>" : "<i class='material-icons'>mood_bad</i>"
    "
      <div class='company-details'>
        <span class='company-active'>#{active}</span>
        <div class='company-type'>
          #{@object.company_type_name}
        </div>
        <span class='company-address'>
          #{[@object.address_street, @object.address_external_number, @object.address_city, @object.address_country].join(" ")}
        </span>
      </div>
    "
  end
end