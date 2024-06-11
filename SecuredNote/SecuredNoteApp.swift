//
//  SecuredNoteApp.swift
//  SecuredNote
//
//  Created by CHANDRA SEKARAN M on 11/06/2024.
//

import SwiftUI

@main
struct SecuredNoteApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
