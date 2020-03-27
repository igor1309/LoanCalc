//
//  LoanView.swift
//  LoanCalc
//
//  Created by Igor Malyarov on 27.03.2020.
//  Copyright © 2020 Igor Malyarov. All rights reserved.
//

import SwiftUI
import SwiftPI

extension VerticalAlignment {
    enum Custom: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[VerticalAlignment.top]
        }
    }
    
    static let custom = VerticalAlignment(Custom.self)
}

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
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading) {
                CardView(backgroundColor: .secondarySystemBackground, cornerRadius: 16) {
                    VStack(spacing: 16) {
                        HStack(alignment: .custom) {
                            VStack(spacing: 0) {
                                Text(userData.loan.monthlyPaymentStr)
                                    .font(.largeTitle)
                                    .alignmentGuide(.custom) { d in d[VerticalAlignment.top] }
                                
                                Text("ежемесячный платеж".uppercased())
                                    .font(.footnote)
                            }
                            .foregroundColor(.systemOrange)
                            .frame(maxWidth: .infinity)
                            
                            Spacer()
                            
                            Button(action: toggleFavorite) {
                                Image(systemName: isFavorite ? "star.fill" : "star")
                                    .foregroundColor(.systemOrange)
//                                    .imageScale(.large)
                            }
                            .alignmentGuide(.custom) { d in d[VerticalAlignment.top] }
                        }
                        
                        VStack(spacing: 6) {
                            HStack(alignment: .firstTextBaseline) {
                                Text("Проценты, всего".uppercased())
                                    .font(.caption)
                                
                                Spacer()
                                
                                Text(userData.loan.totalInterestStr)
                                    .font(.subheadline)
                            }
                            
                            HStack(alignment: .firstTextBaseline) {
                                Text("Кредит и проценты, всего".uppercased())
                                    .font(.caption)
                                    .lineLimit(nil)
                                
                                Spacer()
                                
                                Text(userData.loan.totalPaymentsStr)
                                    .font(.subheadline)
                            }
                        }
                        .foregroundColor(.systemTeal)
                    }
                }
                .padding()
                
                CardView(backgroundColor: .secondarySystemBackground, cornerRadius: 16) {
                    VStack(spacing: 32) {
                        VStack(spacing: 16) {
                            Text("измените параметры для расчета кредита")
                                .foregroundColor(.secondary)
                                .font(.footnote)
                            
                            Picker(selection: $userData.loan.type, label: Text("Тип выплаты")) {
                                ForEach(Loan.InterestType.allCases, id: \.self) { type in
                                    Text(type.id.uppercased()).tag(type)
                                }
                            }
                            .labelsHidden()
                            .pickerStyle(SegmentedPickerStyle())
                        }
                        
                        LoanParameterRow(amountStr: userData.loan.principalStr,
                                         name: "сумма кредита",
                                         param: .principal)
                        LoanParameterRow(amountStr: userData.loan.rateStr,
                                         name: "годовая процентная ставка",
                                         param: .rate)
                        LoanParameterRow(amountStr: userData.loan.termStr,
                                         name: "срок кредита, месяцев\n(\(userData.loan.termInYearsStr) лет)",
                            param: .term)
                    }
                }
                .padding()
                
                Spacer()
            }
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
