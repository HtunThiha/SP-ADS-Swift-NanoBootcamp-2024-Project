//
//  History.swift
//  SwiftCab SG
//
//  Created by user on 6/6/24.
//
import SwiftUI
struct History: View {    
   var body: some View {
       NavigationView {
                   VStack{
                       ScrollView {
                           Text("History")
                               .font(.title)
                               .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                               .padding(.leading,15)
                               .fontWeight(.bold)
                           VStack(alignment:.leading){
                               ZStack{
                                   Rectangle()
                                       .frame(maxWidth: .infinity, maxHeight: 300)
                                       .cornerRadius(35.0)
                                       .zIndex(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                                       .foregroundColor(.white)
                                       .overlay(
                                           RoundedRectangle(cornerRadius: 10.0)
                                            .stroke(Color.black, lineWidth: 2)
                                            .foregroundColor(.white)
                                               .zIndex(2.0))
                                   VStack(alignment:.leading){
                                       Text("From\t: Singapore Polytechnic")
                                       Text("To\t\t: Changi Airport")
                                       Text("Time\t: 3:25 PM")
                                   }
                                   .font(.system(size:24))
                                   .padding()
                                   .foregroundColor(.black)
                                   .zIndex(3.0)
                               }
                               .padding()
                               Spacer(minLength: 20)
//                                .padding(.top)
                               ZStack{
                                   Rectangle()
                                       .frame(maxWidth: .infinity, maxHeight: 300)
                                       .cornerRadius(35.0)
                                       .foregroundColor(Color.white)
                                       .zIndex(1)
                                       .overlay(
                                           RoundedRectangle(cornerRadius: 10.0)
                                               .stroke(Color.black, lineWidth: 2)
                                               .foregroundColor(.white))
                                       .zIndex(2)
                                   VStack(alignment:.leading){
                                       Text("From\t: Clementi MRT Station")
                                       Text("To\t\t: Singapore Polytechnic")
                                       Text("Time\t: 8:30 AM")
                                   }
                                   .font(.system(size:24))
                                   .padding()
                                   .foregroundColor(.black)
                                   .zIndex(3)
                               }.padding()
//                                .padding(.top)
                           }
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
    History()
}
