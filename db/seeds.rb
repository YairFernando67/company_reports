# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

carl_admin = User.create(email: "carl@gmail.com", name: "carl", role: :admin, password: "password", password_confirmation: "password")
john_admin = User.create(email: "john@gmail.com", name: "john", role: :admin, password: "password", password_confirmation: "password")
rebeca_employee = User.create(email: "rebeca@gmail.com", name: "rebeca", role: :employee, password: "password", password_confirmation: "password")
jack_employee = User.create(email: "jack@gmail.com", name: "jack", role: :employee, password: "password", password_confirmation: "password")

Address.create(street: 'Stark Street', external_number: "23", country: "USA", city: "Portland", state: "Oregon", addressable_type: "User", addressable_id: carl_admin.id)
Address.create(street: '82nd Avenue', external_number: "156", country: "USA", city: "Portland", state: "Oregon", addressable_type: "User", addressable_id: john_admin.id)
Address.create(street: 'Alberta District', external_number: "19", country: "USA", city: "Portland", state: "Oregon", addressable_type: "User", addressable_id: rebeca_employee.id)
Address.create(street: 'Cornell Road', external_number: "58", country: "USA", city: "Portland", state: "Oregon", addressable_type: "User", addressable_id: jack_employee.id)

company_type = CompanyType.create(name: "IT Companies", code: "001", affiliation: "FullTime")

company_one = carl_admin.companies.create(business_name: "ServiceNow", rfc: "qwer9605066d6", email: "service_now@gmail.com", phone: "8547963215", active: true, contact: "Michelle Perl", fiscal_name: "Services Now TR", company_type_id: company_type.id)
company_two = carl_admin.companies.create(business_name: "ADP", rfc: "ERTY7406055F5", email: "adp_team@gmail.com", phone: "8547412548", active: true, contact: "Angel Phill", fiscal_name: "ADP", company_type_id: company_type.id)
company_three = john_admin.companies.create(business_name: "PayPal", rfc: "yuio8505065d5", email: "paypal@gmail.com", phone: "2541253698", active: true, contact: "Rachel Walcker", fiscal_name: "Paypal CO", company_type_id: company_type.id)
company_four = john_admin.companies.create(business_name: "Verizon", rfc: "tgyh8562364d", email: "verizon@gmail.com", phone: "7458965214", active: true, contact: "Emily Ino", fiscal_name: "Verizon SA", company_type_id: company_type.id)

Address.create(street: 'Centre Avenue', external_number: "77", country: "USA", city: "Reading", state: "Pensilvania", addressable_type: "Company", addressable_id: company_one.id)
Address.create(street: 'Franklin Street', external_number: "96", country: "USA", city: "Reading", state: "Pensilvania", addressable_type: "Company", addressable_id: company_two.id)
Address.create(street: 'Mineral Spring Road', external_number: "425", country: "USA", city: "Reading", state: "Pensilvania", addressable_type: "Company", addressable_id: company_three.id)
Address.create(street: 'Washington Street', external_number: "745", country: "USA", city: "Reading", state: "Pensilvania", addressable_type: "Company", addressable_id: company_four.id)

FiscalInfo.create(ri: "tghy7452", account_statement: "content.xml", proof_of_address: "proof_of_address.pdf", incorporation_act: "incorporation_act.pdf", start_of_operation: DateTime.now - 2.years, company_id: company_one)
FiscalInfo.create(ri: "yhju8542", account_statement: "content.xml", proof_of_address: "proof_of_address.pdf", incorporation_act: "incorporation_act.pdf", start_of_operation: DateTime.now - 1.years, company_id: company_two)
FiscalInfo.create(ri: "ojkn8412", account_statement: "content.xml", proof_of_address: "proof_of_address.pdf", incorporation_act: "incorporation_act.pdf", start_of_operation: DateTime.now - 3.years, company_id: company_three)
FiscalInfo.create(ri: "ffsg9514", account_statement: "content.xml", proof_of_address: "proof_of_address.pdf", incorporation_act: "incorporation_act.pdf", start_of_operation: DateTime.now - 4.years, company_id: company_four)

