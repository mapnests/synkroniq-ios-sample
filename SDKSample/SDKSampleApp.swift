import SwiftUI
import synkroniqSDK

@main
struct SDKSampleApp: App {

    init() {
        SynkroniqSDK.shared.initialize(
            apiKey: "",
            platform: ""
        )
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
