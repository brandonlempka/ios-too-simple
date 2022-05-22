//
//  TransactionDetailView.swift
//  ios-too-simple
//
//  Created by Brandon Lempka on 5/22/22.
//

import SwiftUI

struct TransactionDetailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var backButton : some View { Button(action: {
        self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
            Image(systemName: "chevron.left") // BackButton Image
                .aspectRatio(contentMode: .fit)
                .foregroundColor(Color("TooSimplePurple"))
                Text("Back") //translated Back button title
            }
        }
    }
    var body: some View {
            VStack {
            Text("View2")
        }
        .navigationBarTitle("Title View2",displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton)
    }

}

struct TransactionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionDetailView()
    }
}
