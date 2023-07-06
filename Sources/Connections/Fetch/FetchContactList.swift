import SwiftUI
import Combine
import Contacts

/// Fetches a list of contacts from the `Contacts` framework
@propertyWrapper
public struct FetchContactList: DynamicProperty {
    @ObservedObject private var observer: ContactsObserver
    public var store: CNContactStore { observer.store }
    public var wrappedValue: [CNContact] {
        observer.results
    }

    public init() {
        self.init(keysToFetch: .allExcludingNote)
    }

    internal init(observer: ContactsObserver) {
        self.observer = observer
    }
}

public extension FetchContactList {

    /// Fetches contacts based on the specified search criteria
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
        self.init(observer: ContactsObserver(request: request, animation: animation))
    }

    /// Fetches contacts matching the specified phone number
    /// - Parameters:
    ///   - phoneNumber: The phone number to match
    ///   - keysToFetch: The contact keys to fetch
    ///   - sortOrder: The sort order to return the results
    ///   - unified: If true, unified contacts will be returned unifed
    init(
        phoneNumber: String,
        keysToFetch: [ContactKey],
        sortOrder: CNContactSortOrder = .userDefault,
        unified: Bool = true,
        animation: Animation? = .default
    ) {
        self.init(
            keysToFetch: keysToFetch,
            sortOrder: sortOrder,
            predicate: CNContact.predicateForContacts(matching: CNPhoneNumber(stringValue: phoneNumber)),
            unified: unified,
            animation: animation
        )
    }

    /// Fetches contacts matching the specified email address
    /// - Parameters:
    ///   - email: The email address to match
    ///   - keysToFetch: The contact keys to fetch
    ///   - sortOrder: The sort order to return the results
    ///   - unified: If true, unified contacts will be returned unifed
    init(
        email: String,
        keysToFetch: [ContactKey],
        sortOrder: CNContactSortOrder = .userDefault,
        unified: Bool = true,
        animation: Animation? = .default
    ) {
        self.init(
            keysToFetch: keysToFetch,
            sortOrder: sortOrder,
            predicate: CNContact.predicateForContacts(matchingEmailAddress: email),
            unified: unified,
            animation: animation
        )
    }

    /// Fetches contacts matching the specified name
    /// - Parameters:
    ///   - name: The name to match
    ///   - keysToFetch: The contact keys to fetch
    ///   - sortOrder: The sort order to return the results
    ///   - unified: If true, unified contacts will be returned unifed
    init(
        name: String,
        keysToFetch: [ContactKey],
        sortOrder: CNContactSortOrder = .userDefault,
        unified: Bool = true,
        animation: Animation? = .default
    ) {
        self.init(
            keysToFetch: keysToFetch,
            sortOrder: sortOrder,
            predicate: CNContact.predicateForContacts(matchingName: name),
            unified: unified,
            animation: animation
        )
    }

    /// Fetches contacts matching the specified identifiers
    /// - Parameters:
    ///   - identifiers: The identifiers to match
    ///   - keysToFetch: The contact keys to fetch
    ///   - sortOrder: The sort order to return the results
    ///   - unified: If true, unified contacts will be returned unifed
    init(
        identifiers: [String],
        keysToFetch: [ContactKey],
        sortOrder: CNContactSortOrder = .userDefault,
        unified: Bool = true,
        animation: Animation? = .default
    ) {
        self.init(
            keysToFetch: keysToFetch,
            sortOrder: sortOrder,
            predicate: CNContact.predicateForContacts(withIdentifiers: identifiers),
            unified: unified,
            animation: animation
        )
    }

    /// Fetches contacts contained in the specified group
    /// - Parameters:
    ///   - identifier: The group identifier to match
    ///   - keysToFetch: The contact keys to fetch
    ///   - sortOrder: The sort order to return the results
    ///   - unified: If true, unified contacts will be returned unifed
    init(
        inGroup identifier: CNGroup.ID,
        keysToFetch: [ContactKey],
        sortOrder: CNContactSortOrder = .userDefault,
        unified: Bool = true,
        animation: Animation? = .default
    ) {
        self.init(
            keysToFetch: keysToFetch,
            sortOrder: sortOrder,
            predicate: CNContact.predicateForContactsInGroup(withIdentifier: identifier),
            unified: unified,
            animation: animation
        )
    }

    /// Fetches contacts contained in the specified container
    /// - Parameters:
    ///   - identifier: The container identifier to match
    ///   - keysToFetch: The contact keys to fetch
    ///   - sortOrder: The sort order to return the results
    ///   - unified: If true, unified contacts will be returned unifed
    init(
        inContainer identifier: CNContainer.ID,
        keysToFetch: [ContactKey],
        sortOrder: CNContactSortOrder = .userDefault,
        unified: Bool = true,
        animation: Animation? = .default
    ) {
        self.init(
            keysToFetch: keysToFetch,
            sortOrder: sortOrder,
            predicate: CNContact.predicateForContactsInContainer(withIdentifier: identifier),
            unified: unified,
            animation: animation
        )
    }
    
}
