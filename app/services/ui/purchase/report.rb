class Ui::Purchase::Report
  def ui
    raise NotImplementedError, "#{self.class} method not implemented yet #{__method__}"
  end

  def get_header
    "
      <table>
        <thead>
          <tr>
            <th>
              <img src='http://lasalbardas.com/ADMIN/VIEWS/resources/IMG//logo.jpg' alt='logo' height='90'>
            </th>
            <th class='text-right' width='100%'>
              <span class='text-right'>#{Date.current.strftime('%B %Y %m')}</span>
            </th>
          </tr>
        </thead>
      </table>
      <div class='header'>
        <div class='text-center'>
          <h3>Companies Sales Report 2020</h3>
        </div>
      </div>
      <br/>
    "
  end

  def get_footer
    "
      <table>
        <thead>
          <tr>
            <th class='text-right' width='100%'>
              <span class='text-right'>#{Date.current.strftime('%B %Y %m')}</span>
            </th>
            <th class='text-right' width='100%'>
              <span class='text-right'>Footer</span>
            </th>
          </tr>
        </thead>
      </table>
    "
  end
end