import UIKit
import Flutter
import MessageUI

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        NativeCallService.shared.configChannel(window: window)
        NativeEmailService.shared.configChannel(window: window)
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}

class NativeCallService {
    static let shared = NativeCallService()
    
    init() {}
    
    func configChannel(window: UIWindow?) {
        guard let wd = window else { return }
        let controller = wd.rootViewController as! FlutterViewController
        let nativeCallChannel = FlutterMethodChannel(name: "flutter.sailebotv2.nativeCall", binaryMessenger: controller.binaryMessenger)
        nativeCallChannel.setMethodCallHandler {
            [weak self] (call, result) in
            guard let _ = self else { return }
            DispatchQueue.main.async {
                [weak self] in
                guard let wSelf = self else { return }
                if call.method == "makePhoneCall",
                    let phoneNumber = call.arguments as? String {
                    wSelf.makePhoneCall(phoneNumber: phoneNumber, result: result)
                }
            }
        }
    }
    
    fileprivate func makePhoneCall(phoneNumber: String, result: FlutterResult) {
        guard let url = URL(string: "tel://\(phoneNumber)"),
            UIApplication.shared.canOpenURL(url) else {
                result(FlutterError(code: "UNAVAILABLE", message: "Make call failed", details: nil));
                return
        }
        
        if #available(iOS 10, *) {
            UIApplication.shared.open(url)
        } else {
            UIApplication.shared.openURL(url)
        }
        
        result(true)
    }
}

class NativeEmailService: NSObject, MFMailComposeViewControllerDelegate {
    static let shared = NativeEmailService()
    weak var rootController: FlutterViewController?
    
    override init() {}
    
    func configChannel(window: UIWindow?) {
        guard let wd = window else { return }
        let controller = wd.rootViewController as! FlutterViewController
        self.rootController = controller
        let nativeCallChannel = FlutterMethodChannel(name: "flutter.sailebotv2.nativeEmail", binaryMessenger: controller.binaryMessenger)
        nativeCallChannel.setMethodCallHandler {
            [weak self] (call, result) in
            guard let _ = self else { return }
            DispatchQueue.main.async {
                [weak self] in
                guard let wSelf = self else { return }
                if call.method == "sendEmail",
                    let packet = call.arguments as? [String: Any] {
                    let recipients = packet["recipients"] as? [String] ?? []
                    let body = packet["body"] as? String ?? ""
                    let subject = packet["subject"] as? String ?? ""
                    wSelf.sendEmail(recipients: recipients, body: body, subject: subject, result: result)
                }
            }
        }
    }
    
    fileprivate func sendEmail(recipients: [String], body: String,
                               subject: String, result: @escaping FlutterResult) {
        guard MFMailComposeViewController.canSendMail() else {
            let email = recipients.joined(separator: ",")
            if let url = URL(string: "mailto:\(email)?subject=\(subject)&body=\(body)"),
                UIApplication.shared.canOpenURL(url) {
              if #available(iOS 10.0, *) {
                UIApplication.shared.open(url)
              } else {
                UIApplication.shared.openURL(url)
              }
            }
            
            result(nil)
            return
        }
        
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = self
        composeVC.setToRecipients(recipients)
        composeVC.setSubject(subject)
        composeVC.setMessageBody(body, isHTML: false)
        self.rootController?.present(composeVC, animated: true, completion: {
            result(nil)
        })
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
