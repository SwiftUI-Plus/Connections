import SwiftUI
import Connections

extension ContactView {

    @ViewBuilder
    func name(for contact: CNContact) -> some View {
        Section {
            ContactRow(label: "given name", value: contact.givenName)
            ContactRow(label: "middle name", value: contact.middleName)
            ContactRow(label: "family name", value: contact.familyName)
            ContactRow(label: "nickname", value: contact.nickname)
            ContactRow(label: "company", value: contact.organizationName)
            ContactRow(label: "department", value: contact.departmentName)
            ContactRow(label: "job title", value: contact.jobTitle)
        }
    }

    @ViewBuilder
    func numbers(for contact: CNContact) -> some View {
        if !contact.phoneNumbers.isEmpty {
            Section {
                ForEach(contact.phoneNumbers, id: \.identifier) { number in
                    linkedView(
                        label: number.label ?? "other",
                        value: number.value.stringValue,
                        url: URL(string: "tel:\(number.value.stringValue.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? number.value.stringValue)")
                    )
                }
            }
        }
    }

    @ViewBuilder
    func emails(for contact: CNContact) -> some View {
        if !contact.emailAddresses.isEmpty {
            Section {
                ForEach(contact.emailAddresses, id: \.identifier) { email in
                    linkedView(label: email.label ?? "other", value: email.value as String, url: URL(string: "mailto:\(email.value as String)"))
                }
            }
        }
    }

    @ViewBuilder
    func urls(for contact: CNContact) -> some View {
        if !contact.urlAddresses.isEmpty {
            Section {
                ForEach(contact.urlAddresses, id: \.identifier) { url in
                    linkedView(label: url.label ?? "other", value: url.value as String, url: URL(string: url.value as String))
                }
            }
        }
    }

    @ViewBuilder
    func addresses(for contact: CNContact) -> some View {
        if !contact.postalAddresses.isEmpty {
            Section {
                ForEach(contact.postalAddresses, id: \.identifier) { address in
                    Button {
                        show(address.value)
                    } label: {
                        ContactRow(label: address.label ?? "other", value: CNPostalAddressFormatter.string(from: address.value, style: .mailingAddress))
                    }
                }
            }
        }
    }

    @ViewBuilder
    func dates(for contact: CNContact) -> some View {
        if contact.birthday != nil || !contact.dates.isEmpty {
            Section {
                if let birthday = contact.birthday, let interval = self.date(from: birthday)?.timeIntervalSinceReferenceDate {
                    linkedView(
                        label: "birthday",
                        value: string(from: birthday),
                        url: URL(string: "calshow:\(interval)")
                    )
                }

                if !contact.dates.isEmpty {
                    ForEach(contact.dates, id: \.identifier) { date in
                        if let interval = self.date(from: date.value as DateComponents)?.timeIntervalSinceReferenceDate {
                            linkedView(
                                label: date.label ?? "other",
                                value: string(from: date.value as DateComponents),
                                url: URL(string: "calshow:\(interval)")
                            )
                        }
                    }
                }
            }
        }
    }

    @ViewBuilder
    func relationships(for contact: CNContact) -> some View {
        if !contact.contactRelations.isEmpty {
            Section {
                ForEach(contact.contactRelations, id: \.identifier) { relationship in
                    ContactRow(label: relationship.label ?? "other", value: relationship.value.name)
                }
            }
        }
    }

    @ViewBuilder
    func social(for contact: CNContact) -> some View {
        if !contact.socialProfiles.isEmpty {
            Section {
                ForEach(contact.socialProfiles, id: \.identifier) { profile in
                    ContactRow(label: profile.label ?? "other", value: profile.value.username)
                }
            }
        }
    }
    
}
