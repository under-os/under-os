UnderOs::App.instance_eval do

  def self.history
    @history ||= UnderOs::History.new
  end

  def self.stylesheet
    @stylesheet ||= UnderOs::Page::Stylesheet.new.tap do |stylesheet|
      stylesheets.each { |filename| stylesheet.load(filename) }
    end
  end

  def self.stylesheets
    ($stylesheets ||= []).tap do |files|
      files << "under-os.css"    unless files.include?("under-os.css")
      files << "application.css" unless files.include?("application.css")
    end
  end

protected

  def self.root_controller
    history._
  end

end
