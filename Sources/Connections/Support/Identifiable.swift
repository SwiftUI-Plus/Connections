import Foundation
import Contacts

@available(iOS, obsoleted: 16, message: "Contacts module includes it in iOS17+, macOS14+")
@available(macOS, obsoleted: 14, message: "Contacts module includes it in iOS17+, macOS14+")
extension CNContact: Identifiable {
    public typealias ID = UUID
    public var id: UUID {
        UUID(uuidString: identifier.replacingOccurrences(of: ":ABPerson", with: ""))! 
    }

}

extension CNGroup: Identifiable {
    public var id: String { identifier }
}

extension CNContainer: Identifiable {
    public var id: String { identifier }
}
