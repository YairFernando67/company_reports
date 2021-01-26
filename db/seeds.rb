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

# Create dirvers for carrier_one
driver_one = carrier_one.drivers.create(name: "Anderson", last_name: "Smith", email: "anderson32@gmail.com", phone: "903-251-4122", driver_number: "D-25G", status: "active", licence_number: "F255-921-50-094-0")
driver_two = carrier_one.drivers.create(name: "Thomas", last_name: "Williams", email: "thomas@gmail.com", phone: "307-635-3924", driver_number: "R-65T", status: "suspended", licence_number: "G980-955-46-845-2")
driver_three = carrier_one.drivers.create(name: "Lee", last_name: "Johnson", email: "lee@hotmail.com", phone: "619-899-9070", driver_number: "U-65W", status: "expired", licence_number: "F111-910-23-945-0")

# Create dirvers for carrier_two
driver_four = carrier_two.drivers.create(name: "Hall", last_name: "Brown", email: "hall34@gmail.com", phone: "453-251-3384", driver_number: "G-36G", status: "active", licence_number: "G857-857-50-645-2")
driver_five = carrier_two.drivers.create(name: "Harris", last_name: "Jones", email: "harris445@gmail.com", phone: "203-945-2324", driver_number: "F-34T", status: "cancelled", licence_number: "G918-8736-33-845-1")

# Create dirvers for carrier_three
driver_six = carrier_three.drivers.create(name: "Martin", last_name: "Garcia", email: "martin@outlook.com", phone: "938-251-4122", driver_number: "S-85E", status: "active", licence_number: "G854-837-22-129-3")
driver_seven = carrier_three.drivers.create(name: "Wilson", last_name: "Miller", email: "wilson23@gmail.com", phone: "307-729-3924", driver_number: "C-87Q", status: "suspended", licence_number: "G990-039-94-545-9")
driver_eight = carrier_three.drivers.create(name: "Nelson", last_name: "Davis", email: "nelson_41@hotmail.com", phone: "619-899-9902", driver_number: "Q-78W", status: "expired", licence_number: "D542-910-23-938-4")
driver_nine = carrier_three.drivers.create(name: "Evans", last_name: "Rodriguez", email: "evan@hotmail.com", phone: "120-899-847", driver_number: "F-85P", status: "denied", licence_number: "R654-910-85-945-7")

# Create dirvers for carrier_four
driver_ten = carrier_four.drivers.create(name: "Daniel", last_name: "Martinez", email: "danile_mart@gmail.com", phone: "951-854-3384", driver_number: "Y-99Y", status: "active", licence_number: "S654-857-51-412-2")
driver_eleven = carrier_four.drivers.create(name: "Donald", last_name: "Hernandez", email: "donald02@gmail.com", phone: "365-945-9541", driver_number: "P-98O", status: "limited", licence_number: "Q951-7458-33-753-2")

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

# Create dirvers for carrier_five
driver_twelve = carrier_five.drivers.create(name: "Ronald", last_name: "Lewis", email: "ronald@gmail.com", phone: "951-541-9856", driver_number: "F-65", status: "active", licence_number: "F123-921-50-094-0")
driver_thirteen = carrier_five.drivers.create(name: "Parker", last_name: "Thompson", email: "parker@gmail.com", phone: "159-145-6589", driver_number: "H-95T", status: "suspended", licence_number: "G456-955-46-845-4")
driver_fourteen = carrier_five.drivers.create(name: "Edwards", last_name: "Martin", email: "edwards@hotmail.com", phone: "753-569-6523", driver_number: "U-74Q", status: "expired", licence_number: "H789-910-23-945-3")

# Create dirvers for carrier_six
driver_fifteen = carrier_six.drivers.create(name: "Collins", last_name: "Jackson", email: "collins23@gmail.com", phone: "357-965-3256", driver_number: "P-87R", status: "active", licence_number: "I852-857-50-645-2")
driver_sixteen = carrier_six.drivers.create(name: "Michelle", last_name: "Moore", email: "michelle09@gmail.com", phone: "741-547-5412", driver_number: "F-54C", status: "cancelled", licence_number: "J741-8736-33-845-1")

