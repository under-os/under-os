#
# Application config proxy
#
class UnderOs::Config

  def initialize(app)
    @app = app
  end

  def root_page
    @app.history.root_page
  end

  def root_page=(page)
    @app.history.root_page = page
  end

  def status_bar
    @status_bar
  end

  def status_bar=(visible)
    @status_bar = visible
  end

  def navbar
    @app.history.navbar.visible
  end

  def navbar=(visible)
    @app.history.navbar.__send__ visible ? :show : :hide, false
  end
end
