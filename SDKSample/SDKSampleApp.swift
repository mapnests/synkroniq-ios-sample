import SwiftUI
import synkroniqSDK

@main
struct SDKSampleApp: App {

    init() {
        SynkroniqSDK.shared.initialize(
            apiKey: "ieMQ1nLN5PU6quK6WrOQOCutr6thNAo05vTSn-aDBr0",
            platform: "web"
        )
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
