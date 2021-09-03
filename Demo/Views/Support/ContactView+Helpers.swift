import SwiftUI
import Connections
import CoreLocation
import MapKit

extension ContactView {

    var title: String {
        guard let contact = contact else {
            return "Details"
        }

        return CNContactFormatter.string(from: contact, style: .fullName) ?? "Details"
    }

    @ViewBuilder
    func linkedView(label: String, value: String, url: URL?) -> some View {
        if let url = url {
            Button {
                UIApplication.shared.open(url)
            } label: {
                ContactRow(label: label, value: value)
            }
        } else {
            ContactRow(label: label, value: value)
        }
    }

    static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }()

    func date(from components: DateComponents) -> Date? {
        return Calendar.current.date(from: components)
    }

    func string(from components: DateComponents) -> String {
        guard let date = date(from: components) else { return "Invalid date" }
        return Self.formatter.string(from: date)
    }

    func show(_ address: CNPostalAddress) {
        CLGeocoder().geocodePostalAddress(address) { placemarks, error in
            guard let placemark = placemarks?.first else { return }
            let region = MKCoordinateRegion(center: placemark.location!.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
            let options = [
                MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: region.center),
                MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: region.span)
            ]
            let item = MKMapItem(placemark: MKPlacemark(placemark: placemark))
            item.openInMaps(launchOptions: options)
        }
    }

}

public struct Error: LocalizedError, Identifiable {
    public var id: Int { (underlyingError as NSError).code }
    var underlyingError: Swift.Error
    public var errorDescription: String? {
        underlyingError.localizedDescription
    }
}
