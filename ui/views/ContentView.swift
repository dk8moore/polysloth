//
//  ContentView.swift
//  polysloth
//
//  Created by Denis Ronchese on 06/02/24.
//

import SwiftUI




struct ContentView: View {
    
    @StateObject var stateMachine = StateManager()
    @State private var definition: String?
    @State private var content: String?         // This will hold the dynamic content

    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                // Header remains constant in every state
                HeaderView(background: {
                    BlurView(material: .hudWindow, blendingMode: .behindWindow, state: .active)
                })
                
            
                //            NotificationCenter.default.post(name: NSNotification.Name("AdjustWindowSize"), object: nil, userInfo: ["size": CGSize(width: 800, height: 600)])
                
                // Body
                Group {
                    switch stateMachine.currentState {
                        case .initial:
                            EmptyView()
                        case .history:
                            // History view content
                            Text("History State")
                        case .translation:
                            // Translation view content
                            Text("Translation State")
                        case .definition:
                            // Definition view content
                            Text("Definition State")
                        case .rhymes:
                            // Rhymes view content
                            Text("Rhymes State")
                        case .loading:
                            // Loading view content
                            ProgressView()
                        case .error(let message):
                            // Error view content
                            Text("Error: \(message)")
                    }
                }
                .transition(.opacity) // Optional: Add transition effects
            
                Divider()
                
                // Footer
                Group {
                    switch stateMachine.currentState {
                    // Adjust footer views accordingly
                    case .initial:
                        FooterView(background: {
                            BlurView(material: .hudWindow, blendingMode: .behindWindow, state: .active)
                        })
                    case .history, .translation, .definition, .rhymes, .loading:
                        FooterView(background: {
                            BlurView(material: .hudWindow, blendingMode: .behindWindow, state: .active)
                        })
                    case .error(_):
                        // Optionally different footer for error state
                        FooterView(background: {
                            BlurView(material: .hudWindow, blendingMode: .behindWindow, state: .active)
                        })
                    }
                }
            }
            //        .frame(width: 800) // Set the frame to the desired size for your text input
            .background(Color.black.opacity(0.0)) // Light background color for the whole view
        }
        .frame(height: calculateDynamicHeight())
    }
    
    // Function to calculate dynamic height based on state
    private func calculateDynamicHeight() -> CGFloat {
        // Example calculation, adjust according to your UI's needs
        let baseHeight = GlobalConstants.Window.headerHeight + GlobalConstants.Window.footerHeight
        let bodyHeight: CGFloat = stateMachine.currentState == .initial ? 0 : 100 // Example body height
        return baseHeight + bodyHeight
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
