import Combine
import Foundation
import WebKit

final class WebViewStore: NSObject, ObservableObject, WKNavigationDelegate {
    @Published private(set) var canGoBack = false
    @Published private(set) var canGoForward = false
    @Published private(set) var pageTitle: String?
    @Published private(set) var currentURL: URL?

    let webView: WKWebView

    override init() {
        let configuration = WKWebViewConfiguration()
        configuration.defaultWebpagePreferences.allowsContentJavaScript = true
        let view = WKWebView(frame: .zero, configuration: configuration)
        view.allowsBackForwardNavigationGestures = true
        view.customUserAgent = "DumbBrowser/1.0"
        webView = view
        super.init()
        webView.navigationDelegate = self
        updateState()
    }

    func load(url: URL) {
        guard webView.url != url else { return }
        webView.load(URLRequest(url: url))
    }

    func reload() {
        webView.reload()
    }

    func goBack() {
        webView.goBack()
    }

    func goForward() {
        webView.goForward()
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let requestURL = navigationAction.request.url, requestURL.scheme?.hasPrefix("http") == true {
            decisionHandler(.allow)
        } else {
            decisionHandler(.cancel)
        }
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        updateState()
    }

    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        updateState()
    }

    private func updateState() {
        DispatchQueue.main.async {
            self.canGoBack = self.webView.canGoBack
            self.canGoForward = self.webView.canGoForward
            self.pageTitle = self.webView.title
            self.currentURL = self.webView.url
        }
    }
}
