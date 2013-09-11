#
# Application config proxy
#
class UnderOs::Config

  def initialize(app)
    @app = app
  end

  def main_page=(page)
    @main_page = page

    @app.instance_eval do
      @window.rootViewController = page.instance_variable_get('@_')
      @window.makeKeyAndVisible
    end
  end

  def status_bar=(visible)
    @app.instance_eval do
      @_.setStatusBarHidden(!visible, withAnimation: false)
    end
  end
end
