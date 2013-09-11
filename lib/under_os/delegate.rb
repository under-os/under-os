#
# Just an app delegate to kick the things in
#
class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    UnderOs::Application.new(application, launchOptions)

    true
  end
end
