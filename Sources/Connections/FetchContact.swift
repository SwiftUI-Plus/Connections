import SwiftUI
import Combine
import Contacts

@propertyWrapper
public struct FetchContact: DynamicProperty {
    @ObservedObject private var observer: ResultsObserver
    public var store: CNContactStore { observer.store }

    public var wrappedValue: CNContact? {
        observer.results.first
    }
}

public extension FetchContact {

    init(
        idenfifier: String,
        keysToFetch: [ContactKey],
        mutable: Bool = false,
        animation: Animation? = .default
    ) {
        let keys = keysToFetch.map { $0.rawValue as CNKeyDescriptor }
        let request = CNContactFetchRequest(keysToFetch: keys)
        request.predicate = CNContact.predicateForContacts(withIdentifiers: [idenfifier])
        self.init(observer: ResultsObserver(request: request, animation: animation))
    }

}
