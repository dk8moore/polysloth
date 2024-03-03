//
//  BodyView.swift
//  polysloth
//
//  Created by Denis Ronchese on 02/03/24.
//

import SwiftUI

struct BodyView: View {
    var body: some View {
        
        ScrollView {
            Divider()
            Text("Prova prova")
        }
        .frame(maxWidth: .infinity)
        /*.transition(.opacity)*/ // Optional: Add a transition for when the content appears/disappears
    }
}

struct BodyView_Previews: PreviewProvider {
    static var previews: some View {
        BodyView()
    }
}
