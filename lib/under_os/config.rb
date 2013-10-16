#
# Application config proxy
#
class UnderOs::Config

  def initialize(app)
    @app = app
  end

  def root_page
    @app.navigation.root_page
  end

  def root_page=(page)
    @app.navigation.root_page = page
  end

  def status_bar
    @status_bar
  end

  def status_bar=(visible)
    @status_bar = visible
  end

  def navigation=(visible)
    @app.navigation.__send__ visible ? :show : :hide, false
  end
end
