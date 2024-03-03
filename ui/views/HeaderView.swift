//
//  HeaderView.swift
//  polysloth
//
//  Created by Denis Ronchese on 02/03/24.
//

import SwiftUI

struct HeaderView<Background: View>: View {
    let backgroundView: Background
    init(@ViewBuilder background: () -> Background) {
        self.backgroundView = background()
    }
    
    @State private var inputText: String = "" // This will hold the text input from the user
    
    var body: some View {
        ZStack {
            backgroundView
            HStack {
                // The text field
                TextField("Start typing...", text: $inputText/*, onCommit: fetchDefinition*/)
                    .textFieldStyle(PlainTextFieldStyle())
                    .foregroundColor(.white)
                    .font(Font.system(size: 18, weight: .thin, design: .rounded))
                    .padding([.leading, .trailing], 30) // Padding on the sides of the text field
                
                Spacer() // Pushes the icon to the right
                
                // The icon (non-clickable)
                Image(systemName: "magnifyingglass") // Make sure "ps-icon.png" is in your asset catalog
                    .resizable() // Allow the image to be resized
                    .aspectRatio(contentMode: .fit) // Keep the aspect ratio of the image
                    .frame(height: 20) // Set the height of the image
                    .padding(.trailing, 30) // Padding on the right side of the icon
            }
        }
        .frame(height: GlobalConstants.Window.headerHeight)
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(background: {
            BlurView(material: .hudWindow, blendingMode: .behindWindow, state: .active)
        })
    }
}
