//
//  ContentView.swift
//  polysloth
//
//  Created by Denis Ronchese on 06/02/24.
//

import SwiftUI




struct ContentView: View {

    @State private var definition: String?
    @State private var content: String?         // This will hold the dynamic content

    
    var body: some View {
        // Apply a visual effect for the blur
        ZStack {
            VStack(spacing: 0) {
                
                //            NotificationCenter.default.post(name: NSNotification.Name("AdjustWindowSize"), object: nil, userInfo: ["size": CGSize(width: 800, height: 600)])
                HeaderView(background: {
                    BlurView(material: .hudWindow, blendingMode: .behindWindow, state: .active)
                })
//                if let content = content {
//                    BodyView()
//                }
                Divider()
                FooterView(background: {
                    BlurView(material: .hudWindow, blendingMode: .behindWindow, state: .active)
                })
            }
            //        .frame(width: 800) // Set the frame to the desired size for your text input
            .background(Color.black.opacity(0.0)) // Light background color for the whole view
        }
        .frame(height: GlobalConstants.Window.headerHeight + GlobalConstants.Window.footerHeight)
    }
    /*
    private func fetchDefinition() {
        let dictionaryManager = DictionaryManager()
        self.definition = dictionaryManager.definition(for: inputText)
        print(definition)
        // Optionally, clear the text field
        self.inputText = ""
    }*/
}



#Preview {
    ContentView()
}
