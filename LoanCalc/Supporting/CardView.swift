//
//  CardView.swift
//  LoanCalc
//
//  Created by Igor Malyarov on 27.03.2020.
//  Copyright © 2020 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct CardView<Content: View>: View {
    let backgroundColor: Color
    let cornerRadius: CGFloat
    let content: Content

    init(backgroundColor: Color = .secondarySystemBackground, cornerRadius: CGFloat = 8, @ViewBuilder content: () -> Content) {
        self.backgroundColor = backgroundColor
        self.cornerRadius = cornerRadius
        self.content = content()
    }

    var body: some View {
        content
            .padding()
            .background(backgroundColor)
            .cornerRadius(cornerRadius)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView {
            Text("TEST")
        }
    }
}
