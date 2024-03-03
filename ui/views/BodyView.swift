//
//  BodyView.swift
//  polysloth
//
//  Created by Denis Ronchese on 02/03/24.
//

import SwiftUI

struct BodyView<Background: View>: View {
    let backgroundView: Background
    init(@ViewBuilder background: () -> Background) {
        self.backgroundView = background()
    }
    var body: some View {
        ZStack {
            backgroundView
            ScrollView {
                Divider()
                Text("Prova prova")
            }
            .frame(maxWidth: .infinity)
            /*.transition(.opacity)*/ // Optional: Add a transition for when the content appears/disappears
        }
    }
}

struct BodyView_Previews: PreviewProvider {
    static var previews: some View {
        BodyView(background: {
            BlurView(material: .hudWindow, blendingMode: .behindWindow, state: .active)
        })
    }
}
