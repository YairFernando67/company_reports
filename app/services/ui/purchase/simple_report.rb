class Ui::Purchase::SimpleReport < Ui::Purchase::UiElements 
  attr_accessor :data

  def initialize(data)
    @data = data
  end

  def display_report
    companies = get_companies_html
    "
      <table class='mt-3 alwaysbreak'>
        <thead>
          <tr>
            <th class='text-left' width='49%'>
              Company
            </th>
            <th></th>
          </tr>
        </thead>
        <tbody>
          #{companies[0]}
        </tbody>
      </table>
      <table class='mt-3 alwaysbreak'>
        <thead>
          <tr>
            <th class='text-left' width='50%'>
              Company
            </th>
            <th></th>
          </tr>
        </thead>
        <tbody>
          #{companies[1]}
        </tbody>
      </table>
    "
  end

  private

  def get_companies_html
    data[:companies].map do |company|
      "
        <tr>
          <td class='company-name'><b>Business Name:</b> </td>
          <td class='company-name'><b>#{company[:business_name]}</b></td>
        </tr>
        <tr>
          <td><b>RFC:</b> </td>
          <td>#{company[:rfc]}</td>
        </tr>
        <tr>
          <td><b>Email:</b> </td>
          <td>#{company[:email]}</td>
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
          #{company[:products].size == 0 ?
            '<h4>THERE ARE NO PRODUCTS</h4>'
          :
            "
              <table class='mt-1'>
                <thead>
                  <tr>
                    <th class='text-left' width='49%'>
                      <span>Products </span>
                    </th>
                    <th></th>
                  </tr>
                </thead>
                <tbody>
                  #{company[:products].map do |product|
                  "
                    <tr>
                      <td class='product-name'><b>Name:</b> </td>
                      <td class='product-name'><b>#{product[:name]}</b></td>
                    </tr>
                    <tr>
                      <td><b>Price:</b> </td>
                      <td>#{product[:price]}</td>
                    </tr>
                    <tr>
                      <td></td>
                    </tr>
                  "
                  end.join}
                </tbody>
              </table>
            "
          }
        </tr>
        <tr>
          <h3 class='m-1 p-0'>Sales</h3>
          <hr/>
          #{company[:sales].size == 0 ?
            '<h4>THERE ARE NO SALES</h4>'
          :
            "
              <table class='mt-1'>
                <thead>
                  <tr>
                    <th>#</th>
                    <th class='text-left' width='35%'><span>Status</span></th>
                    <th class='bl-white text-left' width='20%'>Total(BT)</th>
                    <th class='bl-white text-left' width='20%'>Total</th>
                    <th class='text-left' width='20%'>Date</th>
                  </tr>
                  <tr></tr>
                </thead>
                <tbody>
                  #{company[:sales].map do |sale|
                  "
                    <tr>
                      <td class='sale-name p-1'><b>#{sale[:id]}</b></td>
                      <td class='sale-name p-1'><b>#{sale[:status]}</b></td>
                      <td class='sale-name p-1 bl-white'><b>$#{sale[:total_before_taxes]}</b></td>
                      <td class='sale-name p-1'><b>$#{sale[:total]}</b></td>
                      <td class='sale-name p-1 bl-white'><b>#{sale[:date]}</b></td>
                    </tr>
                  "
                  end.join}
                </tbody>
              </table>
              <h4>Concepts</h4>
              <table class='mt-1'>
                <thead>
                  <tr>
                    <th class='text-left'><span>Sale</span></th>
                    <th class='text-left'>Amount</th>
                    <th class='text-left'><span>Unit Price</span></th>
                    <th class='text-left'>Total</th>
                  </tr>
                </thead>
                <tbody>
                  #{company[:sales].map do |sale|
                    concepts = sale[:sale_concepts]
                    concepts.map do |sale_concept|
                      "
                        <tr>
                          <td class='sale-concept-name p-1'><b>#{sale_concept[:sale_id]}</b></td>
                          <td class='sale-concept-name p-1 bl-white'><b>#{sale_concept[:amount]}</b></td>
                          <td class='sale-concept-name p-1'><b>$#{sale_concept[:unit_price]}</b></td>
                          <td class='sale-concept-name p-1' width='20%'><b>$#{sale_concept[:total]}</b></td>
                        </tr>
                      "
                    end.join
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