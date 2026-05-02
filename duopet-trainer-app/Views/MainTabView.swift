//
//  MainTabView.swift
//  duopet-trainer-app
//

import SwiftUI

enum AppTab: String, CaseIterable {
    case emergency
    case plan
    case taboo
    case profile
    
    var label: String {
        switch self {
        case .emergency: return "急救库"
        case .plan: return "7天计划"
        case .taboo: return "避坑"
        case .profile: return "我的"
        }
    }
    
    var icon: String {
        switch self {
        case .emergency: return "heart.text.clipboard"
        case .plan: return "calendar.badge.checkmark"
        case .taboo: return "shield.lefthalf.filled.trianglebadge.exclamationmark"
        case .profile: return "person.circle"
        }
    }
    
    var activeColor: Color {
        switch self {
        case .emergency: return .duoRed
        case .plan: return .duoGreen
        case .taboo: return .duoYellow
        case .profile: return .duoBlue
        }
    }
}

struct MainTabView: View {
    @State private var activeTab: AppTab = .emergency
    
    var body: some View {
        VStack(spacing: 0) {
            // Content
            Group {
                switch activeTab {
                case .emergency:
                    EmergencyView()
                case .plan:
                    PlanView()
                case .taboo:
                    TabooView()
                case .profile:
                    ProfileView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            // Custom Tab Bar
            tabBar
        }
    }
    
    private var tabBar: some View {
        HStack(spacing: 0) {
            ForEach(AppTab.allCases, id: \.self) { tab in
                Button {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                        activeTab = tab
                    }
                } label: {
                    VStack(spacing: 4) {
                        Image(systemName: tab.icon)
                            .font(.system(size: 22, weight: activeTab == tab ? .bold : .regular))
                            .foregroundColor(activeTab == tab ? tab.activeColor : .secondary)
                        
                        Text(tab.label)
                            .font(.system(size: 10, weight: .black))
                            .tracking(0.5)
                            .foregroundColor(activeTab == tab ? tab.activeColor : .secondary)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                    .padding(.top, 4)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(activeTab == tab ? DuoColors.border(.light) : .clear, lineWidth: 2)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(activeTab == tab ? Color(.systemGray6).opacity(0.5) : .clear)
                            )
                    )
                    .padding(.horizontal, 4)
                    .opacity(activeTab == tab ? 1 : 0.4)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, 8)
        .padding(.bottom, 4)
        .background(
            Rectangle()
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.05), radius: 1, x: 0, y: -1)
        )
    }
}

#Preview {
    MainTabView()
        .environmentObject(AppState())
}
