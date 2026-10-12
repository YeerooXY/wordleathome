import SwiftUI
import SafariServices

private let gameURL = URL(string: "https://our-word-household.nemozoli.chatgpt.site")!

@main
struct OurWordApp: App {
    var body: some Scene {
        WindowGroup { WelcomeView() }
    }
}

struct WelcomeView: View {
    @State private var showingGame = true

    var body: some View {
        VStack(spacing: 22) {
            Image(systemName: "house.fill")
                .font(.system(size: 48)).foregroundStyle(Color(red: 0.16, green: 0.35, blue: 0.26))
            Text("Our Word").font(.system(size: 42, design: .serif))
            Text("A little word. A familiar rivalry.").foregroundStyle(.secondary)
            Button("Play with your household") { showingGame = true }
                .buttonStyle(.borderedProminent).tint(Color(red: 0.16, green: 0.35, blue: 0.26))
            Text("Your submitted guesses and scores are saved online.")
                .font(.footnote).foregroundStyle(.secondary).multilineTextAlignment(.center)
        }
        .padding(30).frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 0.96, green: 0.95, blue: 0.92))
        .fullScreenCover(isPresented: $showingGame) {
            GameBrowser(url: gameURL).ignoresSafeArea()
        }
    }
}

// Safari's system browser view supports hosted ChatGPT sign-in and keeps login
// credentials outside our app. The same responsive game is used on all devices.
struct GameBrowser: UIViewControllerRepresentable {
    let url: URL
    func makeUIViewController(context: Context) -> SFSafariViewController {
        let configuration = SFSafariViewController.Configuration()
        configuration.barCollapsingEnabled = true
        let controller = SFSafariViewController(url: url, configuration: configuration)
        controller.preferredControlTintColor = UIColor(red: 0.16, green: 0.35, blue: 0.26, alpha: 1)
        controller.preferredBarTintColor = UIColor(red: 0.96, green: 0.95, blue: 0.92, alpha: 1)
        controller.dismissButtonStyle = .close
        return controller
    }
    func updateUIViewController(_ controller: SFSafariViewController, context: Context) {}
}
