#
# Generic, per-app delegate
class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    UnderOs::Application.new(application, launchOptions)

    true
  end
end
