//
//  ButtonUIView.swift
//  SecuredNotes
//
//  Created by CHANDRA SEKARAN M on 13/06/2024.
//
import SwiftUI
import Foundation

struct ButtonUIView: View {
    let text: String
    @Binding var isTapped: Bool
  var body: some View {
    HStack(spacing: 10) {
      Text("Register")
        .font(Font.custom("Poppins", size: 16).weight(.medium))
        .foregroundColor(.black)
    }
    .padding(10)
    .frame(minWidth: 0, maxWidth: 100)
    .background(
      LinearGradient(gradient: Gradient(colors: [Color(red: 0.78, green: 0.78, blue: 0.91), Color(red: 0.48, green: 0.48, blue: 0.79)]), startPoint: .leading, endPoint: .trailing)
    )
    .cornerRadius(8)
    .shadow(
      color: Color(red: 0, green: 0, blue: 0, opacity: 0.08), radius: 14, x: 4
    ).onTapGesture {
        isTapped = true
    }
  }
}