# Create dirvers for carrier_seven
driver_seventeen = carrier_seven.drivers.create(name: "Laura", last_name: "Taylor", email: "laura66@outlook.com", phone: "147-745-2145", driver_number: "Z-85E", status: "active", licence_number: "K963-837-22-129-9")
driver_eighteen = carrier_seven.drivers.create(name: "Sarah", last_name: "Thomas", email: "sarah@gmail.com", phone: "963-987-8745", driver_number: "C-99Z", status: "suspended", licence_number: "L159-039-94-545-8")
driver_nineteen = carrier_seven.drivers.create(name: "Kimberly", last_name: "Anderson", email: "kim@hotmail.com", phone: "369-789-8745", driver_number: "Q-54A", status: "expired", licence_number: "M214-910-23-938-7")
driver_twenty = carrier_seven.drivers.create(name: "Deborah", last_name: "Wilson", email: "deborah@hotmail.com", phone: "987-654-5122", driver_number: "A-85P", status: "denied", licence_number: "N963-910-85-945-6")

# Create dirvers for carrier_eight
driver_twenty_one = carrier_eight.drivers.create(name: "Carter", last_name: "Gonzalez", email: "carter@gmail.com", phone: "789-456-2214", driver_number: "B-99Y", status: "active", licence_number: "O745-857-51-412-5")
driver_twenty_two = carrier_eight.drivers.create(name: "Scott", last_name: "Lopez", email: "scott@gmail.com", phone: "123-321-9541", driver_number: "C-98O", status: "limited", licence_number: "P985-7458-33-753-4")

# Create Drivers Addressess
Address.create(street: 'Carraway Cutoff', external_number: "951", country: "USA", city: "Crawfordville", state: "Florida", addressable_type: "Driver", addressable_id: driver_one.id)
Address.create(street: 'Deen Still Rd', external_number: "159", country: "USA", city: "Davenport", state: "Florida", addressable_type: "Driver", addressable_id: driver_two.id)
Address.create(street: 'Keith Ct', external_number: "357", country: "USA", city: "Gretna", state: "Florida", addressable_type: "Driver", addressable_id: driver_three.id)
Address.create(street: 'Ravenna Blvd', external_number: "754", country: "USA", city: "Naples", state: "Florida", addressable_type: "Driver", addressable_id: driver_four.id)
Address.create(street: 'Lydia St', external_number: "95", country: "USA", city: "Lake Wales", state: "Florida", addressable_type: "Driver", addressable_id: driver_five.id)
Address.create(street: 'Cobblefield Cir', external_number: "365", country: "USA", city: "Apopka", state: "Florida", addressable_type: "Driver", addressable_id: driver_six.id)

Address.create(street: 'N 114th Ave', external_number: "12", country: "USA", city: "Youngtown", state: "Arizona", addressable_type: "Driver", addressable_id: driver_seven.id)
Address.create(street: 'Po Box 2530', external_number: "955", country: "USA", city: "Snowflake", state: "Arizona", addressable_type: "Driver", addressable_id: driver_eight.id)
Address.create(street: 'W Ironwood Dr', external_number: "745", country: "USA", city: "Peoria", state: "Arizona", addressable_type: "Driver", addressable_id: driver_nine.id)
Address.create(street: 'W Dunlap Ave', external_number: "632", country: "USA", city: "Phoenix", state: "Arizona", addressable_type: "Driver", addressable_id: driver_ten.id)
Address.create(street: 'Rr 1', external_number: "125", country: "USA", city: "Duncan", state: "Arizona", addressable_type: "Driver", addressable_id: driver_eleven.id)

