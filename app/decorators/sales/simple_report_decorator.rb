class Sales::SimpleReportDecorator < BaseDecorator
  include BuilderHelper
  def user_info
    "
      <div class='row light-blue darken-two'>
        <div class='col s12'>
          <ul class='user-info'>
            <li><strong>Name:</strong> #{user_name} </li>
            <li><strong>Email:</strong> #{user_email} </li>
            <li><strong>Address:</strong> #{user_address_street} #{user_address_city} #{user_address_state} </li>
          </ul>
        </div>
      </div>
    "
  end

  alias report hash
end
