//
//  ContentView.swift
//  polysloth
//
//  Created by Denis Ronchese on 06/02/24.
//

import SwiftUI

struct ContentView: View {
    @State private var inputText = "" // This will hold the text input from the user
    
    var body: some View {
        VStack {
            // The search bar container
            ZStack {
                // Apply a visual effect for the blur
                BlurView(material: .hudWindow, blendingMode: .behindWindow, state: .active) // Choose the appropriate style for your needs
                    .frame(height: 60)
                    .cornerRadius(20)
                    .frame(maxWidth: .infinity)

                // Horizontal stack for the text field and button
                HStack {
                    // The text field
                    TextField("Start typing...", text: $inputText)
                        .textFieldStyle(PlainTextFieldStyle())
                        .foregroundColor(.white)
                        .font(Font.system(size: 18, weight: .thin, design: .rounded))
                        .padding([.leading, .trailing], 30) // Padding on the sides of the text field
                        .frame(height: 30) // Fixed height for the text field
                    
                    Spacer() // Pushes the icon to the right
                    
                    // The icon (non-clickable)
                    Image(systemName: "magnifyingglass") // Make sure "ps-icon.png" is in your asset catalog
                        .resizable() // Allow the image to be resized
                        .aspectRatio(contentMode: .fit) // Keep the aspect ratio of the image
                        .frame(height: 20) // Set the height of the image
                        .padding(.trailing, 20) // Padding on the right side of the icon
                }
            }
        }
        .frame(width: 700, height: 40) // Set the frame to the desired size for your text input
        .background(Color.black.opacity(0.0)) // Light background color for the whole view
        .padding(15)
    }
}



#Preview {
    ContentView()
}
