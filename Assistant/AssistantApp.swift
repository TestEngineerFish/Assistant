//
//  AssistantApp.swift
//  Assistant
//
//  Created by 老沙 on 2024/10/9.
//

import SwiftUI
import SwiftData

@main
struct AssistantApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            NewContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
