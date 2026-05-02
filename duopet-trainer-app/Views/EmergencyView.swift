//
//  EmergencyView.swift
//  duopet-trainer-app
//
//  Emergency behavioral fixes with 3-step solution cards
//

import SwiftUI

struct EmergencyView: View {
    @EnvironmentObject var appState: AppState
    @State private var selectedProblem: EmergencyProblem?
    @Environment(\.colorScheme) var colorScheme
    
    private var problems: [EmergencyProblem] {
        guard let type = appState.profile.type else { return [] }
        return EmergencyDataProvider.problems(for: type)
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Header
                VStack(alignment: .leading, spacing: 4) {
                    Text("急救行为库")
                        .font(.system(size: 26, weight: .black))
                    Text("遇到突发情况，照做就行")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal, 20)
                .padding(.top, 8)
                
                if selectedProblem == nil {
                    // Problem List
                    problemListView
                        .transition(.move(edge: .leading).combined(with: .opacity))
                } else {
                    // Problem Detail
                    problemDetailView
                        .transition(.move(edge: .trailing).combined(with: .opacity))
                }
            }
            .padding(.bottom, 24)
        }
        .animation(.spring(response: 0.35, dampingFraction: 0.85), value: selectedProblem?.id)
    }
    
    // MARK: - Problem List
    private var problemListView: some View {
        VStack(spacing: 12) {
            ForEach(problems) { problem in
                Button {
                    selectedProblem = problem
                } label: {
                    HStack(spacing: 16) {
                        // Icon badge
                        ZStack {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(problem.color.background)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(problem.color.border, lineWidth: 2)
                                )
                            
                            Image(systemName: problem.icon)
                                .font(.system(size: 22, weight: .semibold))
                                .foregroundColor(problem.color.foreground)
                        }
                        .frame(width: 52, height: 52)
                        
                        Text(problem.title)
                            .font(.system(size: 18, weight: .heavy))
                            .foregroundColor(DuoColors.text(colorScheme))
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.secondary.opacity(0.5))
                    }
                    .duoCard(interactive: true)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, 20)
    }
    
    // MARK: - Problem Detail
    private var problemDetailView: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Back button
            Button {
                selectedProblem = nil
            } label: {
                HStack(spacing: 4) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 14, weight: .bold))
                    Text("返回问题列表")
                        .font(.system(size: 15, weight: .bold))
                }
                .foregroundColor(.secondary)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color(.systemGray6))
                )
            }
            .buttonStyle(.plain)
            .padding(.horizontal, 20)
            
            if let problem = selectedProblem {
                // Title card
                HStack(spacing: 12) {
                    Image(systemName: problem.icon)
                        .font(.system(size: 24, weight: .semibold))
                    Text(problem.title)
                        .font(.system(size: 24, weight: .black))
                }
                .foregroundColor(problem.color.foreground)
                .padding(20)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(
                    RoundedRectangle(cornerRadius: 24)
                        .fill(problem.color.background)
                        .overlay(
                            RoundedRectangle(cornerRadius: 24)
                                .stroke(problem.color.border, lineWidth: 3)
                        )
                )
                .padding(.horizontal, 20)
                
                // Step 1: Do Now
                stepCard(
                    number: "1",
                    title: "当下立刻怎么做",
                    content: problem.steps.doNow,
                    badgeColor: .duoGreen,
                    titleColor: DuoColors.text(colorScheme)
                )
                
                // Step 2: Don't Do
                stepCard(
                    number: "✕",
                    title: "绝对禁止做什么",
                    content: problem.steps.dontDo,
                    badgeColor: .duoRed,
                    titleColor: .duoRed,
                    cardBg: Color.duoRed.opacity(0.05),
                    cardBorder: Color.duoRed.opacity(0.3)
                )
                
                // Step 3: Consolidate
                stepCard(
                    number: "3",
                    title: "1天巩固方法",
                    content: problem.steps.consolidate,
                    badgeColor: .duoBlue,
                    titleColor: DuoColors.text(colorScheme)
                )
            }
        }
    }
    
    // MARK: - Step Card
    private func stepCard(
        number: String,
        title: String,
        content: String,
        badgeColor: Color,
        titleColor: Color,
        cardBg: Color? = nil,
        cardBorder: Color? = nil
    ) -> some View {
        let bg = cardBg ?? DuoColors.card(colorScheme)
        let border = cardBorder ?? DuoColors.border(colorScheme)
        
        return VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 10) {
                ZStack {
                    Circle()
                        .fill(badgeColor)
                        .frame(width: 32, height: 32)
                    
                    if number == "✕" {
                        Image(systemName: "shield.fill")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.white)
                    } else {
                        Text(number)
                            .font(.system(size: 18, weight: .black))
                            .foregroundColor(.white)
                    }
                }
                
                Text(title)
                    .font(.system(size: 18, weight: .heavy))
                    .foregroundColor(titleColor)
            }
            
            Text(content)
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(DuoColors.text(colorScheme).opacity(0.8))
                .lineSpacing(4)
                .padding(.leading, 42)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .duo3DBackground(
            cornerRadius: 20,
            fill: bg,
            border: border,
            bottom: border,
            bottomHeight: 3,
            strokeWidth: 2
        )
        .padding(.horizontal, 20)
    }
}

#Preview {
    let state = AppState()
    state.profile = PetProfile(type: .dog, age: .adult)
    return EmergencyView()
        .environmentObject(state)
}
