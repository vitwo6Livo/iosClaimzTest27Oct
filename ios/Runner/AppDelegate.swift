import UIKit
import Flutter
import workmanager
import flutter_downloader
import GoogleMaps
import FirebaseCore
import FirebaseMessaging

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    FirebaseApp.configure()
      GMSServices.provideAPIKey("AIzaSyC60tYZkISbxvLKJlB0PQVOsdVFeNfNcfo")

      WorkmanagerPlugin.registerTask(withIdentifier: "task-identifier")

//       SwiftFlutterBackgroundServicePlugin.taskIdentifier = "your.custom.task.identifier"
// GeneratedPluginRegistrant.register(with: self)
//     UIApplication.shared.setMinimumBackgroundFetchInterval(TimeInterval(60*15))

  if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self as UNUserNotificationCenterDelegate

      let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
UNUserNotificationCenter.current().requestAuthorization(
  options: authOptions,
  completionHandler: { _, _ in }
)

application.registerForRemoteNotifications()
    }
    GeneratedPluginRegistrant.register(with: self)
        FlutterDownloaderPlugin.setPluginRegistrantCallback(registerPlugins)

        UIApplication.shared.setMinimumBackgroundFetchInterval(TimeInterval(60*15))

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
private func registerPlugins(registry: FlutterPluginRegistry) {
    if (!registry.hasPlugin("FlutterDownloaderPlugin")) {
       FlutterDownloaderPlugin.register(with: registry.registrar(forPlugin: "FlutterDownloaderPlugin")!)
    }
}
