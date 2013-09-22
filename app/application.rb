UnderOs::Application.start do
  config.navigation = true
  config.status_bar = false
  config.main_page  = HomePage.new
end
