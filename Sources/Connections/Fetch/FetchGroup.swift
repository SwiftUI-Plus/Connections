import SwiftUI
import Contacts

/// Fetches a single group from the `Contacts` framework
@propertyWrapper
public struct FetchGroup: DynamicProperty {
    @ObservedObject private var observer: GroupsObserver
    public var store: CNContactStore { observer.store }
    public var wrappedValue: CNGroup? {
        observer.results.first
    }
}

public extension FetchGroup {

    /// Fetches contact groups based on the specified predicate
    /// - Parameter predicate: The predicate to use to filter the list of groups
    init(
        identifier: CNGroup.ID,
        animation: Animation? = .default
    ) {
        self.init(observer: GroupsObserver(predicate: CNGroup.predicateForGroups(withIdentifiers: [identifier]), animation: animation))
    }

}
