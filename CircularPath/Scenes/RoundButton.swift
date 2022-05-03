//
//  RoundButton.swift
//  CircularPath
//
//  Created by Christopher Alford on 3/11/21.
//

import SwiftUI

struct RoundButton: View {

    var radius: CGFloat = 20
    var backgroundColor: Color = .red
    var function: () -> Void

    @State private var selected = false

    var body: some View {
        Button(action: {
            selected.toggle()
            self.function()
        }) {
            ZStack {
                if selected {
                    Circle()
                        .fill(Color.gray.opacity(0.5))
                        .padding(6)
                        .frame(width: radius * 2, height: radius * 2)
                    Circle()
                        .fill(Color("gradientLight"))
                        .padding(4)
                        .frame(width: (radius - 4) * 2, height: (radius - 4) * 2)
                }
                Text(" ")
                    .frame(width: (radius - 10) * 2, height: (radius - 10) * 2)
                    .background(backgroundColor)
                    .cornerRadius(.infinity)
            }
        }
    }
}

struct RoundButton_Previews: PreviewProvider {
    static var previews: some View {
        RoundButton(function: {} )
    }
}
