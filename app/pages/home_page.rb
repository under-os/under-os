class HomePage < UnderOs::Page

  def initialize
    find('#buttons button').each do |button|
      button.on :tap do
        page = (button.data('page').capitalize + "Page").constantize
        history << page.new
      end
    end
  end
end
