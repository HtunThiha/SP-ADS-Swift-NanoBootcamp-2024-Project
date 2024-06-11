//  Explore.swift
//  SwiftCab SG
//
//  Created on 4/6/24.
//

import MapKit
import SwiftUI
import UIKit
import CoreLocation
import Foundation

struct Explore: View {
    @State private var directions: [String] = [""]
    @State private var showDirections = false
    @State private var showMapInput = true
    @State private var showAlert = false
    @State private var isFirstMapState: Bool = true
    @State private var mapCounter: Int = 0
    @State private var address1: String = ""
    @State private var coordinates1: [(address: String , latitude: Double, longitude: Double)] = []
    @State private var address2: String = ""
    @State private var coordinates2: [(address: String, latitude: Double, longitude: Double)] = []
    @State private var position: MapCameraPosition = .userLocation(fallback: .automatic)
    @FocusState var isFocused: FormFieldFocus?
    @State private var distance: CLLocationDistance = 0
    @State private var locationError: Bool = false
    
    class Table: ObservableObject {
        @Published var name: String
        @Published var price: Double
        
        init(name: String, price: Double) {
            self.name = name
            self.price = price
        }
    }
    
    @StateObject var grab = Table(name: "Grab", price: Double.random(in: 1...1.5))
    @StateObject var gojek = Table(name: "Gojek", price: Double.random(in: 1...1.5))
    @StateObject var delgro = Table(name: "ComfortDelgro", price: Double.random(in: 1...1.5))
    
    @State var tableArray = [Table]()
    
    init() {
        _tableArray = State(initialValue: [grab, gojek, delgro])
    }
    
