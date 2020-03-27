//
//  LineChart.swift
//  LoanCalc
//
//  Created by Igor Malyarov on 28.03.2020.
//  Copyright © 2020 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct LineChart: View {
    @EnvironmentObject var userData: UserData
    
    var series: [Double] { userData.schedule.payments.map { $0.principal } }
    
    var body: some View {
//        CardView {
            ZStack {
                LineGraphGrid(series: series, numberOfGridLines: 10)
                
                LineGraphShape(series: series)
                    .stroke(Color.systemTeal, lineWidth: 1)
            }
//        }
        .padding()
    }
}

struct LineChart_Previews: PreviewProvider {
    static var previews: some View {
        LineChart()
            .environmentObject(UserData())
    }
}
