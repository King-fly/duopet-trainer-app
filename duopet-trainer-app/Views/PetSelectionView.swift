//
//  PetSelectionView.swift
//  duopet-trainer-app
//
//  Onboarding flow: select pet type and age
//

import SwiftUI

struct PetSelectionView: View {
    @EnvironmentObject var appState: AppState
    @State private var step = 1
    @State private var selectedType: PetType?
    
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()
            
            if step == 1 {
                petTypeStep
                    .transition(.asymmetric(
                        insertion: .move(edge: .leading).combined(with: .opacity),
                        removal: .move(edge: .leading).combined(with: .opacity)
                    ))
            } else {
                petAgeStep
                    .transition(.asymmetric(
                        insertion: .move(edge: .trailing).combined(with: .opacity),
                        removal: .move(edge: .trailing).combined(with: .opacity)
                    ))
            }
        }
        .animation(.spring(response: 0.4, dampingFraction: 0.85), value: step)
    }
    
    // MARK: - Step 1: Pet Type
    private var petTypeStep: some View {
        VStack(spacing: 24) {
            Spacer()
            
            // Icon badge
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.duoOrangeDeep)
                    .frame(width: 80, height: 80)
                    .offset(y: 4)
                
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.duoOrange)
                    .frame(width: 80, height: 80)
                
                Image(systemName: "pawprint.fill")
                    .font(.system(size: 36))
                    .foregroundColor(.white)
            }
            .padding(.bottom, 8)
            
            VStack(spacing: 8) {
                Text("你养的是什么宝贝？")
                    .font(.system(size: 26, weight: .black))
                
                Text("为您匹配专属训练逻辑")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.secondary)
            }
            
            VStack(spacing: 16) {
                Button {
                    selectedType = .dog
                    withAnimation {
                        step = 2
                    }
                } label: {
                    HStack(spacing: 10) {
                        Image(systemName: "dog.fill")
                            .font(.system(size: 22))
                        Text("狗狗")
                    }
                }
                .buttonStyle(.duoBlue)
                .frame(height: 58)
                
                Button {
                    selectedType = .cat
                    withAnimation {
                        step = 2
                    }
                } label: {
                    HStack(spacing: 10) {
                        Image(systemName: "cat.fill")
                            .font(.system(size: 22))
                        Text("猫咪")
                    }
                }
                .buttonStyle(.duoPrimary)
                .frame(height: 58)
            }
            
            Spacer()
        }
        .padding(.horizontal, 32)
    }
    
    // MARK: - Step 2: Pet Age
    private var petAgeStep: some View {
        VStack(spacing: 24) {
            Spacer()
            
            // Back button
            HStack {
                Button {
                    withAnimation {
                        step = 1
                    }
                } label: {
                    HStack(spacing: 4) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 14, weight: .bold))
                        Text("返回")
                            .font(.system(size: 15, weight: .bold))
                    }
                    .foregroundColor(.secondary)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(.systemGray6))
                    )
                }
                Spacer()
            }
            .padding(.top, -20)
            
            // Icon badge
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.duoBlueDeep)
                    .frame(width: 80, height: 80)
                    .offset(y: 4)
                
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.duoBlue)
                    .frame(width: 80, height: 80)
                
                Image(systemName: selectedType?.sfSymbol ?? "pawprint.fill")
                    .font(.system(size: 36))
                    .foregroundColor(.white)
            }
            .padding(.bottom, 8)
            
            Text("是一只幼年还是成年\(selectedType?.displayName ?? "宠物")？")
                .font(.system(size: 24, weight: .black))
                .multilineTextAlignment(.center)
            
            VStack(spacing: 16) {
                Button {
                    if let type = selectedType {
                        withAnimation(.spring(response: 0.3)) {
                            appState.selectPet(type: type, age: .young)
                        }
                    }
                } label: {
                    HStack(spacing: 6) {
                        Text("🍼")
                            .font(.system(size: 20))
                        Text("幼年")
                        Text("(1岁以下)")
                            .font(.system(size: 13, weight: .semibold))
                            .opacity(0.6)
                    }
                }
                .buttonStyle(DuoOutlineButtonStyle())
                .frame(height: 58)
                
                Button {
                    if let type = selectedType {
                        withAnimation(.spring(response: 0.3)) {
                            appState.selectPet(type: type, age: .adult)
                        }
                    }
                } label: {
                    HStack(spacing: 6) {
                        Text("🦴")
                            .font(.system(size: 20))
                        Text("成年")
                        Text("(1岁及以上)")
                            .font(.system(size: 13, weight: .semibold))
                            .opacity(0.6)
                    }
                }
                .buttonStyle(DuoOutlineButtonStyle())
                .frame(height: 58)
            }
            
            Spacer()
        }
        .padding(.horizontal, 32)
    }
}

#Preview {
    PetSelectionView()
        .environmentObject(AppState())
}