    private let geocoder = CLGeocoder()
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    if isFirstMapState {
                        VStack {
                            ZStack{
                                if mapCounter != 0 {
                                    Button(
                                        action: {
                                            isFirstMapState = false
                                        }){
                                            HStack{
                                                Image(systemName: "arrow.right")
                                                Text("Previous location")
                                            }
                                            .foregroundColor(.white)
                                        }
                                        .zIndex(2)
                                        .padding(5)
                                        .padding(.leading, 5)
                                        .padding(.trailing,5)
                                        .background(Color.blue)
                                        .cornerRadius(10)
                                        .offset(x: 95, y: 240)
                                        .shadow(color: Color.black, radius: 3, x: 0, y: 2)
                                }
                                Map(position: $position) {
                                    
                                }
                                .zIndex(1)
                                .mapControls {
                                    MapUserLocationButton()
                                        .padding(.trailing,1000)
                                }
                                
                                
                            }
                                Button(action: {
                                    self.showDirections.toggle()
                                    if mapCounter != 0 {
                                        self.isFirstMapState.toggle()
                                    }
                                }) {
                                    Image(systemName: "magnifyingglass.circle.fill")
                                        .resizable()
                                        .frame(width: 25, height: 25)
                                    Text("Search Locations and Directions")
                                        .font(.system(size: 20))
                                }
                                .padding(15)
                                .padding(.bottom, 8)
                            
                        }
                    } else {
                        ZStack{
                            Button(
                                action: {
                                    isFirstMapState = true
                                }){
                                    HStack{
                                        Image(systemName: "arrow.left")
                                        Text("Go back")
                                    }
                                    .foregroundColor(.white)
                                }
                                .zIndex(2)
                                .padding(5)
                                .padding(.leading, 5)
                                .padding(.trailing,5)
                                .background(Color.blue)
                                .cornerRadius(10)
                                .offset(x: 125, y: 110)
                                .shadow(color: Color.black, radius: 3, x: 0, y: 2)
                                SecondMapView(
                                    showDirections: $showDirections,
                                    directions: $directions,
                                    startinglatitude: $coordinates1[0].latitude,
                                    startinglongitude: $coordinates1[0].longitude,
                                    destinationlatitude: $coordinates2[0].latitude,
                                    destinationlongitude: $coordinates2[0].longitude,
                                    address1: $address1,
                                    address2: $address2,
                                    distance: $distance
                                )
                                .ignoresSafeArea()
                                .zIndex(1)
                            
                        }
                        ZStack {
                            VStack {
                                ForEach(tableArray, id: \.name) { table in
                                    let finalPrice = table.price * (0.8 * (distance/1000)) + 5
                                    VStack(alignment:.leading) {
                                        HStack {
                                            Image("\(table.name)")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 90, height: 30)
                                            Button(action: { self.showAlert = true }) {
                                                ZStack{
                                                    Rectangle()
                                                        .frame(width: 200, height: 50)
                                                        .cornerRadius(35.0)
                                                        .foregroundColor(Color.white)
                                                    HStack{
                                                        Text("$")
                                                            .offset(x: -20)
                                                            .font(.system(size:22))
                                                        
                                                        Text("\(String(format: "%.2f", finalPrice))")
                                                            .font(.system(size: 20))
                                                    }
                                                }.padding()
                                            }
                                            .alert(isPresented: $showAlert) {
                                                Alert(title: Text("Booking confirmed."))
                                            }
                                        }
                                    }
                                    .padding(.leading, 100)
                                    .padding(.trailing, 100)
                                }
                            }
                            .onAppear {
                                tableArray.sort { $0.price < $1.price }
                            }
                            .background(Color.clear)
                            .frame(minWidth: 400)
                            .zIndex(1)
                            
                            Image("taxi-fares-background")
                                .resizable()
                                .frame(minWidth: 400)
                                .zIndex(0)
                                .offset(y: -8)
                        }
                        Button(action: {
                            self.showDirections.toggle()
                            if mapCounter != 0 {
                                self.isFirstMapState.toggle()
                            }
                        }) {
                            Image(systemName: "magnifyingglass.circle.fill")
                                .resizable()
                                .frame(width: 25, height: 25)
                            Text("Search Locations and Directions")
                                .font(.system(size: 20))
                                
                        }.padding(15)
                            .offset(y:-8)
                        

                    }
                    
                    VStack {
                        Text("")
                    }
                    .frame(width: 1000, height: 4)
                    .background(Color.brown)
                    
                    Spacer(minLength: 1)
                }
                
                .sheet(isPresented: $showDirections) {
                    VStack  {
                        Spacer(minLength: 20)
                        VStack {
                            Text("")
                        }
                        .frame(width: 100, height: 9)
                        .background(Color.gray)
                        .cornerRadius(10)
                        
                        Spacer(minLength: 20)
                        HStack{
                            Image(systemName: "house.fill")
                                .resizable()
                                .frame(width: 35, height: 35)
                                .foregroundColor(.brown)
                            TextField("Choose starting location", text: $address1)
                                .padding()
                                .background(Color(red: 128/255, green: 128/255, blue: 128/255, opacity: 35/100))
                                .foregroundColor(Color.primary)
                                .frame(width: 310, height: 40)
                                .font(.system(size:20))
                                .cornerRadius(10)
                                .focused($isFocused, equals: .startingLocation)
                                .onSubmit {
                                    convertToCoordinates1(address: address1)
                                }
                        }
                        HStack{
                            Image(systemName: "mappin.and.ellipse")
                                .resizable()
                                .frame(width: 35, height: 35)
                                .foregroundColor(.brown)
                            TextField("Choose destination", text: $address2)
                                .padding()
                                .background(Color(red: 128/255, green: 128/255, blue: 128/255, opacity: 35/100))
                                .foregroundColor(Color.primary)
                                .frame(width: 310, height: 40)
                                .font(.system(size:20))
                                .cornerRadius(10)
                                .focused($isFocused, equals: .endinglocation)
                                .onSubmit {
                                    convertToCoordinates2(address: address2)
                                }
                        }.padding([.bottom], 20)
                        
                        Button(action: {
                            self.showDirections.toggle()
                            self.isFirstMapState.toggle()
                            mapCounter += 1
                        }) {
                            HStack{
                                HStack {
                                    Image(systemName: "location.fill")
                                        .foregroundColor(.black)
                                    Text("Search routes")
                                        .font(.system(size: 25))
                                        .foregroundColor(.black)
                                }.padding()
                            }
                            .frame(height: 50)
                            .background(Color.brown)
                            .cornerRadius(20)
                            .padding(.bottom, 20)
                        }
                        Divider().background(Color(UIColor.systemBrown))
                        VStack{
                            Spacer(minLength: 20)
                            HStack{
                                Image(systemName: "arrow.triangle.turn.up.right.diamond.fill")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                Text("Directions")
                                    .font(.system(size: 25))
                                    .bold()
                            }
                            .padding([.bottom], 20)
                            Divider().background(Color(UIColor.systemBrown))
                                .padding(.bottom, 20)
                            if directions == [""] {
                                Text("Directions will appear after choosing locations.")
                                List{}
                            } else {
                                List(0..<self.directions.count, id: \.self) { i in
                                    HStack {
                                        Image(systemName: directionImage(command: self.directions[i]))
                                            .resizable()
                                            .frame(width: 25, height: 25)
                                            .padding(.leading,10)
                                        Text(self.directions[i]).padding()
                                    }
                                }
                            }
                        }
                        .padding([.bottom],10)
                    }
                }
            }
            .onAppear {
                CLLocationManager().requestWhenInUseAuthorization()
            }
        }
    }
    
    enum FormFieldFocus: Hashable{
        case startingLocation, endinglocation
    }
    
    private func convertToCoordinates1(address: String) {
        geocoder.geocodeAddressString(address) { placemarks, error in
            if let error = error {
                print("Geocoding failed with error: \(error.localizedDescription)")
                return
            }
            if let placemark = placemarks?.first {
                if let location = placemark.location {
                    let coordinate = (address: address, latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                    if mapCounter == 0 {
                        coordinates1.append(coordinate)
                    } else {
                        coordinates1[0].address = coordinate.address
                        coordinates1[0].latitude = coordinate.latitude
                        coordinates1[0].longitude = coordinate.longitude
                    }
                }
            } else {
                print("No coordinates found for the address: \(address)")
            }
        }
    }

    private func convertToCoordinates2(address: String) {
        geocoder.geocodeAddressString(address) { placemarks, error in
            if let error = error {
                print("Geocoding failed with error: \(error.localizedDescription)")
                return
            }
            if let placemark = placemarks?.first {
                if let location = placemark.location {
                    let coordinate = (address: address, latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                    if mapCounter == 0 {
                        coordinates2.append(coordinate)
                    } else {
                        coordinates2[0].address = coordinate.address
                        coordinates2[0].latitude = coordinate.latitude
                        coordinates2[0].longitude = coordinate.longitude
                    }
                }
            } else {
                print("No coordinates found for the address: \(address)")
            }
        }
    }
    
    private func directionImage(command: String) -> String{
        if command.contains("Keep") {
            return "location.north.circle"
        } else {
            if command.contains("U-turn") {
                return "arrow.uturn.down.circle.fill"
            } else if command.contains("left") {
                return "arrowshape.left.fill"
            } else if command.contains("right") {
                return "arrowshape.right.fill"
            } else if command.contains("destination") {
                return "figure.wave.circle.fill"
            } else if command.contains("Continue") {
                return "arrow.up.square.fill"
            } else if command.contains("exit") {
                return "minus.circle.fill"
            } else {
                return ""
            }
        }
    }
}

struct FirstMapView: UIViewRepresentable {
    typealias UIViewType = MKMapView
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        
        let region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 1.3521, longitude: 103.8198),
            span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
        mapView.setRegion(region, animated: true)
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
    }
}

