//
//  HomeScreen.swift
//  SwiftCabSG
//
//  Created by user on 5/6/24.
//

import SwiftUI
 
struct LaunchPage: View {
    var body: some View {
        NavigationView{
            VStack {
                Image(.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 200)
                Text("SwiftCab SG")
                    .font(.custom( "DINAlternate-Bold",size:60))
                Text("Find the most affordable **taxi fares**")
                    .padding(.bottom, 130)
                
                
                
                
                NavigationLink( destination: ContentView()
                    .navigationBarBackButtonHidden(true)){
                        Text("Get Started")
                            .frame(width: 300 , height: 60)
                            .background(Color("Color"))
                            .cornerRadius(50)
                            .overlay(
                                RoundedRectangle(cornerRadius:50)
                                    .stroke(Color.black,lineWidth : 2)
                            )
                            .foregroundColor(Color.black)
                            .font(.system(size: 25))
                    }
                
                
            }
            
            
            
        }
    }
    
}
#Preview {
    LaunchPage()
}
