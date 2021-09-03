import SwiftUI
import Connections

struct GroupListView: View {
    @FetchGroupList private var groups

    var body: some View {
        List {
            NavigationLink(destination: ContactListView(group: nil)) {
                Text("All Contacts")
            }

            ForEach(groups) { group in
                NavigationLink(destination: ContactListView(group: group)) {
                    Text(group.name)
                }
            }
        }
        .navigationBarTitle("Groups")
    }
}
