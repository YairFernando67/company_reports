# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Create Users
carl_admin = User.create(email: "carl@gmail.com", name: "carl", role: :admin, password: "password", password_confirmation: "password")
john_admin = User.create(email: "john@gmail.com", name: "john", role: :admin, password: "password", password_confirmation: "password")
rebeca_employee = User.create(email: "rebeca@gmail.com", name: "rebeca", role: :employee, password: "password", password_confirmation: "password")
jack_employee = User.create(email: "jack@gmail.com", name: "jack", role: :employee, password: "password", password_confirmation: "password")

# Create Users addressess
Address.create(street: 'Stark Street', external_number: "23", country: "USA", city: "Portland", state: "Oregon", addressable_type: "User", addressable_id: carl_admin.id)
Address.create(street: '82nd Avenue', external_number: "156", country: "USA", city: "Portland", state: "Oregon", addressable_type: "User", addressable_id: john_admin.id)
Address.create(street: 'Alberta District', external_number: "19", country: "USA", city: "Portland", state: "Oregon", addressable_type: "User", addressable_id: rebeca_employee.id)
Address.create(street: 'Cornell Road', external_number: "58", country: "USA", city: "Portland", state: "Oregon", addressable_type: "User", addressable_id: jack_employee.id)

# Create company types
company_type_one = CompanyType.create(name: "IT Companies", code: "001", affiliation: "FullTime")
company_type_two = CompanyType.create(name: "Web Design Solutions", code: "002", affiliation: "FullTime")

# Create one company per user
company_one = carl_admin.companies.create(business_name: "ServiceNow", rfc: "qwer9605066d6", email: "service_now@gmail.com", phone: "8547963215", active: true, contact: "Michelle Perl", fiscal_name: "Services Now TR", company_type_id: company_type_one.id)
company_two = carl_admin.companies.create(business_name: "ADP", rfc: "ERTY7406055F5", email: "adp_team@gmail.com", phone: "8547412548", active: true, contact: "Angel Phill", fiscal_name: "ADP", company_type_id: company_type_one.id)
company_three = john_admin.companies.create(business_name: "PayPal", rfc: "yuio8505065d5", email: "paypal@gmail.com", phone: "2541253698", active: true, contact: "Rachel Walcker", fiscal_name: "Paypal CO", company_type_id: company_type_two.id)
company_four = john_admin.companies.create(business_name: "Verizon", rfc: "tgyh8562364d", email: "verizon@gmail.com", phone: "7458965214", active: true, contact: "Emily Ino", fiscal_name: "Verizon SA", company_type_id: company_type_two.id)

# Create carriers for company one
carrier_one = company_one.carriers.create(name: "DHL Express", phone: "1-800-225-5345", email: "dhlservices@outlook.com", carrier_type: :national)
carrier_two = company_one.carriers.create(name: "FedEx", phone: "1-800-463-3339", email: "dhlservices@outlook.com", carrier_type: :international)
carrier_three = company_one.carriers.create(name: "Australia Post", phone: "61-3-8847-9045", email: "austpo@gmail.com", carrier_type: :international)
carrier_four = company_one.carriers.create(name: "DB Schenker", phone: "1-800-225-5229", email: "schenker_ser@gmail.com", carrier_type: :international)

# Create fiscal info records for each carrier of company one
FiscalInfo.create(ri: "8u7rjdur", account_statement: "content.xml", proof_of_address: "proof_of_address.pdf", incorporation_act: "incorporation_act.pdf", start_of_operation: DateTime.now - 5.years, fiscal_infoable_id: carrier_one.id, fiscal_infoable_type: "Carrier")
FiscalInfo.create(ri: "7d45e8dd", account_statement: "content.xml", proof_of_address: "proof_of_address.pdf", incorporation_act: "incorporation_act.pdf", start_of_operation: DateTime.now - 6.years, fiscal_infoable_id: carrier_two.id, fiscal_infoable_type: "Carrier")
FiscalInfo.create(ri: "sdfg8ujd", account_statement: "content.xml", proof_of_address: "proof_of_address.pdf", incorporation_act: "incorporation_act.pdf", start_of_operation: DateTime.now - 5.years, fiscal_infoable_id: carrier_three.id, fiscal_infoable_type: "Carrier")
FiscalInfo.create(ri: "4ey6ur7u", account_statement: "content.xml", proof_of_address: "proof_of_address.pdf", incorporation_act: "incorporation_act.pdf", start_of_operation: DateTime.now - 7.years, fiscal_infoable_id: carrier_four.id, fiscal_infoable_type: "Carrier")

