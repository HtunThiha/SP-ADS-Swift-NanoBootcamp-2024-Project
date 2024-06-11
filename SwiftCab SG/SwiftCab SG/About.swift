//
//  About.swift
//  SwiftCab SG
//
//  Created by user on 5/6/24.
//

import SwiftUI

struct About: View {
    var body: some View {
        
        NavigationView {
                    VStack{
                        ScrollView {
                            Text("About SwiftCab SG")
                                .font(.title)
                                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                                .padding(.leading,15)
                                .fontWeight(.bold)


                            Image("Image")
                                .resizable()
                                .frame(width: 180, height: 150)
                            
                            Text("\t\tSwiftCab is an iOS application Year 1 Information Technology students from Singapore Polytechnic developed during 2024 Swift Nano Bootcamp. SwiftCab allows users to compare differernt taxi prices of different platforms in a single app, without needing to check different apps for the best prices.")
                                .padding()
                            
                            Spacer(minLength: 40)
                            
                            Image("Grab")
                                .resizable()
                                .frame(width: 180, height: 60)
                            
                            
                            
                            Text("\t\tGrab Delivery Taxi is a service provided by Grab, a Southeast Asian ride-hailing, food delivery, and logistics company. This service allows users to book taxis for the delivery of packages or parcels to desired destinations. It leverages Grab's extensive network of drivers to provide efficient and reliable delivery services, catering to the growing demand for convenient logistics solutions. Users can track the delivery in real-time through the Grab app, ensuring transparency and peace of mind.")
                                .padding()
                            
                                Spacer(minLength: 40)
                            
                            Image("Gojek")
                                .resizable()
                                .frame(width: 180, height: 60)
                            
                            Text("\t\tGojek Taxi is a service provided by Gojek, a leading technology company based in Southeast Asia. This service offers users the convenience of booking taxis through the Gojek app, providing reliable transportation solutions across various cities in the region. With Gojek Taxi, users can quickly and easily hail a taxi, track their ride in real-time, and enjoy the assurance of safety and professionalism from experienced drivers. Gojek Taxi aims to enhance urban mobility by offering seamless and efficient transportation services, contributing to the overall convenience and accessibility of travel for its users.")
                                .padding()
                            
                            Spacer(minLength: 40)
                            
                            Image("ComfortDelgro")
                                .resizable()
                                .frame(width: 180, height: 60)
                                
                            
                            Text("\t\tTara Taxi is a specialized service within the broader Tara digital assistant ecosystem, offered by Gojek, a prominent technology company in Southeast Asia. Tara Taxi provides users with tailored assistance and support specifically for taxi-related needs. Through the Gojek app, users can utilize Tara Taxi to book rides, track their taxi's location in real-time, and access personalized recommendations based on their preferences and travel history. Tara Taxi enhances the convenience and efficiency of taxi services by offering seamless booking experiences, timely updates, and responsive support, ultimately aiming to elevate the overall transportation experience for users within the Gojek ecosystem.")
                                .padding()

                        }
                        VStack {
                            Text("")
                        }
                        .frame(width: 1000, height: 4)
                        .background(Color.brown)
                        
                        Spacer(minLength: 1)

                    }
            
                
        }
    }
}

#Preview {
    About()
}
