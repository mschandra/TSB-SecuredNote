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
    @State var viewModel: SecurityViewModel
    init(viewModel: SecurityViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ZStack {
            if self.viewModel.isUnlocked {
                NotesCoordinator().mainView(context: viewContext)
            } else {
                Rectangle()
                    .background(Color.teal).opacity(0.7).ignoresSafeArea()
                Image("TSB_Bank_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
            }
        }
        .onChange(of: isActive, { _, _ in
            self.viewModel.unlock()
        })
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation {
                    self.isActive = true
                }
            }
        }.alert("Please enable faceId through device settings.", isPresented: $viewModel.isSettingsDisabled) {
            Button("OK") { }
        }
    }
}

#Preview {
    AppCoordinator().root()
}
