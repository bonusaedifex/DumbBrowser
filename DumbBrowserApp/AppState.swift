import Combine
import Foundation

final class AppState: ObservableObject {
    @Published var currentURL: URL?
    @Published var lastOpenedURLString: String?

    func open(url: URL) {
        guard url.scheme?.hasPrefix("http") == true else { return }
        currentURL = url
        lastOpenedURLString = url.absoluteString
    }
}
