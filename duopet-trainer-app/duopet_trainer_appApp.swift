//
//  duopet_trainer_appApp.swift
//  duopet-trainer-app
//
//  Created by wangwenfei on 2026/5/2.
//

import SwiftUI

@main
struct duopet_trainer_appApp: App {
    @StateObject private var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
        }
    }
}