Address.create(street: 'W Erie St #6', external_number: "965", country: "USA", city: "Jefferson", state: "Ohio", addressable_type: "Driver", addressable_id: driver_twelve.id)
Address.create(street: 'S 6th St', external_number: "854", country: "USA", city: "Coshocton", state: "Ohio", addressable_type: "Driver", addressable_id: driver_thirteen.id)
Address.create(street: 'Park Dr', external_number: "521", country: "USA", city: "Campbell", state: "Ohio", addressable_type: "Driver", addressable_id: driver_fourteen.id)
Address.create(street: 'E Water St', external_number: "632", country: "USA", city: "Urbana", state: "Ohio", addressable_type: "Driver", addressable_id: driver_fifteen.id)
Address.create(street: 'Albright Mckay Rd NE', external_number: "996", country: "USA", city: "Brookfield", state: "Ohio", addressable_type: "Driver", addressable_id: driver_sixteen.id)
Address.create(street: 'Addison Rd', external_number: "88", country: "USA", city: "Masury", state: "Ohio", addressable_type: "Driver", addressable_id: driver_seventeen.id)

Address.create(street: 'Main St #204', external_number: "45", country: "USA", city: "Baker City", state: "Oregon", addressable_type: "Driver", addressable_id: driver_eighteen.id)
Address.create(street: 'Leah Ct', external_number: "657", country: "USA", city: "Oakland", state: "Oregon", addressable_type: "Driver", addressable_id: driver_nineteen.id)
Address.create(street: 'Crowfoot Rd', external_number: "985", country: "USA", city: "Lebanon", state: "Oregon", addressable_type: "Driver", addressable_id: driver_twenty.id)
Address.create(street: 'Curtis Rd #4', external_number: "658", country: "USA", city: "Harrisburg", state: "Oregon", addressable_type: "Driver", addressable_id: driver_twenty_one.id)
Address.create(street: 'Ettlin Loop', external_number: "112", country: "USA", city: "Scotts Mills", state: "Oregon", addressable_type: "Driver", addressable_id: driver_twenty_two.id)

# Create Carriers Addresses
Address.create(street: 'W Erie St #6', external_number: "965", country: "USA", city: "Jefferson", state: "Ohio", addressable_type: "Carrier", addressable_id: carrier_one.id)
Address.create(street: 'S 6th St', external_number: "854", country: "USA", city: "Coshocton", state: "Ohio", addressable_type: "Carrier", addressable_id: carrier_two.id)
Address.create(street: 'Park Dr', external_number: "521", country: "USA", city: "Campbell", state: "Ohio", addressable_type: "Carrier", addressable_id: carrier_three.id)
Address.create(street: 'E Water St', external_number: "632", country: "USA", city: "Urbana", state: "Ohio", addressable_type: "Carrier", addressable_id: carrier_four.id)
Address.create(street: 'Albright Mckay Rd NE', external_number: "996", country: "USA", city: "Brookfield", state: "Ohio", addressable_type: "Carrier", addressable_id: carrier_five.id)
Address.create(street: 'Addison Rd', external_number: "88", country: "USA", city: "Masury", state: "Ohio", addressable_type: "Carrier", addressable_id: carrier_six.id)
Address.create(street: 'Main St #204', external_number: "45", country: "USA", city: "Baker City", state: "Oregon", addressable_type: "Carrier", addressable_id: carrier_seven.id)
Address.create(street: 'Leah Ct', external_number: "657", country: "USA", city: "Oakland", state: "Oregon", addressable_type: "Carrier", addressable_id: carrier_eight.id)

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
shipment_one = Shipment.create(sale_id: sale_one.id, user_id: rebeca_employee.id, client_id: client_amanda.id, instructions: "Deliver this package to the front door of the house, and wrap the computer and mouse in a blue box.", status: :accepted, total_products: 2, sale_number: "SG-38G", issued_at: Time.now, shiped_at: Time.now + 3.days)

# Create shipment address
Address.create(street: 'Russell St', external_number: "854", country: "USA", city: "Amsterdam", state: "NY", addressable_type: "Shipment", addressable_id: shipment_one.id)

# Create carriers for this shipment
ShipmentCarrier.create(shipment_id: shipment_one.id, carrier_id: company_one.carriers.first.id)
ShipmentCarrier.create(shipment_id: shipment_one.id, carrier_id: company_one.carriers.second.id)

