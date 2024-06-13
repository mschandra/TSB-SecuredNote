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
    
  
    var body: some Scene {
        WindowGroup {
            BioMetricSecurityUIView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
