//
//  Updates.swift
//  SwiftCab SG
//
//  Created by user on 6/6/24.
//

import SwiftUI

struct Updates: View {
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM h:mma"
        return formatter
    }()
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    Text("Updates")
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                        .padding(.leading, 15)
                    Spacer(minLength: 20)
                    VStack(spacing: 10) {
                        Text("Version 1.0.2")
                            .padding(.bottom, 10)
                        Text("Last Checked: \(formattedCurrentDate)")
                        Text("Your app is up to date.")
                    }
                    .multilineTextAlignment(.leading)
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
    
    var formattedCurrentDate: String {
        return dateFormatter.string(from: Date())
    }
}

#Preview {
   Updates()
}
