#
# Application config proxy
#
class UnderOs::Config

  def initialize(app)
    @app = app
  end

  def main_page=(page)
    @app.instance_eval do
      @navigation.main_page = page
    end
  end

  def status_bar=(visible)
    @app.instance_eval do
      @_.setStatusBarHidden(!visible, withAnimation: false)
    end
  end

  def navigation=(visible)
    @app.instance_eval do
      @navigation.visible = visible
    end
  end
end
