//
//  BioMetricSecurityUIView.swift
//  SecuredNote
//
//  Created by CHANDRA SEKARAN M on 12/06/2024.
//

import SwiftUI

struct BioMetricSecurityUIView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var isActive: Bool = false
    var viewModel = BioMetricSecurityViewModel()
        
        var body: some View {
            ZStack {
                if self.viewModel.isUnlocked {
                    NotesMainView(viewModel: NotesMainViewModel(context: viewContext))
                } else {
                    Rectangle()
                        .background(Color.teal).opacity(0.7).ignoresSafeArea()
                    Image("TSB_Bank_logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                }
            }
            .onChange(of: isActive, { oldValue, newValue in
                self.viewModel.checkBiometric()
            })
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
}

#Preview {
    BioMetricSecurityUIView()
}
