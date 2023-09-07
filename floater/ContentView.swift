//
//  ContentView.swift
//  floater
//
//  Created by Peter Chen on 2023/9/4.
//

import SwiftUI

struct ContentView: View {
    @State var showColors: Bool = false
    
    @State var animateButton: Bool = false
    
    var body: some View {
        HStack(spacing: 0) {
            // side bar
            if isMacOS() {
                Group {
                    SideBar()
                    
                    Rectangle()
                        .fill(Color.gray.opacity(0.15))
                        .frame(width: 1)
                }
            }
            
            // main content
            MainContent()
        }
        .ignoresSafeArea()
        .frame(width: isMacOS() ? getRect().width/1.7 : nil, height: isMacOS() ? getRect().height - 180 : nil,alignment: .leading)
        .background(Color.white.ignoresSafeArea())
        .preferredColorScheme(.light)
        .buttonStyle(BorderlessButtonStyle())
        .textFieldStyle(PlainTextFieldStyle())
    }
    
    @ViewBuilder
    func MainContent() -> some View {
        VStack(spacing: 6) {
            // search bar...
            HStack(spacing: 8) {
                Image(systemName: "magnifyingglass")
                    .font(.title3)
                    .foregroundColor(.gray)
                
                TextField("Search", text: .constant(""))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, isMacOS() ? 0 : 10)
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 15) {
                    Text("Notes")
                        .font(isMacOS() ? .system(size: 33, weight: .bold) : .largeTitle.bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    let columns = Array(repeating: GridItem(.flexible(),spacing: isMacOS() ? 25:15), count: isMacOS() ? 3 : 1)
                    
                    LazyVGrid(columns: columns, spacing: 25) {
                        
                    }
                }
                .padding(.top, isMacOS() ? 45 : 30)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.top, isMacOS() ? 40 : 15)
        .padding(.horizontal, 25)
    }

    @ViewBuilder
    func SideBar() -> some View {
        VStack {
            Text("Floater")
            .font(.title2)
            .fontWeight(.semibold)
            
            AddButton()
                .zIndex(1)
            
            VStack(spacing: 15) {
                let colors = [
                    Color.orange, Color.purple, Color.blue, Color.green
                ]
                
                ForEach(colors, id: \.self) {
                    color in
                    
                    Circle()
                        .fill(color)
                        .frame(width: 20, height: 20)
                }
            }
            .padding(.top,20)
            .frame(height: showColors ? nil : 0)
            .opacity(showColors ? 1: 0)
            .zIndex(0)
            
        }
        .frame(maxHeight: .infinity,alignment: .top)
        .padding(.vertical)
        .padding(.horizontal, 22)
        .padding(.top,35)
    }
    
    @ViewBuilder
    func AddButton() -> some View {
        Button {
            withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.6)) {
                showColors.toggle()
                animateButton.toggle()
            }
            
            DispatchQueue.main.asyncAfter(deadline:  .now() + 0.3) {
                withAnimation(.spring()) {
                    animateButton.toggle()
                }
            }
        } label: {
            Image(systemName: "plus")
                .font(.title2)
                .foregroundColor(.white)
                .padding(isMacOS() ? 12 : 15)
                .background(Color.black)
                .clipShape(Circle())
        }
        .rotationEffect(.init(degrees: showColors ? 45 : 0))
        .scaleEffect(animateButton ? 1.1 : 1)
        .padding(.top, 30)
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

#if os(macOS)
extension NSTextField {
    open override var focusRingType: NSFocusRingType {
        get{.none}
        set{}
    }
}
#endif
