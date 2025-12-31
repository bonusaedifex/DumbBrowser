import Combine
import Foundation

final class AppState: ObservableObject {
    static let shared = AppState()

    @Published var currentURL: URL?
    @Published var lastOpenedURLString: String?

    func open(url: URL) {
        guard url.scheme?.hasPrefix("http") == true else { return }
        DispatchQueue.main.async {
            self.currentURL = url
            self.lastOpenedURLString = url.absoluteString
        }
    }
}
