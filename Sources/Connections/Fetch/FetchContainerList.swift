import SwiftUI
import Contacts

/// Fetches a list of containers from the `Contacts` framework
@propertyWrapper
public struct FetchContainerList: DynamicProperty {
    @ObservedObject private var observer: ContainersObserver
    public var store: CNContactStore { observer.store }
    public var wrappedValue: [CNContainer] {
        observer.results
    }

    public init() {
        self.init(predicate: nil)
    }

    internal init(observer: ContainersObserver) {
        self.observer = observer
    }
}

public extension FetchContainerList {

    /// Fetches containers based on the specified predicate
    /// - Parameter predicate: The predicate to use to filter the list of containers
    init(
        predicate: NSPredicate? = nil,
        animation: Animation? = .default
    ) {
        self.init(observer: ContainersObserver(predicate: predicate, animation: animation))
    }

    /// Fetches containers matching the specified identifiers
    /// - Parameters:
    ///   - identifiers: The identifiers of the containers
    init(
        identifiers: [CNContainer.ID],
        animation: Animation? = .default
    ) {
        self.init(predicate: CNContainer.predicateForContainers(withIdentifiers: identifiers), animation: animation)
    }

    /// Fetches containers that contain the specified group
    /// - Parameters:
    ///   - container: The identifier of the group
    init(
        forGroup identifier: CNGroup.ID,
        animation: Animation? = .default
    ) {
        self.init(predicate: CNContainer.predicateForContainerOfGroup(withIdentifier: identifier), animation: animation)
    }

    /// Fetches containers that contain the specified contact
    /// - Parameters:
    ///   - container: The identifier of the contact
    init(
        forContact identifier: String,
        animation: Animation? = .default
    ) {
        self.init(predicate: CNContainer.predicateForContainerOfContact(withIdentifier: identifier), animation: animation)
    }

}