# Create carriers for company three
carrier_five = company_three.carriers.create(name: "ECMS EXPRESS", phone: "1-855-266-9299", email: "ecms@gmail.com", carrier_type: :national)
carrier_six = company_three.carriers.create(name: "Fidelitone", phone: "1-844-524-6320", email: "fidelitone23@outlook.com", carrier_type: :national)
carrier_seven = company_three.carriers.create(name: "Hanjin Logistics", phone: "82-1588-1612", email: "hanjinlogic@gmail.com", carrier_type: :national)
carrier_eight = company_three.carriers.create(name: "LaserShip", phone: "1-804-414-2590", email: "lasership@gmail.com", carrier_type: :international)

# Create fiscal info records for each carrier of company three
FiscalInfo.create(ri: "jdhd8ehw", account_statement: "content.xml", proof_of_address: "proof_of_address.pdf", incorporation_act: "incorporation_act.pdf", start_of_operation: DateTime.now - 5.years, fiscal_infoable_id: carrier_five.id, fiscal_infoable_type: "Carrier")
FiscalInfo.create(ri: "ikws8due", account_statement: "content.xml", proof_of_address: "proof_of_address.pdf", incorporation_act: "incorporation_act.pdf", start_of_operation: DateTime.now - 6.years, fiscal_infoable_id: carrier_six.id, fiscal_infoable_type: "Carrier")
FiscalInfo.create(ri: "pqla0si3", account_statement: "content.xml", proof_of_address: "proof_of_address.pdf", incorporation_act: "incorporation_act.pdf", start_of_operation: DateTime.now - 5.years, fiscal_infoable_id: carrier_seven.id, fiscal_infoable_type: "Carrier")
FiscalInfo.create(ri: "mcjd8i3k", account_statement: "content.xml", proof_of_address: "proof_of_address.pdf", incorporation_act: "incorporation_act.pdf", start_of_operation: DateTime.now - 7.years, fiscal_infoable_id: carrier_eight.id, fiscal_infoable_type: "Carrier")

# Create Companies Addressess
Address.create(street: 'Centre Avenue', external_number: "77", country: "USA", city: "Reading", state: "Pensilvania", addressable_type: "Company", addressable_id: company_one.id)
Address.create(street: 'Franklin Street', external_number: "96", country: "USA", city: "Reading", state: "Pensilvania", addressable_type: "Company", addressable_id: company_two.id)
Address.create(street: 'Mineral Spring Road', external_number: "425", country: "USA", city: "Reading", state: "Pensilvania", addressable_type: "Company", addressable_id: company_three.id)
Address.create(street: 'Washington Street', external_number: "745", country: "USA", city: "Reading", state: "Pensilvania", addressable_type: "Company", addressable_id: company_four.id)

# Create Fiscal Information records for each company
FiscalInfo.create(ri: "tghy7452", account_statement: "content.xml", proof_of_address: "proof_of_address.pdf", incorporation_act: "incorporation_act.pdf", start_of_operation: DateTime.now - 2.years, fiscal_infoable_id: company_one.id, fiscal_infoable_type: "Company")
FiscalInfo.create(ri: "yhju8542", account_statement: "content.xml", proof_of_address: "proof_of_address.pdf", incorporation_act: "incorporation_act.pdf", start_of_operation: DateTime.now - 1.years, fiscal_infoable_id: company_two.id, fiscal_infoable_type: "Company")
FiscalInfo.create(ri: "ojkn8412", account_statement: "content.xml", proof_of_address: "proof_of_address.pdf", incorporation_act: "incorporation_act.pdf", start_of_operation: DateTime.now - 3.years, fiscal_infoable_id: company_three.id, fiscal_infoable_type: "Company")
FiscalInfo.create(ri: "ffsg9514", account_statement: "content.xml", proof_of_address: "proof_of_address.pdf", incorporation_act: "incorporation_act.pdf", start_of_operation: DateTime.now - 4.years, fiscal_infoable_id: company_four.id, fiscal_infoable_type: "Company")

# Create products for company one
product_one = company_one.products.create(name: "Computer", price: "750", uid: SecureRandom.uuid)
product_two = company_one.products.create(name: "Mouse", price: "250", uid: SecureRandom.uuid)
product_three = company_one.products.create(name: "Laptop", price: "1100", uid: SecureRandom.uuid)

