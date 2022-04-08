//
//  ios_too_simpleApp.swift
//  ios-too-simple
//
//  Created by Brandon Lempka on 4/8/22.
//

import SwiftUI

@main
struct ios_too_simpleApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
