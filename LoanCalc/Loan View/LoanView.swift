//
//  LoanView.swift
//  LoanCalc
//
//  Created by Igor Malyarov on 27.03.2020.
//  Copyright © 2020 Igor Malyarov. All rights reserved.
//

import SwiftUI
import SwiftPI

struct LoanView: View {
    @EnvironmentObject var userData: UserData
    @State private var isFavorite = false
    
    private func toggleFavorite() {
        isFavorite.toggle()
        //  MARK: FINISH THIS
        // save or delete from Favorites
        //
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Кредит")
                    .font(.largeTitle)
                    .bold()
                
                Spacer()
                
                Button(action: toggleFavorite) {
                    Image(systemName: isFavorite ? "star.fill" : "star")
                        .foregroundColor(.systemOrange)
                        .imageScale(.large)
                }
            }
            .padding()
            
            CardView(backgroundColor: .secondarySystemBackground, cornerRadius: 8) {
                VStack(spacing: 16) {
                    VStack(spacing: 0) {
                        Text(123456.formattedGrouped)
                            .font(.largeTitle)
                        
                        Text("ежемесячный платеж".uppercased())
                            .font(.footnote)
                    }
                    .foregroundColor(.systemOrange)
                    
                    VStack(spacing: 6) {
                        HStack(alignment: .firstTextBaseline) {
                            Text("Проценты, всего".uppercased())
                                .font(.caption)
                            
                            Spacer()
                            
                            Text(98765.formattedGrouped)
                                .font(.subheadline)
                        }
                        
                        HStack(alignment: .firstTextBaseline) {
                            Text("Кредит и проценты, всего".uppercased())
                                .font(.caption)
                            
                            Spacer()
                            
                            Text(987654.formattedGrouped)
                                .font(.subheadline)
                        }
                    }
                    .foregroundColor(.systemTeal)
                }
            }
            .padding()
            
            CardView(backgroundColor: .secondarySystemBackground, cornerRadius: 8) {
                VStack(spacing: 32) {
                    VStack(spacing: 16) {
                        Text("измените параметры для расчета кредита")
                            .foregroundColor(.secondary)
                            .font(.footnote)
                        
                        Picker(selection: .constant(Loan.InterestType.decliningBalance), label: Text("Тип выплаты")) {
                            ForEach(Loan.InterestType.allCases, id: \.self) { type in
                                Text(type.id).tag(type)
                            }
                        }
                        .labelsHidden()
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    
                    LoanParameterRow(amount: $userData.loan.principal,
                                     name: "сумма кредита",
                                     isPercentage: false)
                    LoanParameterRow(amount: $userData.loan.rate,
                                     name: "годовая процентная ставка",
                                     isPercentage: true)
                    LoanParameterRow(amount: $userData.loan.term,
                                     name: "срок кредита, месяцев\n(\(userData.loan.termInYears.formattedGroupedWith1Decimal) лет)",
                        isPercentage: false)
                }
            }
            .padding()
            
            Spacer()
        }
    }
    
}

struct LoanView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            LoanView()
        }
        .environmentObject(UserData())
        .environment(\.colorScheme, .dark)
    }
}
