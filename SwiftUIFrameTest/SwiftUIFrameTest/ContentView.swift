//
//  ContentView.swift
//  SwiftUIFrameTest
//
//  Created by hanwe lee on 2020/06/23.
//  Copyright © 2020 hanwe lee. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.purple.edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    VStack{
                        Text("11시")
                        Spacer()
                        Text("9시")
                        Spacer()
                        Text("7시")
                    }
                    Spacer()
                    VStack{
                        Text("12시")
                            .padding(.top, 0.0)
                        Spacer()
                        Text("중앙")
                        Spacer()
                        Text("test")
                        Spacer()
                        Text("6시")
                    }
                    Spacer()
                    VStack{
                        Text("1시")
                        Spacer()
                        Text("3시")
                        Spacer()
                        Text("5시")
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
            Group {
                ContentView()
                .previewDevice(PreviewDevice(rawValue: "iPhone SE"))
                    .previewDisplayName("iPhone SE")
                    .environment(\.colorScheme, .dark)
                
                ContentView()
                .previewDevice(PreviewDevice(rawValue: "iPhone 11"))
                    .previewDisplayName("iPhone 11")
            }
        }
}