# Create products for company two
product_four = company_two.products.create(name: "WebService", price: "900", uid: SecureRandom.uuid)

# Create products for company three
product_five = company_three.products.create(name: "Web app", price: "5000", uid: SecureRandom.uuid)
product_six = company_three.products.create(name: "Training Courses", price: "4500", uid: SecureRandom.uuid)
product_seven = company_three.products.create(name: "Coaching", price: "1500", uid: SecureRandom.uuid)

# Create products for company four
product_eight = company_four.products.create(name: "IT Consulting", price: "2100", uid: SecureRandom.uuid)

# Create clients
client_amanda = Client.create(name: "Amanda", email: "amanda@gmail.com", phone: "7452145698")
client_emma = Client.create(name: "Emma", email: "emma@gmail.com", phone: "5214589744")
client_olivia = Client.create(name: "Olivia", email: "olivia@gmail.com", phone: "1254784521")

# Create client's addressess
Address.create(street: 'Hartford Avenue', external_number: "250", country: "USA", city: "Boston", state: "Massachusetts ", addressable_type: "Client", addressable_id: client_amanda.id)
Address.create(street: 'Thruway Plaza', external_number: "105", country: "USA", city: "Lowell", state: "Massachusetts", addressable_type: "Client", addressable_id: client_emma.id)
Address.create(street: 'Oak Street', external_number: "547", country: "USA", city: "Brockton", state: "Massachusetts", addressable_type: "Client", addressable_id: client_olivia.id)

# Create sales for company one
sale_one = Sale.create(company_id: company_one.id, seller_id: rebeca_employee.id, buyer_id: client_amanda.id, total: 1000, status: :completed, sale_type: "IT")
sale_two = Sale.create(company_id: company_one.id, seller_id: rebeca_employee.id, buyer_id: client_emma.id, total: 500, status: :completed, sale_type: "IT")
sale_three = Sale.create(company_id: company_one.id, seller_id: jack_employee.id, buyer_id: client_emma.id, total: 1350, status: :completed, sale_type: "IT")

# Create sale concepts for sale one
sale_one.sale_concepts.create(unit_price: "750", total: "750", amount: "1", product_id: product_one.id)
sale_one.sale_concepts.create(unit_price: "250", total: "250", amount: "1", product_id: product_two.id)

# Create sale concepts for sale two
sale_two.sale_concepts.create(unit_price: "250", total: "500", amount: "2", product_id: product_two.id)

# Create sale concepts for sale three
sale_three.sale_concepts.create(unit_price: "250", total: "250", amount: "1", product_id: product_two.id)
sale_three.sale_concepts.create(unit_price: "1100", total: "1100", amount: "1", product_id: product_three.id)

# Create sales for company three
sale_four = Sale.create(company_id: company_three.id, seller_id: jack_employee.id, buyer_id: client_olivia.id, total: 14500, status: :completed, sale_type: "IT")
sale_five = Sale.create(company_id: company_three.id, seller_id: rebeca_employee.id, buyer_id: client_olivia.id, total: 12000, status: :completed, sale_type: "IT")
sale_six = Sale.create(company_id: company_three.id, seller_id: jack_employee.id, buyer_id: client_emma.id, total: 22000, status: :completed, sale_type: "IT")

# Create sale concepts for sale four
sale_four.sale_concepts.create(unit_price: "5000", total: "10000", amount: "2", product_id: product_five.id)
sale_four.sale_concepts.create(unit_price: "4500", total: "4500", amount: "1", product_id: product_six.id)

# Create sale concepts for sale five
sale_five.sale_concepts.create(unit_price: "4500", total: "9000", amount: "2", product_id: product_six.id)
sale_five.sale_concepts.create(unit_price: "1500", total: "3000", amount: "2", product_id: product_seven.id)

# Create sale concepts for sale six
sale_six.sale_concepts.create(unit_price: "5000", total: "10000", amount: "2", product_id: product_five.id)
sale_six.sale_concepts.create(unit_price: "4500", total: "9000", amount: "2", product_id: product_six.id)
sale_six.sale_concepts.create(unit_price: "1500", total: "3000", amount: "2", product_id: product_seven.id)

# Create shipment for sale_one
shipment_one = Shipment.create(sale_id: sale_one.id, user_id: rebeca_employee.id, client_id: client_amanda.id, instructions: "Deliver this package to the front door of the house, and wrap the computer and mouse in a blue box.", status: :accepted, total_products: 2, sale_number:  "SG-38G", issued_at: Time.now, shiped_at: Time.now + 3.days)

