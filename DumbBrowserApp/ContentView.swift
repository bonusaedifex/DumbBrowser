import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var appState: AppState
    @StateObject private var webViewStore = WebViewStore()

    var body: some View {
        Group {
            if let url = appState.currentURL {
                WebView(store: webViewStore)
                    .edgesIgnoringSafeArea(.all)
                    .toolbar {
                        ToolbarItemGroup(placement: .bottomBar) {
                            Button(action: webViewStore.goBack) {
                                Image(systemName: "chevron.left")
                            }
                            .disabled(!webViewStore.canGoBack)

                            Button(action: webViewStore.goForward) {
                                Image(systemName: "chevron.right")
                            }
                            .disabled(!webViewStore.canGoForward)

                            Spacer()

                            Button(action: webViewStore.reload) {
                                Image(systemName: "arrow.clockwise")
                            }
                        }
                    }
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
        .onChange(of: appState.currentURL) { _, newURL in
            if let url = newURL {
                webViewStore.load(url: url)
            }
        }
        .onAppear {
            if let url = appState.currentURL {
                webViewStore.load(url: url)
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
