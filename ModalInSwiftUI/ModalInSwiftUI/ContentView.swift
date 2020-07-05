//
//  ContentView.swift
//  ModalInSwiftUI
//
//  Created by hanwe on 2020/07/05.
//  Copyright © 2020 hanwe. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var presentingModal = false
    
    var body: some View {
        Button("Present") { self.presentingModal = true }
        .sheet(isPresented: $presentingModal) { ModalView(presentedAsModal: self.$presentingModal) }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
