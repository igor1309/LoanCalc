//
//  LoanList.swift
//  LoanCalc
//
//  Created by Igor Malyarov on 27.03.2020.
//  Copyright © 2020 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct LoanList: View {
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        NavigationView {
            List {
                ForEach(userData.loans, id: \.id) { loan in
                    LoanRow(loan: loan)
                        .onTapGesture {
                            self.userData.loan = loan
                            self.userData.selectedTab = 0
                    }
                }
            }
            .navigationBarTitle("Saved")
        }
    }
}

struct LoanList_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
            
            LoanList()
                .environmentObject(UserData())
        }
        .environment(\.colorScheme, .dark)
    }
}
