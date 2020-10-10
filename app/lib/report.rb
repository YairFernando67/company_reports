module Report
  def self.add_user_info(user, report)
    address = user.address.slice(:street, :city, :state, :country)
    report.data[:user] = user.slice(:email, :name).merge(address)
  end
end