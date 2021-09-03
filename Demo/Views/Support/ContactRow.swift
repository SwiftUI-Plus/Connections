import SwiftUI
import Connections

struct ContactRow: View {
    let label: String
    let value: String

    var body: some View {
        if !value.isEmpty {
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(CNLabeledValue<NSString>.localizedString(forLabel: label))
                        .font(.footnote)
                        .foregroundColor(.primary.opacity(0.8))
                    Text(value)
                }
                .padding(.vertical, 5)

                Spacer(minLength: 0)
            }
        }
    }
}

struct ContactRow_Previews: PreviewProvider {
    static var previews: some View {
        ContactRow(label: "label", value: "value")
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
