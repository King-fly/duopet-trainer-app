//
//  ContentView.swift
//  duopet-trainer-app
//
//  Created by wangwenfei on 2026/5/2.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        Group {
            if appState.isOnboarded {
                MainTabView()
                    .transition(.move(edge: .trailing).combined(with: .opacity))
            } else {
                PetSelectionView()
                    .transition(.move(edge: .leading).combined(with: .opacity))
            }
        }
        .animation(.spring(response: 0.4, dampingFraction: 0.85), value: appState.isOnboarded)
    }
}

#Preview {
    ContentView()
        .environmentObject(AppState())
}