product_one = company_one.products.create(name: "Computer", price: "750", uid: SecureRandom.uuid)
product_two = company_one.products.create(name: "Mouse", price: "250", uid: SecureRandom.uuid)
product_three = company_one.products.create(name: "Laptop", price: "1100", uid: SecureRandom.uuid)

product_four = company_two.products.create(name: "WebService", price: "900", uid: SecureRandom.uuid)

product_five = company_three.products.create(name: "Web app", price: "5000", uid: SecureRandom.uuid)
product_six = company_three.products.create(name: "Training Courses", price: "4500", uid: SecureRandom.uuid)
product_seven = company_three.products.create(name: "Coaching", price: "1500", uid: SecureRandom.uuid)

product_eight = company_four.products.create(name: "IT Consulting", price: "2100", uid: SecureRandom.uuid)

client_amanda = Client.create(name: "Amanda", email: "amanda@gmail.com", phone: "7452145698")
client_emma = Client.create(name: "Emma", email: "emma@gmail.com", phone: "5214589744")
client_olivia = Client.create(name: "Olivia", email: "olivia@gmail.com", phone: "1254784521")

purchase_one = Purchase.create(company_id: company_one.id, seller_id: rebeca_employee.id, buyer_id: client_amanda.id, total: 1000, status: :completed, purchase_type: "IT")
purchase_two = Purchase.create(company_id: company_one.id, seller_id: rebeca_employee.id, buyer_id: client_emma.id, total: 500, status: :completed, purchase_type: "IT")
purchase_three = Purchase.create(company_id: company_one.id, seller_id: jack_employee.id, buyer_id: client_emma.id, total: 1350, status: :completed, purchase_type: "IT")

purchase_one.purchase_concepts.create(unit_price: "750", total: "750", amount: "1", product_id: product_one.id)
purchase_one.purchase_concepts.create(unit_price: "250", total: "250", amount: "1", product_id: product_two.id)

purchase_two.purchase_concepts.create(unit_price: "250", total: "500", amount: "2", product_id: product_two.id)

purchase_three.purchase_concepts.create(unit_price: "250", total: "250", amount: "1", product_id: product_two.id)
purchase_three.purchase_concepts.create(unit_price: "1100", total: "1100", amount: "1", product_id: product_three.id)


purchase_four = Purchase.create(company_id: company_three.id, seller_id: jack_employee.id, buyer_id: client_olivia.id, total: 14500, status: :completed, purchase_type: "IT")
purchase_five = Purchase.create(company_id: company_three.id, seller_id: rebeca_employee.id, buyer_id: client_olivia.id, total: 12000, status: :completed, purchase_type: "IT")
purchase_six = Purchase.create(company_id: company_three.id, seller_id: jack_employee.id, buyer_id: client_emma.id, total: 22000, status: :completed, purchase_type: "IT")

purchase_four.purchase_concepts.create(unit_price: "5000", total: "10000", amount: "2", product_id: product_five.id)
purchase_four.purchase_concepts.create(unit_price: "4500", total: "4500", amount: "1", product_id: product_six.id)

purchase_five.purchase_concepts.create(unit_price: "4500", total: "9000", amount: "2", product_id: product_six.id)
purchase_five.purchase_concepts.create(unit_price: "1500", total: "3000", amount: "2", product_id: product_seven.id)

purchase_six.purchase_concepts.create(unit_price: "5000", total: "10000", amount: "2", product_id: product_five.id)
purchase_six.purchase_concepts.create(unit_price: "4500", total: "9000", amount: "2", product_id: product_six.id)
purchase_six.purchase_concepts.create(unit_price: "1500", total: "3000", amount: "2", product_id: product_seven.id)

