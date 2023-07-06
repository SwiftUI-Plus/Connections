import SwiftUI
import Combine
import Contacts

/// Fetches a single Contact from the `Contacts` framework
@propertyWrapper
public struct FetchContact: DynamicProperty {
    @ObservedObject private var observer: ContactsObserver
    public var store: CNContactStore { observer.store }

    public var wrappedValue: CNContact? {
        observer.results.first
    }
}

public extension FetchContact {

    /// Fetches a single contact
    /// - Parameters:
    ///   - idenfifier: The identifier of the contact
    ///   - keysToFetch: The keys to fetch for this contact
    init(
        idenfifier: String,
        keysToFetch: [ContactKey] = .allExcludingNote,
        animation: Animation? = .default
    ) {
        let keys = keysToFetch.map { $0.rawValue as CNKeyDescriptor }
        let request = CNContactFetchRequest(keysToFetch: keys)
        request.predicate = CNContact.predicateForContacts(withIdentifiers: [idenfifier])
        self.init(observer: ContactsObserver(request: request, animation: animation))
    }

}
