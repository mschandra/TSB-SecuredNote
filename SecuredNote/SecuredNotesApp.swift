//
//  SecuredNotesApp.swift
//  SecuredNote
//
//  Created by CHANDRA SEKARAN M on 11/06/2024.
//
import SwiftUI

@main
struct SecuredNotesApp: App {

    let persistenceController = PersistenceController.shared
    private var appCoordinator = AppCoordinator()

    var body: some Scene {
        WindowGroup {
            appCoordinator.root()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
