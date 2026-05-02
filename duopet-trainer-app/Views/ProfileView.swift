//
//  ProfileView.swift
//  duopet-trainer-app
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var appState: AppState
    @State private var showConfirm = false
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("我的宠物")
                    .font(.system(size: 26, weight: .black))
                    .padding(.horizontal, 20)
                    .padding(.top, 8)
                
                // Pet card
                petInfoCard
                
                // Training tips
                trainingTipsCard
                
                // Settings
                settingsSection
            }
            .padding(.bottom, 24)
        }
    }
    
    private var petInfoCard: some View {
        VStack(spacing: 16) {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.duoOrangeDeep)
                    .frame(width: 96, height: 96)
                    .offset(y: 4)
                
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.duoOrange)
                    .frame(width: 96, height: 96)
                
                Image(systemName: appState.profile.type?.sfSymbol ?? "pawprint.fill")
                    .font(.system(size: 42))
                    .foregroundColor(.white)
            }
            
            Text(appState.profile.age?.displayName ?? "")
                .font(.system(size: 24, weight: .black))
            
            HStack(spacing: 4) {
                Text("已坚持打卡")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(.secondary)
                Text("\(appState.completedDays.count)")
                    .font(.system(size: 15, weight: .black))
                    .foregroundColor(.duoGreen)
                Text("天")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(.secondary)
            }
        }
        .frame(maxWidth: .infinity)
        .duoCard()
        .padding(.horizontal, 20)
    }
    
    private var trainingTipsCard: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 6) {
                Image(systemName: "heart.fill")
                    .font(.system(size: 16))
                    .foregroundColor(.duoRed)
                Text("训练心得")
                    .font(.system(size: 16, weight: .heavy))
            }
            
            Text("宠物训练的核心是教导它们如何在人类社会中生活，而不是将它们当成机器去控制。请保持耐心，多表扬，少惩罚。")
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(.secondary)
                .lineSpacing(4)
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(Color(.systemGray6))
        )
        .padding(.horizontal, 20)
    }
    
    private var settingsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 6) {
                Image(systemName: "gearshape")
                    .font(.system(size: 15))
                Text("设置")
                    .font(.system(size: 16, weight: .heavy))
            }
            .foregroundColor(.secondary)
            .padding(.horizontal, 24)
            
            if !showConfirm {
                Button {
                    withAnimation(.spring(response: 0.3)) {
                        showConfirm = true
                    }
                } label: {
                    HStack(spacing: 8) {
                        Image(systemName: "trash")
                            .font(.system(size: 16, weight: .bold))
                        Text("重置所有进度与宠物")
                            .font(.system(size: 16, weight: .heavy))
                    }
                    .foregroundColor(.duoRed)
                }
                .buttonStyle(DuoGhostButtonStyle(foregroundColor: .duoRed))
                .padding(.horizontal, 20)
            } else {
                VStack(spacing: 16) {
                    Text("确定要重置吗？这将丢失7天打卡记录和选择的宠物类型。")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(.duoRed)
                        .multilineTextAlignment(.center)
                    
                    HStack(spacing: 12) {
                        Button("取消") {
                            withAnimation { showConfirm = false }
                        }
                        .buttonStyle(DuoOutlineButtonStyle())
                        
                        Button("确认重置") {
                            withAnimation(.spring(response: 0.3)) {
                                appState.resetAll()
                            }
                        }
                        .buttonStyle(.duoDanger)
                    }
                }
                .padding(20)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.duoRed.opacity(0.1))
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.duoRed.opacity(0.5), lineWidth: 2)
                        )
                )
                .padding(.horizontal, 20)
                .transition(.scale.combined(with: .opacity))
            }
        }
    }
}

#Preview {
    let state = AppState()
    state.profile = PetProfile(type: .cat, age: .young)
    return ProfileView()
        .environmentObject(state)
}
