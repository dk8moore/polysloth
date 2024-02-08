//
//  ContentView.swift
//  polysloth
//
//  Created by Denis Ronchese on 06/02/24.
//

import SwiftUI

struct ContentView: View {
    @State private var inputText = "" // This will hold the text input from the user
    
    // Define the gradient for the search bar background
    let gradient = LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]), startPoint: .leading, endPoint: .trailing)

    var body: some View {
        VStack {
            // The search bar container
            ZStack {
                // Apply the gradient background
                RoundedRectangle(cornerRadius: 20)
                    .fill(gradient)
                    .frame(height: 60)
                    .padding()

                // Horizontal stack for the text field and button
                HStack {
                    // The text field
                    TextField("Start typing...", text: $inputText)
                        .textFieldStyle(PlainTextFieldStyle()) // Removes the default text field styling
                        .padding([.leading, .trailing], 35.0) // Padding on the sides of the text field
                        .frame(height: 40) // Fixed height for the text field
                        .background(Color(red: 1.0, green: 0.0, blue: 0.0, opacity: 0.001)) // Slightly transparent white background
                        .cornerRadius(10) // Rounded corners for the text field

                    // The button with an icon
                    Button(action: {
                        // Action to perform when the button is tapped.
                        // We'll later use this to call the translation API
                        print("Translate button was tapped")
                    }) {
                        Image(systemName: "magnifyingglass") // System icon for the magnifying glass
                            .foregroundColor(.white) // White color for the icon
                    }
                    .padding(.trailing, 20) // Padding on the right side of the button
                }
            }
        }
        .frame(width: 700, height: 40) // Set the frame to the desired size for your text input
        .background(Color.black.opacity(0.05)) // Light background color for the whole view
        .padding(20)
    }
}



#Preview {
    ContentView()
}
