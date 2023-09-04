//
//  ContentView.swift
//  floater
//
//  Created by Peter Chen on 2023/9/4.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            // side bar
            if isMacOS() {
                SideBar()
            }
        }
        .frame(width: isMacOS() ? getRect().width/1.7 : nil, height: isMacOS() ? getRect().height - 180 : nil)
        .background(Color("BG").ignoresSafeArea())
        .preferredColorScheme(.light)
        .buttonStyle(BorderlessButtonStyle())
        .textFieldStyle(PlainTextFieldStyle())
    }

    @ViewBuilder
    func SideBar() -> some View {
        VStack {
            Text("Floater")
            .font(.title2)
            .fontWeight(.semibold)
            
            AddButton()
        }
    }
    
    @ViewBuilder
    func AddButton() -> some View {
        Button {
            
        } label: {
            Image(systemName: "plus")
                .font(.title2)
                .foregroundColor(.white)
                .padding(isMacOS() ? 12 : 15)
                .background(Color.black)
                .clipShape(Circle())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension View {
    func getRect() -> CGRect {
        #if os(iOS)
        return UIScreen.mani.bounds
        #else
        return NSScreen.main!.visibleFrame
        #endif
    }

    func isMacOS() -> Bool {
        #if os(iOS)
        return false
        #endif
        return true
    }
}
