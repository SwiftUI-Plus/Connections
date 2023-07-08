import SwiftUI
import Combine
import Contacts

internal final class ContainersObserver: NSObject, ObservableObject {
    @Published internal var results: [CNContainer] = []

    internal let store = CNContactStore()
    private var cancellable: AnyCancellable?

    private let predicate: NSPredicate?
    private let animation: Animation?

    internal init(predicate: NSPredicate?, animation: Animation?) {
        self.predicate = predicate
        self.animation = animation
        super.init()

        self.cancellable = NotificationCenter.default
            .publisher(for: Notification.Name.CNContactStoreDidChange)
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.refetch(animated: true)
            }

        refetch(animated: false)
    }

    private func refetch(animated: Bool) {
        DispatchQueue.global().async { [weak self] in
            guard let self else { return }
            do {
                var containers: [CNContainer] = []
                containers = try self.store.containers(matching: self.predicate)
                DispatchQueue.main.async {
                    withAnimation(animated ? self.animation : nil) { self.results = containers }
                }
            } catch { print(error) }
        }
    }
}