struct SecondMapView: UIViewRepresentable {
    typealias UIViewType = MKMapView
    
    @Binding var showDirections: Bool
    @Binding var directions: [String]
    @Binding var startinglatitude: Double
    @Binding var startinglongitude: Double
    @Binding var destinationlatitude: Double
    @Binding var destinationlongitude: Double
    @Binding var address1: String
    @Binding var address2: String
    @Binding var distance: CLLocationDistance
    
    func makeCoordinator() -> MapViewCoordinator {
        return MapViewCoordinator()
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        
        let p1 = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: startinglatitude, longitude: startinglongitude))
        
        
        let p2 = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: destinationlatitude, longitude: destinationlongitude))
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: p1)
        request.destination = MKMapItem(placemark: p2)
        request.transportType = .automobile
        
        let directions = MKDirections(request: request)
        directions.calculate { response, error in
            guard let route = response?.routes.first else { return }
            mapView.addAnnotation(annotationFromString(address: "Start", subtitle: address1, latitude: startinglatitude, longitude: startinglongitude)!)
            mapView.addAnnotation(annotationFromString(address: "End", subtitle: address2, latitude: destinationlatitude, longitude: destinationlongitude)!)
            mapView.addOverlay(route.polyline)
            mapView.setVisibleMapRect(
                route.polyline.boundingMapRect,
                edgePadding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20),


                animated: true)
            self.directions = route.steps.map { $0.instructions }.filter { !$0.isEmpty }
            self.distance = route.distance
        }
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
    }
    
    class MapViewCoordinator: NSObject, MKMapViewDelegate {
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = .systemBlue
            renderer.lineWidth = 5
            return renderer
        }
    }
    
    class MyAnnotation: NSObject, MKAnnotation {
        var title: String?
        var subtitle: String?
        var coordinate: CLLocationCoordinate2D
        
        init(title: String?, subtitle: String?, coordinate: CLLocationCoordinate2D) {
            self.title = title
            self.subtitle = subtitle
            self.coordinate = coordinate
        }
    }
    
    func annotationFromString(address: String, subtitle: String, latitude: Double, longitude: Double) -> MyAnnotation? {
        let title = address
        let subtitle = subtitle
        let latitude = latitude
        let longitude = longitude
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        return MyAnnotation(title: title, subtitle: subtitle, coordinate: coordinate)
    }
}

#Preview {
    Explore()
}
