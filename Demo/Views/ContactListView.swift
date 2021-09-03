import SwiftUI
import Connections

struct ContactListView: View {

    // This is the only code required to fetch your contacts list
    @FetchContactList private var contacts

    @State private var promptAddContact: Bool = false
    @State private var error: Error?

    init(group: CNGroup?) {
        _contacts = FetchContactList(
            keysToFetch: [
                .type,
                .givenName, .familyName,
                .organizationName,
                .phoneNumbers
            ],
            sortOrder: .givenName,
            predicate: group.flatMap {
                CNContact.predicateForContactsInGroup(withIdentifier: $0.identifier)
            }
        )
    }

    var body: some View {
        Group {
            if contacts.isEmpty {
                Text("No contacts available")
                    .foregroundColor(.secondary)
            } else {
                List(contacts) { contact in
                    NavigationLink(destination: ContactView(identifier: contact.identifier)) {
                        if contact.contactType == .person {
                            HStack {
                                Image(systemName: "person.crop.circle")
                                    .foregroundColor(.accentColor)
                                Text(contact.givenName)
                                    .fontWeight(.semibold)
                                    + Text(" " + contact.familyName)
                            }
                        } else {
                            HStack {
                                Image(systemName: "building.2.crop.circle")
                                    .foregroundColor(.accentColor)
                                Text(contact.organizationName)
                                    .fontWeight(.bold)
                            }
                        }
                    }
                }
            }
        }
        .navigationBarTitle("Contacts")
        .navigationBarItems(trailing: addButton)
    }

    private var addButton: some View {
        Button {
            promptAddContact = true
        } label: {
            Image(systemName: "plus")
        }
        .actionSheet(isPresented: $promptAddContact) {
            ActionSheet(
                title: Text("Add contact"),
                message: Text("This will add a demo contact to your contacts list"),
                buttons: [
                    .default(Text("Add Demo Contact"), action: addContact),
                    .cancel()
                ]
            )
        }
        .alert(item: $error) { error in
            Alert(
                title: Text("Failed to delete"),
                message: Text(error.localizedDescription),
                dismissButton: .default(Text("OK"))
            )
        }
    }

    private func addContact() {
        do {
            let request = CNSaveRequest()
            let contact = CNMutableContact()
            contact.givenName = "A Demo"
            contact.familyName = "Contact"
            contact.organizationName = "Apple"

            let address = CNMutablePostalAddress()
            address.street = "300 Post Street"
            address.city = "San Francisco"
            address.postalCode = "94108"
            contact.postalAddresses = [CNLabeledValue(label: "work", value: address)]
            contact.emailAddresses = [CNLabeledValue(label: "support", value: "support@apple.com")]

            let phone = CNPhoneNumber(stringValue: "+1 415-486-4800")
            contact.phoneNumbers = [CNLabeledValue(label: "work", value: phone)]

            request.add(contact, toContainerWithIdentifier: _contacts.store.defaultContainerIdentifier())
            try _contacts.store.execute(request)
        } catch {
            self.error = Error(underlyingError: error)
        }
    }

}
