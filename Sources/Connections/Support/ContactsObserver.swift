import SwiftUI
import Combine
import Contacts

internal final class ContactsObserver: NSObject, ObservableObject {
    @Published internal var results: [CNContact] = []

    internal let store = CNContactStore()
    private let queue = DispatchQueue(label: "com.benkau.contacts-observer")
    private var cancellable: AnyCancellable?

    private let request: CNContactFetchRequest
    private let animation: Animation?

    internal init(request: CNContactFetchRequest, animation: Animation?) {
        self.request = request
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
        queue.async { [weak self] in
            guard let self = self else { return }
            var contacts: [CNContact] = []

            defer {
                DispatchQueue.main.async {
                    withAnimation(animated ? self.animation : nil) { self.results = contacts }
                }
            }

            do {
                try self.store.enumerateContacts(with: self.request) { contact, _ in
                    contacts.append(contact)
                }
            } catch {
                print(error)
            }
        }
    }
}
