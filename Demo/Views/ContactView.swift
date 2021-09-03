import SwiftUI
import Connections

struct ContactView: View {

    // Use the property wrapper ensures our view is dismissed if the contact is deleted
    @FetchContact var contact: CNContact?
    @State private var promptForDeletion: Bool = false
    @State private var error: Error?

    // We just pass along the identifier and then lets the property wrapper handle the fetch and observation
    init(identifier: CNContact.ID) {
        _contact = FetchContact(
            idenfifier: identifier,
            keysToFetch: .allExcludingNote
        )
    }

    var body: some View {
        if let contact = contact {
            List {
                name(for: contact)
                numbers(for: contact)
                emails(for: contact)
                urls(for: contact)
                addresses(for: contact)
                dates(for: contact)
                relationships(for: contact)
                social(for: contact)

                Button {
                    promptForDeletion = true
                } label: {
                    HStack {
                        Spacer()
                        Text("Delete")
                        Spacer()
                    }
                }
                .foregroundColor(.red)
            }
            .navigationBarTitle(title)
            .actionSheet(isPresented: $promptForDeletion) {
                ActionSheet(
                    title: Text("Delete"),
                    message: Text("Are you sure you want to permanently delete \(title). This action cannot be undone."),
                    buttons: [
                        .destructive(Text("Delete"), action: delete),
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
        } else {
            Text("No contact found.")
                .foregroundColor(.secondary)
        }
    }

    private func delete() {
        guard let contact = contact?.mutableCopy() as? CNMutableContact else { return }

        do {
            let request = CNSaveRequest()
            request.delete(contact)
            try _contact.store.execute(request)
        } catch {
            self.error = Error(underlyingError: error)
        }
    }

}

struct ContactView_Previews: PreviewProvider {
    static var previews: some View {
        ContactView(identifier: "")
    }
}
