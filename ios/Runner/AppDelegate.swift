import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)

    if let registrar = engineBridge.pluginRegistry.registrar(forPlugin: "ProvisioningProfileChannel") {
      let channel = FlutterMethodChannel(
        name: "app/provisioning_profile",
        binaryMessenger: registrar.messenger()
      )
      channel.setMethodCallHandler { call, result in
        guard call.method == "get" else {
          result(FlutterMethodNotImplemented)
          return
        }
        result(Self.readEmbeddedProfile())
      }
    }
  }

  // The embedded.mobileprovision file is a CMS-signed envelope wrapping an
  // XML plist. Rather than pull in the Security framework's CMSDecoder, we
  // slice out the <?xml ... </plist> substring — the same trick most native
  // implementations use.
  private static func readEmbeddedProfile() -> [String: Any]? {
    guard let url = Bundle.main.url(forResource: "embedded", withExtension: "mobileprovision"),
          let data = try? Data(contentsOf: url),
          let raw = String(data: data, encoding: .isoLatin1),
          let start = raw.range(of: "<?xml"),
          let end = raw.range(of: "</plist>") else {
      return nil
    }
    let plistSlice = String(raw[start.lowerBound..<end.upperBound])
    guard let plistData = plistSlice.data(using: .isoLatin1),
          let plist = try? PropertyListSerialization.propertyList(
            from: plistData,
            options: [],
            format: nil
          ) as? [String: Any] else {
      return nil
    }
    let iso = ISO8601DateFormatter()
    iso.formatOptions = [.withInternetDateTime]
    var out: [String: Any] = [:]
    if let d = plist["ExpirationDate"] as? Date {
      out["expirationDate"] = iso.string(from: d)
    }
    if let d = plist["CreationDate"] as? Date {
      out["creationDate"] = iso.string(from: d)
    }
    if let n = plist["Name"] as? String {
      out["name"] = n
    }
    return out.isEmpty ? nil : out
  }
}
