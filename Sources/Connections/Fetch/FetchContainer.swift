import SwiftUI
import Contacts

/// Fetches a single container from the `Contacts` framework
@propertyWrapper
public struct FetchContainer: DynamicProperty {
    @ObservedObject private var observer: ContainersObserver
    public var store: CNContactStore { observer.store }
    public var wrappedValue: CNContainer? {
        observer.results.first
    }
}

public extension FetchContainer {

    /// Fetches contact containers based on the specified predicate
    /// - Parameter predicate: The predicate to use to filter the list of groups
    init(
        identifier: CNContainer.ID,
        animation: Animation? = .default
    ) {
        self.init(observer: ContainersObserver(predicate: CNGroup.predicateForGroups(withIdentifiers: [identifier]), animation: animation))
    }

}
