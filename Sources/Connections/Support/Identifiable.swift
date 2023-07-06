import Foundation
import Contacts

extension CNContact {
    public var id: String { identifier }
}

extension CNGroup: Identifiable {
    public var id: String { identifier }
}

extension CNContainer: Identifiable {
    public var id: String { identifier }
}
