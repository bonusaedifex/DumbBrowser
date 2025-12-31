import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var appState: AppState

    var body: some View {
        Group {
            if let url = appState.currentURL {
                WebView(url: url)
                    .edgesIgnoringSafeArea(.all)
            } else {
                VStack(spacing: 16) {
                    Image(systemName: "link")
                        .font(.system(size: 48, weight: .bold))
                        .foregroundColor(.accentColor)

                    Text("DumbBrowser")
                        .font(.title2)
                        .fontWeight(.semibold)

                    Text("Open a link from another app to view it here. This app intentionally has no search bar.")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.secondary)
                        .padding(.horizontal, 24)

                    if let lastURL = appState.lastOpenedURLString {
                        Text("Last opened: \(lastURL)")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                            .padding(.horizontal, 24)
                    }
                }
                .padding()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AppState())
    }
}
