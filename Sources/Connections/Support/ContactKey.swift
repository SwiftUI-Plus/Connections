import Foundation
import Contacts

public enum ContactKey: String {
    /// The type of contact. E.g. person, organization
    case type
    /// The name prefix for this contact. E.g. Dr
    case namePrefix
    /// The given/first name for the contact
    case givenName
    /// The middle name for the contact
    case middleName
    /// The family/last name for the contact
    case familyName
    /// The previous family name for the contact. For example pre-marriage
    case previousFamilyName
    /// The name suffix for this contact. E.g. PhD
    case nameSuffix
    /// The nickname for this contact
    case nickname
    /// The name of the organization associated with the contact
    case organizationName
    /// The name of the department associated with the contact
    case departmentName
    /// The job title for this contact
    case jobTitle
    /// The phonetic spelling of the given/first name for this contact
    case phoneticGivenName
    /// The phonetic spelling of the middle name for this contact
    case phoneticMiddleName
    /// The phonetic spelling of the family/last for this contact
    case phoneticFamilyName
    /// The phonetic spelling of the organization associated with the contact
    case phoneticOrganizationName
    /// A date component for the Gregorian birthday of the contact
    case birthday
    /// A date component for the non-Gregorian birthday of the contact
    case nonGregorianBirthday
    /// A boolean indicating whether a contact has a profile picture
    case hasImage
    /// The profile picture of a contact
    case imageData
    /// The thumbnail version of the contact’s profile picture
    case thumbnailData
    /// The labelled phone numbers for this contact
    case phoneNumbers
    /// The labelled email addresses for this contact
    case emailAddresses
    /// The other labelled gregorian dates associated with this contact
    case dates
    /// The labelled postal address for this contact
    case postalAddresses
    /// The labelled URLs associated with this contact
    case urls
    /// The labelled relationships associated with this contact
    case relationships
    /// The labelled social profiles associated with this contact
    case socialProfiles
    /// The labelled IM addresses associated with this contact
    case instantMessageAddresses
    /// The note attached to this contact. See notes about additional entitlement requirements.
    ///
    /// Requires additional [entitlement](https://developer.apple.com/documentation/bundleresources/entitlements/com_apple_developer_contacts_notes).
    case note

    public var rawValue: String {
        switch self {
        case .type: return CNContactTypeKey
        case .namePrefix: return CNContactNamePrefixKey
        case .givenName: return CNContactGivenNameKey
        case .middleName: return CNContactMiddleNameKey
        case .familyName: return CNContactFamilyNameKey
        case .previousFamilyName: return CNContactPreviousFamilyNameKey
        case .nameSuffix: return CNContactNameSuffixKey
        case .nickname: return CNContactNicknameKey
        case .organizationName: return CNContactOrganizationNameKey
        case .departmentName: return CNContactDepartmentNameKey
        case .jobTitle: return CNContactJobTitleKey
        case .phoneticGivenName: return CNContactPhoneticGivenNameKey
        case .phoneticMiddleName: return CNContactPhoneticMiddleNameKey
        case .phoneticFamilyName: return CNContactPhoneticFamilyNameKey
        case .phoneticOrganizationName: return CNContactPhoneticOrganizationNameKey
        case .birthday: return CNContactBirthdayKey
        case .nonGregorianBirthday: return CNContactNonGregorianBirthdayKey
        case .hasImage: return CNContactImageDataAvailableKey
        case .imageData: return CNContactImageDataKey
        case .thumbnailData: return CNContactThumbnailImageDataKey
        case .phoneNumbers: return CNContactPhoneNumbersKey
        case .emailAddresses: return CNContactEmailAddressesKey
        case .postalAddresses: return CNContactPostalAddressesKey
        case .dates: return CNContactDatesKey
        case .urls: return CNContactUrlAddressesKey
        case .relationships: return CNContactRelationsKey
        case .socialProfiles: return CNContactSocialProfilesKey
        case .instantMessageAddresses: return CNContactInstantMessageAddressesKey
        case .note: return CNContactNoteKey
        }
    }
}

public extension Array where Element == ContactKey {
    /// Includes all known keys excluding `.note` since that requires an additional [entitlement](https://developer.apple.com/documentation/bundleresources/entitlements/com_apple_developer_contacts_notes) and permission from apple.
    static var allExcludingNote: Self {
        [
            .type, .namePrefix, .nameSuffix, .previousFamilyName,
            .givenName, .middleName, .familyName,
            .phoneticGivenName, .phoneticMiddleName, .phoneticFamilyName,
            .nickname, .departmentName, .jobTitle,
            .organizationName, .phoneticOrganizationName,
            .birthday, .nonGregorianBirthday,
            .hasImage, .imageData, .thumbnailData,
            .phoneNumbers, .emailAddresses, .postalAddresses,
            .dates, .urls,
            .relationships, .socialProfiles, .instantMessageAddresses
        ]
    }
}
