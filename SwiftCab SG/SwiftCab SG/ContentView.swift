//
//  ContentView.swift
//  SwiftCab SG
//
//  Created by user on 10/6/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
                NavigationView {
                    Explore()
                }
                .tabItem {
                    VStack {
                        Image(systemName: "map.fill")
                        Text("Explore")
                            
                    }
                }
                
                NavigationView {
                    History()
                }
                .tabItem {
                    VStack {
                        Image(systemName: "clock.fill")
                            .padding([.bottom], 1)
                        Text("History")
                    }
                }
                
                NavigationView {
                    About()
                }
                .tabItem {
                    VStack {
                        Image(systemName: "info.circle.fill")
                            .padding([.bottom], 1)
                        Text("About")
                    }
                }
                
                NavigationView{
                    Updates()
                }
                .tabItem {
                    VStack {
                        Image(systemName: "bell.fill")
                            .padding([.bottom], 1)
                        Text("Updates")
                    }
                }
            }
            .accentColor(.blue)
        
        }
    }


#Preview{
    ContentView()
}
