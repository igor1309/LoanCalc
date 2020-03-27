//
//  ContentView.swift
//  LoanCalc
//
//  Created by Igor Malyarov on 27.03.2020.
//  Copyright © 2020 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var userData: UserData
    
    
    var body: some View {
        TabView(selection: $userData.selectedTab) {
            LoanView()
                .tabItem {
                    Image(systemName: "doc.plaintext")
                    Text("Loan")
            }
            .tag(0)
            
            LineChart()
                .tabItem {
                    Image(systemName: "chart.bar")
                    Text("Chart")
            }
            .tag(1)
            
            PaymentsView()
                .tabItem {
                    Image(systemName: "table")
                    Text("Table")
            }
            .tag(2)
            
            LoanList()
                .tabItem {
                    Image(systemName: "star")
                    Text("Saved")
            }
            .tag(3)
            
            Text("Settings")
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
            }
            .tag(4)
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            //            Color.black.edgesIgnoringSafeArea(.all)
            ContentView()
                .environmentObject(UserData())
        }
        //        .environment(\.colorScheme, .dark)
    }
}
