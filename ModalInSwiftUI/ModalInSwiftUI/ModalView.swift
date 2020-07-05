//
//  ModalView.swift
//  ModalInSwiftUI
//
//  Created by hanwe on 2020/07/05.
//  Copyright © 2020 hanwe. All rights reserved.
//

import SwiftUI

struct ModalView: View {
    @Binding var presentedAsModal: Bool
    var body: some View {
        Button("dismiss") { self.presentedAsModal = false }
    }
}
