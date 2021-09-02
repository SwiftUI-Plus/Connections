import SwiftUI
import Combine
import Contacts

/// Fetches a set of contacts from the `Contacts` framework
@propertyWrapper
public struct FetchContactList: DynamicProperty {
    @ObservedObject private var observer: ResultsObserver
    public var store: CNContactStore { observer.store }
    
    public var wrappedValue: [CNContact] {
        observer.results
    }
}

public extension FetchContactList {

    /// Instantiates a fetch with the specified attributes
    /// - Parameters:
    ///   - keysToFetch: The contact keys to fetch
    ///   - sortOrder: The sort order to return the results
    ///   - predicate: The predicate to filter the results
    ///   - unified: If true, unified contacts will be returned unifed
    init(keysToFetch: [ContactKey],
         sortOrder: CNContactSortOrder = .userDefault,
         predicate: NSPredicate? = nil,
         unified: Bool = true,
         animation: Animation? = .default
    ) {
        let keys = keysToFetch.map { $0.rawValue as CNKeyDescriptor }
        let request = CNContactFetchRequest(keysToFetch: keys)
        request.predicate = predicate
        request.sortOrder = sortOrder
        request.unifyResults = unified
        self.init(observer: ResultsObserver(request: request, animation: animation))
    }
    
}
