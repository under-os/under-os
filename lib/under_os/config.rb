#
# Application config proxy
#
class UnderOs::Config

  def initialize(app)
    @app = app
  end

  def main_page
    @app.navigation.main_page
  end

  def main_page=(page)
    @app.navigation.main_page = page
  end

  def status_bar
    @status_bar
  end

  def status_bar=(visible)
    @status_bar = visible
  end

  def navigation=(visible)
    @app.navigation.visible = visible
  end
end
