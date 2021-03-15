# frozen_string_literal: true

class Ui::Sale::DetailedReport < Ui::Sale::UiElements
  attr_accessor :data

  def initialize(data)
    @data = data
  end

  def display_report
    companies = get_companies_html
    companies.map do |company|
      "
        <table class='mt-3 alwaysbreak'>
          <thead>
            <tr>
              <th class='text-left' width='25%'>
                Company
              </th>
              <th  width='25%'></th>
              <th  width='25%'></th>
              <th  width='25%'></th>
            </tr>
          </thead>
          <tbody>
            #{company}
          </tbody>
        </table>
      "
    end.join
  end

  private

  def get_companies_html
    # binding.pry
    data[:companies].map do |company|
      "
        <tr>
          <td class='bg-color-red'><b>Business Name:</b> </td>
          <td class='bg-color-red'><b>#{company[:business_name]}</b></td>
          <td class='bg-color-red'><b>Fiscal Information:</b> </td>
          <td class='bg-color-red'></td>
        </tr>
        <tr>
          <td><b>RFC:</b> </td>
          <td>#{company[:rfc]}</td>
          <td><b>RI:</b> </td>
          <td>#{company[:fiscal_information][:ri]}</td>
        </tr>
        <tr>
          <td><b>Email:</b> </td>
          <td>#{company[:email]}</td>
          <td><b>Proof of Address:</b> </td>
          <td>#{company[:fiscal_information][:proof_of_address]}</td>
        </tr>
        <tr>
          <td><b>Phone:</b> </td>
          <td>#{company[:phone]}</td>
        </tr>
        <tr>
          <td><b>Contact:</b> </td>
          <td>#{company[:contact]}</td>
        </tr>
        <tr>
          <td><b>Fiscal Name:</b> </td>
          <td>#{company[:fiscal_name]}</td>
        </tr>
        <tr>
          <td><b>Contributing Since:</b> </td>
          <td>#{company[:created_at].strftime("%B %Y %m")}</td>
        </tr>
        <tr>
          <td><b>Company type:</b> </td>
          <td>#{company[:company_type]}</td>
        </tr>
        <tr>
          <td><b>Code:</b> </td>
          <td>#{company[:code]}</td>
        </tr>
        <tr>
          <td><b>Affiliation:</b> </td>
          <td>#{company[:affiliation]}</td>
        </tr>
        <tr>
          <td class='pt-3'><b>Products:</b> </td>
          <td></td>
        </tr>
        <tr>
          #{company[:products].empty? ?
            "<h4>THERE ARE NO PRODUCTS</h4>"
          :
            "
              <table class='mt-1'>
                <thead>
                  <tr>
                    <th class='text-left' width='20%'>#</th>
                    <th class='text-left' width='20%'>Name</th>
                    <th class='text-left' width='20%'>Uid</th>
                    <th class='text-left' width='20%'>Price</th>
                  </tr>
                </thead>
                <tbody>
                  #{company[:products].map do |product|
                    "
                    <tr>
                      <td class='p-1 bg-color-green'><b>#{product[:id]}</b></td>
                      <td class='p-1 bg-color-green'><b>#{product[:name]}</b></td>
                      <td class='p-1 bg-color-green'><b>#{product[:identifier][0..10]}</b></td>
                      <td class='p-1 bg-color-red'>$<b>#{product[:price]}</b></td>
                    </tr>
                  "
                  end.join}
                </tbody>
              </table>
            "
          }
        </tr>
           <tr>
          <h4 class='m-1 p-0'>Sales</h4>
          <hr/>
          #{company[:sales].empty? ?
            "<h4>THERE ARE NO SALES</h4>"
          :
            "
              <table class='mt-1'>
                <thead>
                  <tr>
                    <th>#</th>
                    <th class='text-left' width='15%'><span>Status</span></th>
                    <th class='text-left' width='20%'>Date</th>
                    <th class='text-left' width='20%'>Sale Type</th>
                    <th class='text-left' width='10%'>IVA</th>
                    <th class='text-left' width='10%'>IEPS</th>
                    <th class='text-left' width='15%'>Discount</th>
                    <th class='text-left' width='20%'>Extra Fees</th>
                    <th class='bl-white text-left' width='10%'>Total(BT)</th>
                    <th class='bl-white text-left' width='10%'>Total</th>
                  </tr>
                  <tr></tr>
                </thead>
                <tbody>
                  #{company[:sales].map do |sale|
                    "
                    <tr>
                      <td class='bg-color-green p-1'><b>#{sale[:id]}</b></td>
                      <td class='bg-color-green p-1'><b>#{sale[:status]}</b></td>
                      <td class='bg-color-green p-1 bl-white'><b>#{sale[:date]}</b></td>
                      <td class='bg-color-green p-1 bl-white'><b>#{sale[:sale_type]}</b></td>
                      <td class='bg-color-green p-1 bl-white'><b>$#{sale[:iva]}</b></td>
                      <td class='bg-color-green p-1 bl-white'><b>#{sale[:ieps]}</b></td>
                      <td class='bg-color-green p-1 bl-white'><b>$#{sale[:discount]}</b></td>
                      <td class='bg-color-green p-1 bl-white'><b>$#{sale[:extra_fees]}</b></td>
                      <td class='bg-color-green p-1 bl-white'><b>$#{sale[:total_before_taxes]}</b></td>
                      <td class='bg-color-red p-1'><b>$#{sale[:total]}</b></td>
                    </tr>
                  "
                  end.join}
                </tbody>
              </table>
              <h4>Concepts</h4>
              <table class='mt-1'>
                <thead>
                  <tr>
                    <th class='text-left' width='10%'><span>Sale</span></th>
                    <th class='text-left' width='20%'>Amount</th>
                    <th class='text-left' width='20%'><span>U/Price</span></th>
                    <th class='text-left' width='10%'>Total(BT)</th>
                    <th class='text-left' width='10%'>IVA</th>
                    <th class='text-left' width='10%'>IEPS</th>
                    <th class='text-left' width='10%'>Total</th>
                  </tr>
                </thead>
                <tbody>
                  #{company[:sales].map do |sale|
                    concepts = sale[:sale_concepts]
                    concepts.map do |sale_concept|
                      "
                        <tr>
                          <td class='bg-color-green p-1'><b>#{sale_concept[:sale_id]}</b></td>
                          <td class='bg-color-green p-1 bl-white'><b>#{sale_concept[:amount]}</b></td>
                          <td class='bg-color-green p-1'><b>$#{sale_concept[:unit_price]}</b></td>
                          <td class='bg-color-green p-1' width='20%'><b>$#{sale_concept[:total_before_taxes]}</b></td>
                          <td class='bg-color-green p-1' width='20%'><b>$#{sale_concept[:iva]}</b></td>
                          <td class='bg-color-green p-1' width='20%'><b>#{sale_concept[:ieps]}</b></td>
                          <td class='bg-color-red p-1' width='20%'><b>$#{sale_concept[:total]}</b></td>
                        </tr>
                      "
                    end.join
                  end.join}
                </tbody>
              </table>
              <h4>Employees Information</h4>
              <table class='mt-1'>
                <thead>
                  <tr>
                  <th class='text-left' width='5%'>#</th>
                    <th class='text-left' width='5%'><span>Sale</span></th>
                    <th class='text-left' width='10%'>Name</th>
                    <th class='text-left' width='10%'><span>Email</span></th>
                    <th class='text-left' width='5%'>Sales</th>
                    <th class='text-left' width='50%'>Address</th>
                    <th class='text-left' width='10%'>Total Sold(BT)</th>
                    <th class='text-left' width='10%'>Total Sold</th>
                  </tr>
                </thead>
                <tbody>
                  #{company[:sales].map do |sale|
                    employee = sale[:employee_info]
                    "
                        <tr>
                          <td class='bg-color-green p-1'><b>#{employee[:id]}</b></td>
                          <td class='bg-color-green p-1 bl-white'><b>#{employee[:sale_id]}</b></td>
                          <td class='bg-color-green p-1'><b>#{employee[:name]}</b></td>
                          <td class='bg-color-green p-1' width='20%'><b>#{employee[:email]}</b></td>
                          <td class='bg-color-green p-1' width='20%'><b>#{employee[:sales]}</b></td>
                          <td class='bg-color-green p-1' width='20%'><b>#{employee[:street] + " " + employee[:external_number] + " " + employee[:city] + " " + employee[:state] + " " + employee[:country]}</b></td>
                          <td class='bg-color-green p-1' width='20%'><b>$#{employee[:total_amount_sold_before_taxes]}</b></td>
                          <td class='bg-color-red p-1' width='20%'><b>$#{employee[:total_amount_sold]}</b></td>
                        </tr>
                      "
                  end.join}
                </tbody>
              </table>
              <h4>Clients Information</h4>
              <table class='mt-1'>
                <thead>
                  <tr>
                  <th class='text-left' width='5%'>#</th>
                    <th class='text-left' width='5%'><span>Sale</span></th>
                    <th class='text-left' width='10%'>Name</th>
                    <th class='text-left' width='10%'><span>Email</span></th>
                    <th class='text-left' width='5%'>Purchases</th>
                    <th class='text-left' width='50%'>Address</th>
                    <th class='text-left' width='10%'>Total Purchased(BT)</th>
                    <th class='text-left' width='10%'>Total Purchased</th>
                  </tr>
                </thead>
                <tbody>
                  #{company[:sales].map do |sale|
                    client = sale[:client_info]
                    "
                        <tr>
                          <td class='bg-color-green p-1'><b>#{client[:id]}</b></td>
                          <td class='bg-color-green p-1 bl-white'><b>#{client[:sale_id]}</b></td>
                          <td class='bg-color-green p-1'><b>#{client[:name]}</b></td>
                          <td class='bg-color-green p-1' width='20%'><b>#{client[:email]}</b></td>
                          <td class='bg-color-green p-1' width='10%'><b>#{client[:purchases]}</b></td>
                          <td class='bg-color-green p-1' width='20%'><b>#{client[:street] + " " + client[:external_number] + " " + client[:city] + " " + client[:state] + " " + client[:country]}</b></td>
                          <td class='bg-color-green p-1' width='20%'><b>$#{client[:total_amount_purchased_before_taxes]}</b></td>
                          <td class='bg-color-red p-1' width='20%'><b>$#{client[:total_amount_purchased]}</b></td>
                        </tr>
                      "
                  end.join}
                </tbody>
              </table>

            "
          }
        </tr>
      "
    end
  end
end
