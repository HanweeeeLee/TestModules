//
//  ContentView.swift
//  PresentationDetents
//
//  Created by Aaron Hanwe LEE on 5/23/24.
//

import SwiftUI

struct ContentView: View {
  @State private var isSheetPresented = false
  
  var body: some View {
    VStack {
      Button("Show Sheet") {
        isSheetPresented.toggle()
      }
    }
    .sheet(isPresented: $isSheetPresented) {
      SheetView()
        .presentationDetents([.fraction(0.3), .medium, .large])
        .presentationDragIndicator(.visible)
    }
  }
}

struct SheetView: View {
  @Environment(\.presentationMode) var presentationMode
  
  var body: some View {
    VStack {
      Text("This is a sheet")
        .font(.largeTitle)
        .padding()
      
      Button("Dismiss") {
        presentationMode.wrappedValue.dismiss()
      }
      .padding()
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
