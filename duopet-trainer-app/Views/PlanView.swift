//
//  PlanView.swift
//  duopet-trainer-app
//
//  7-day training plan with timeline nodes and detail sheet
//

import SwiftUI

struct PlanView: View {
    @EnvironmentObject var appState: AppState
    @State private var selectedDay: PlanDay?
    @Environment(\.colorScheme) var colorScheme
    
    private var plans: [PlanDay] {
        guard let type = appState.profile.type else { return [] }
        return PlanDataProvider.plan(for: type)
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Header with progress
                headerSection
                
                // Timeline
                timelineSection
            }
            .padding(.bottom, 24)
        }
        .sheet(item: $selectedDay) { plan in
            PlanDetailSheet(plan: plan)
                .environmentObject(appState)
                .presentationDetents([.large])
                .presentationDragIndicator(.visible)
        }
    }
    
    // MARK: - Header
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .bottom) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("极简7天计划")
                        .font(.system(size: 26, weight: .black))
                    Text("单次5分钟，照做即可，无需自定义")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Text("\(Int(appState.progressPercentage * 100))%")
                    .font(.system(size: 15, weight: .black))
                    .foregroundColor(.duoGreen)
            }
            
            DuoProgressBar(progress: appState.progressPercentage)
        }
        .padding(.horizontal, 20)
        .padding(.top, 8)
    }
    
    // MARK: - Timeline
    private var timelineSection: some View {
        ZStack(alignment: .leading) {
            // Track line
            RoundedRectangle(cornerRadius: 4)
                .fill(DuoColors.border(colorScheme))
                .frame(width: 8)
                .padding(.leading, 36)
                .padding(.vertical, 20)
            
            VStack(spacing: 24) {
                ForEach(Array(plans.enumerated()), id: \.element.id) { index, plan in
                    let isCompleted = appState.completedDays.contains(plan.day)
                    let isNext = !isCompleted && (index == 0 || appState.completedDays.contains(plans[index - 1].day))
                    
                    Button {
                        selectedDay = plan
                    } label: {
                        HStack(spacing: 16) {
                            // Circle node
                            timelineNode(day: plan.day, isCompleted: isCompleted, isNext: isNext)
                            
                            // Info card
                            VStack(alignment: .leading, spacing: 6) {
                                Text("第 \(plan.day) 天: \(plan.title)")
                                    .font(.system(size: 17, weight: .black))
                                    .foregroundColor(
                                        isCompleted ? DuoColors.text(colorScheme).opacity(0.5) :
                                        DuoColors.text(colorScheme)
                                    )
                                    .multilineTextAlignment(.leading)
                                
                                HStack(spacing: 4) {
                                    Image(systemName: "clock")
                                        .font(.system(size: 13))
                                    Text(plan.duration)
                                        .font(.system(size: 13, weight: .bold))
                                }
                                .foregroundColor(.secondary)
                            }
                            .padding(16)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(
                                ZStack {
                                    // Bottom 3D layer (only for "next" state)
                                    if isNext {
                                        RoundedRectangle(cornerRadius: 20)
                                            .fill(DuoColors.border(colorScheme))
                                            .offset(y: 4)
                                    }
                                    
                                    // Main surface
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(
                                            isCompleted ? DuoColors.background(colorScheme) :
                                            isNext ? DuoColors.card(colorScheme) :
                                            Color.clear
                                        )
                                    
                                    // Border stroke
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(
                                            isCompleted ? DuoColors.border(colorScheme) :
                                            isNext ? DuoColors.border(colorScheme) :
                                            Color.clear,
                                            lineWidth: 2
                                        )
                                }
                            )
                            .opacity(isCompleted ? 0.7 : (isNext ? 1 : 0.6))
                        }
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .padding(.horizontal, 20)
    }
    
    // MARK: - Timeline Node
    private func timelineNode(day: Int, isCompleted: Bool, isNext: Bool) -> some View {
        ZStack {
            Circle()
                .fill(
                    isCompleted ? Color.duoGreen :
                    isNext ? DuoColors.card(colorScheme) :
                    DuoColors.border(colorScheme)
                )
                .frame(width: 64, height: 64)
            
            Circle()
                .stroke(
                    isCompleted ? Color.duoGreen :
                    isNext ? Color.duoBlue :
                    DuoColors.border(colorScheme),
                    lineWidth: 5
                )
                .frame(width: 64, height: 64)
            
            if isCompleted {
                Image(systemName: "checkmark")
                    .font(.system(size: 28, weight: .heavy))
                    .foregroundColor(.white)
            } else {
                Text("\(day)")
                    .font(.system(size: 24, weight: .black))
                    .foregroundColor(
                        isNext ? .duoBlue :
                        DuoColors.text(colorScheme).opacity(0.2)
                    )
            }
        }
    }
}

// MARK: - Plan Detail Sheet
struct PlanDetailSheet: View {
    let plan: PlanDay
    @EnvironmentObject var appState: AppState
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    
    private var isCompleted: Bool {
        appState.completedDays.contains(plan.day)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Header
            VStack(alignment: .leading, spacing: 8) {
                Text("DAY \(plan.day)")
                    .font(.system(size: 16, weight: .black))
                    .tracking(3)
                    .foregroundColor(.duoBlue)
                
                Text(plan.title)
                    .font(.system(size: 30, weight: .black))
                
                Text(plan.desc)
                    .font(.system(size: 17, weight: .bold))
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal, 24)
            .padding(.top, 28)
            
            Spacer().frame(height: 28)
            
            // Tips card
            VStack(alignment: .leading, spacing: 12) {
                HStack(spacing: 8) {
                    Image(systemName: "sparkles")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.duoOrange)
                    Text("实操技巧")
                        .font(.system(size: 20, weight: .heavy))
                }
                
                Text(plan.tips)
                    .font(.system(size: 17, weight: .bold))
                    .foregroundColor(DuoColors.text(colorScheme).opacity(0.9))
                    .lineSpacing(5)
                
                HStack {
                    Spacer()
                    HStack(spacing: 4) {
                        Image(systemName: "clock")
                            .font(.system(size: 13, weight: .bold))
                        Text("此训练控制在 \(plan.duration) 内")
                            .font(.system(size: 13, weight: .bold))
                    }
                    .foregroundColor(.duoOrange)
                }
            }
            .padding(20)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.duoOrange.opacity(0.1))
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.duoOrange.opacity(0.3), lineWidth: 2)
                    )
            )
            .padding(.horizontal, 24)
            
            Spacer()
            
            // Action button
            Button {
                withAnimation(.spring(response: 0.3)) {
                    appState.toggleDay(plan.day)
                }
                if !isCompleted {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                        dismiss()
                    }
                }
            } label: {
                Text(isCompleted ? "取消打卡" : "完成打卡")
            }
            .buttonStyle(isCompleted ?
                Duo3DButtonStyle(baseColor: DuoColors.border(colorScheme), deepColor: DuoColors.border(colorScheme).opacity(0.8), textColor: DuoColors.text(colorScheme)) :
                Duo3DButtonStyle(baseColor: .duoGreen, deepColor: .duoGreenDeep, textColor: .white)
            )
            .padding(.horizontal, 24)
            .padding(.bottom, 36)
        }
    }
}

#Preview {
    let state = AppState()
    state.profile = PetProfile(type: .dog, age: .adult)
    return PlanView()
        .environmentObject(state)
}
