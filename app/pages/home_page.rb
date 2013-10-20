class HomePage < UnderOs::Page

  def initialize
    find('#buttons button').each do |button|
      button.on :tap do
        page = Kernel.const_get(button.data('page').capitalize + "Page")
        navigation << page.new
      end
    end
  end
end