# Create shipment for sale_two
shipment_two = Shipment.create(sale_id: sale_two.id, user_id: rebeca_employee.id, client_id: client_emma.id, instructions: "Wrap the mouse in a black box.", status: :accepted, total_products: 1, sale_number: "SG-39F", issued_at: Time.now, shiped_at: Time.now + 10.minutes)

# Create shipment address
Address.create(street: 'Brockport Spencerport Rd', external_number: "968", country: "USA", city: "Brockport", state: "NY", addressable_type: "Shipment", addressable_id: shipment_two.id)

# Create carriers for this shipment
ShipmentCarrier.create(shipment_id: shipment_two.id, carrier_id: company_one.carriers.third.id)

# Create shipment for sale_three
shipment_three = Shipment.create(sale_id: sale_three.id, user_id: jack_employee.id, client_id: client_emma.id, instructions: "Laptop and mouse in a slim package.", status: :pending, total_products: 2, sale_number: "SG-45AF", issued_at: Time.now + 1.day)

# Create shipment address
Address.create(street: 'East Ave', external_number: "3018", country: "USA", city: "Central Square", state: "NY", addressable_type: "Shipment", addressable_id: shipment_three.id)

# Create carriers for this shipment
ShipmentCarrier.create(shipment_id: shipment_three.id, carrier_id: company_one.carriers.third.id)
ShipmentCarrier.create(shipment_id: shipment_three.id, carrier_id: company_one.carriers.last.id)

# Create shipment for sale_four
shipment_four = Shipment.create(sale_id: sale_four.id, user_id: jack_employee.id, client_id: client_olivia.id, instructions: "Send manuals and login info for the platform.", status: :accepted, total_products: 2, sale_number: "SG-99D")

# Create shipment address
Address.create(street: 'Thruway Plaza', external_number: "14225", country: "USA", city: "Cheektowaga", state: "NY", addressable_type: "Shipment", addressable_id: shipment_four.id)

# Create carriers for this shipment
ShipmentCarrier.create(shipment_id: shipment_four.id, carrier_id: company_three.carriers.first.id)
ShipmentCarrier.create(shipment_id: shipment_four.id, carrier_id: company_three.carriers.second.id)
ShipmentCarrier.create(shipment_id: shipment_four.id, carrier_id: company_three.carriers.last.id)

# Create shipment for sale_five
shipment_five = Shipment.create(sale_id: sale_five.id, user_id: rebeca_employee.id, client_id: client_olivia.id, instructions: "Send couching program, manuals and login info.", status: :accepted, total_products: 2, sale_number: "SG-52F", issued_at: Time.now + 5.hours, shiped_at: Time.now + 2.days)

# Create shipment address
Address.create(street: 'Troy Road', external_number: "254", country: "USA", city: "East Greenbush", state: "NY", addressable_type: "Shipment", addressable_id: shipment_five.id)

# Create carriers for this shipment
ShipmentCarrier.create(shipment_id: shipment_five.id, carrier_id: company_three.carriers.third.id)
ShipmentCarrier.create(shipment_id: shipment_five.id, carrier_id: company_three.carriers.second.id)

# Create shipment for sale_six
shipment_six = Shipment.create(sale_id: sale_six.id, user_id: jack_employee.id, client_id: client_emma.id, instructions: "Send couching program, platform uri, manuals and login info.", status: :accepted, total_products: 3, sale_number: "SG-72W", issued_at: Time.now + 2.hours, shiped_at: Time.now + 1.days)

# Create shipment address
Address.create(street: 'State Route 3', external_number: "8542", country: "USA", city: "Fulton", state: "NY", addressable_type: "Shipment", addressable_id: shipment_six.id)

# Create carriers for this shipment
ShipmentCarrier.create(shipment_id: shipment_six.id, carrier_id: company_three.carriers.third.id)
ShipmentCarrier.create(shipment_id: shipment_six.id, carrier_id: company_three.carriers.last.id)