//
//  FooterView.swift
//  polysloth
//
//  Created by Denis Ronchese on 02/03/24.
//

import SwiftUI

struct FooterView<Background: View>: View {
    let backgroundView: Background
    init(@ViewBuilder background: () -> Background) {
        self.backgroundView = background()
    }
    
    var body: some View {
        ZStack {
            backgroundView
            BottomMenuView(
                leftItems: [
                    ("1.square.fill", "Translation"),
                    ("2.square.fill", "Definition"),
                    ("3.square.fill", "Rhymes")
                ],
                rightItems: [
                    ("arrow.down", "History"),
                    ("return", "Search")
                ]
            )
        }
        .frame(height: GlobalConstants.Window.footerHeight)
    }
}

// View for a generic bottom menu item
struct MenuItemView: View {
    var iconName: String
    var label: String
    
    var body: some View {
        HStack {
            Image(systemName: iconName)
                .scaledToFit()
                .frame(width: 10, height: 10)
            Text(label)
                .font(.system(size: 12))
        }
        .frame(height: 10)
    }
}

struct BottomMenuView: View {
    var leftItems: [(iconName: String, label: String)]
    var rightItems: [(iconName: String, label: String)]
      
    var body: some View {
        HStack {
            HStack(spacing: 15) {
                ForEach(leftItems, id: \.iconName) {
                    item in MenuItemView(iconName: item.iconName, label: item.label)
                }
            }
            
            Spacer()
            
            HStack(spacing: 15) {
                ForEach(rightItems, id: \.iconName) {
                    item in MenuItemView(iconName: item.iconName, label: item.label)
                }
            }
            
        }
        .padding(.horizontal, 15)
        .frame(height: 30)
    }
}

struct FooterView_Previews: PreviewProvider {
    static var previews: some View {
        FooterView(background: {
            BlurView(material: .hudWindow, blendingMode: .behindWindow, state: .active)
        })
    }
}
