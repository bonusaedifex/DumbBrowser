import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    @ObservedObject var store: WebViewStore

    func makeUIView(context: Context) -> WKWebView {
        store.webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        // Navigation is controlled via WebViewStore.
    }
}
