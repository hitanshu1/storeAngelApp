import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
        GMSServices.provideAPIKey("AIzaSyAC0olKkjeCtMU_9ooRfnM9jDfE3eWtImc")
    DispatchQueue.main.asyncAfter(deadline: .now()+5){
        UIApplication.shared.isStatusBarHidden = false
    }
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    
}
