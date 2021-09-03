import SwiftUI
import Contacts

/// Fetches a list of groups from the `Contacts` framework
@propertyWrapper
public struct FetchGroupList: DynamicProperty {
    @ObservedObject private var observer: GroupsObserver
    public var store: CNContactStore { observer.store }
    public var wrappedValue: [CNGroup] {
        observer.results
    }

    public init() {
        self.init(predicate: nil)
    }

    internal init(observer: GroupsObserver) {
        self.observer = observer
    }
}

public extension FetchGroupList {

    /// Fetches contact groups based on the specified predicate
    /// - Parameter predicate: The predicate to use to filter the list of groups
    init(
        predicate: NSPredicate? = nil,
        animation: Animation? = .default
    ) {
        self.init(observer: GroupsObserver(predicate: predicate, animation: animation))
    }

    /// Fetches groups matching the specified identifiers
    /// - Parameters:
    ///   - identifiers: The identifiers of the groups
    init(
        identifiers: [CNGroup.ID],
        animation: Animation? = .default
    ) {
        self.init(predicate: CNGroup.predicateForGroups(withIdentifiers: identifiers), animation: animation)
    }

    /// Fetches groups in the container with the specified identifier
    /// - Parameters:
    ///   - container: The identifier of the container
    init(
        inContainer identifier: CNContainer.ID,
        animation: Animation? = .default
    ) {
        self.init(predicate: CNGroup.predicateForGroupsInContainer(withIdentifier: identifier), animation: animation)
    }

}
