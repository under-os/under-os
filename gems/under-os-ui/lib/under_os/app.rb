UnderOs::App.instance_eval do

  def self.history
    @history ||= UnderOs::History.new
  end

  def self.stylesheet
    @stylesheet ||= UnderOs::Page::Stylesheet.new.tap do |stylesheet|
      stylesheet.load('under-os.css')
      stylesheet.load('application.css')
    end
  end

protected

  def self.root_controller
    history._
  end

end