# Create shipment address
Address.create(street: 'Russell St', external_number: "854", country: "USA", city: "Amsterdam", state: "NY", addressable_type: "Shipment", addressable_id: shipment_one.id)

# Create carriers for this shipment
ShipmentCarrier.create(shipment_id: shipment_one.id, carrier_id: company_one.carriers.first.id)
ShipmentCarrier.create(shipment_id: shipment_one.id, carrier_id: company_one.carriers.second.id)

# Create shipment for sale_two
shipment_two = Shipment.create(sale_id: sale_two.id, user_id: rebeca_employee.id, client_id: client_emma.id, instructions: "Wrap the mouse in a black box.", status: :completed, total_products: 1, sale_number:  "SG-39F", issued_at: Time.now, shiped_at: Time.now + 10.minutes)

# Create shipment address
Address.create(street: 'Brockport Spencerport Rd', external_number: "968", country: "USA", city: "Brockport", state: "NY", addressable_type: "Shipment", addressable_id: shipment_two.id)

# Create carriers for this shipment
ShipmentCarrier.create(shipment_id: shipment_two.id, carrier_id: company_one.carriers.third.id)

# Create shipment for sale_three
shipment_three = Shipment.create(sale_id: sale_three.id, user_id: jack_employee.id, client_id: client_emma.id, instructions: "Laptop and mouse in a slim package.", status: :pending, total_products: 2, sale_number:  "SG-45AF", issued_at: Time.now + 1.day)

# Create shipment address
Address.create(street: 'East Ave', external_number: "3018", country: "USA", city: "Central Square", state: "NY", addressable_type: "Shipment", addressable_id: shipment_three.id)

# Create carriers for this shipment
ShipmentCarrier.create(shipment_id: shipment_three.id, carrier_id: company_one.carriers.third.id)
ShipmentCarrier.create(shipment_id: shipment_three.id, carrier_id: company_one.carriers.last.id)

# Create shipment for sale_four
shipment_four = Shipment.create(sale_id: sale_four.id, user_id: jack_employee.id, client_id: client_olivia.id, instructions: "Send manuals and login info for the platform.", status: :blocked, total_products: 2, sale_number:  "SG-99D")

# Create shipment address
Address.create(street: 'Thruway Plaza', external_number: "14225", country: "USA", city: "Cheektowaga", state: "NY", addressable_type: "Shipment", addressable_id: shipment_four.id)

# Create carriers for this shipment
ShipmentCarrier.create(shipment_id: shipment_four.id, carrier_id: company_three.carriers.first.id)
ShipmentCarrier.create(shipment_id: shipment_four.id, carrier_id: company_three.carriers.second.id)
ShipmentCarrier.create(shipment_id: shipment_four.id, carrier_id: company_three.carriers.last.id)

# Create shipment for sale_five
shipment_five = Shipment.create(sale_id: sale_five.id, user_id: rebeca_employee.id, client_id: client_olivia.id, instructions: "Send couching program, manuals and login info.", status: :progress, total_products: 2, sale_number:  "SG-52F", issued_at: Time.now + 5.hours, shiped_at: Time.now + 2.days)

# Create shipment address
Address.create(street: 'Troy Road', external_number: "254", country: "USA", city: "East Greenbush", state: "NY", addressable_type: "Shipment", addressable_id: shipment_five.id)

# Create carriers for this shipment
ShipmentCarrier.create(shipment_id: shipment_five.id, carrier_id: company_three.carriers.third.id)
ShipmentCarrier.create(shipment_id: shipment_five.id, carrier_id: company_three.carriers.second.id)

# Create shipment for sale_six
shipment_six = Shipment.create(sale_id: sale_six.id, user_id: jack_employee.id, client_id: client_emma.id, instructions: "Send couching program, platform uri, manuals and login info.", status: :completed, total_products: 3, sale_number:  "SG-72W", issued_at: Time.now + 2.hours, shiped_at: Time.now + 1.days)

# Create shipment address
Address.create(street: 'State Route 3', external_number: "8542", country: "USA", city: "Fulton", state: "NY", addressable_type: "Shipment", addressable_id: shipment_six.id)

# Create carriers for this shipment
ShipmentCarrier.create(shipment_id: shipment_six.id, carrier_id: company_three.carriers.third.id)
ShipmentCarrier.create(shipment_id: shipment_six.id, carrier_id: company_three.carriers.last.id)