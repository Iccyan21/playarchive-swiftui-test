//
//  PlayArchive_SwiftUI_testApp.swift
//  PlayArchive-SwiftUI-test
//
//  Created by 水原　樹 on 2023/12/26.
//

import SwiftUI
import SwiftData

@main
struct PlayArchive_SwiftUI_testApp: App {
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
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
