UnderOs.extend __FILE__ do |app|
  app.resources_dirs << "app/styles/"  if File.exists?("app/styles")
  app.resources_dirs << "app/layouts/" if File.exists?("app/layouts")

  app.fonts << "fontawesome-webfont.ttf"
end
