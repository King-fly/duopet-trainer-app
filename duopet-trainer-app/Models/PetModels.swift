//
//  PetModels.swift
//  duopet-trainer-app
//
//  Data models for pet types, profiles, and training data
//

import Foundation

// MARK: - Pet Type & Age
enum PetType: String, Codable, CaseIterable {
    case dog
    case cat
    
    var displayName: String {
        switch self {
        case .dog: return "狗狗"
        case .cat: return "猫咪"
        }
    }
    
    var emoji: String {
        switch self {
        case .dog: return "🐕"
        case .cat: return "🐱"
        }
    }
    
    var sfSymbol: String {
        switch self {
        case .dog: return "dog.fill"
        case .cat: return "cat.fill"
        }
    }
}

enum PetAge: String, Codable, CaseIterable {
    case young
    case adult
    
    var displayName: String {
        switch self {
        case .young: return "幼年小宝贝"
        case .adult: return "成年大宝贝"
        }
    }
    
    var label: String {
        switch self {
        case .young: return "🍼 幼年"
        case .adult: return "🦴 成年"
        }
    }
    
    var subtitle: String {
        switch self {
        case .young: return "(1岁以下)"
        case .adult: return "(1岁及以上)"
        }
    }
}

// MARK: - Pet Profile
struct PetProfile: Codable, Equatable {
    var type: PetType?
    var age: PetAge?
    
    var isComplete: Bool {
        type != nil && age != nil
    }
}

// MARK: - Emergency Problem
enum ProblemColor: String, Codable {
    case danger, warning, primary, blue
    
    var foreground: SwiftUI.Color {
        switch self {
        case .danger: return .duoRed
        case .warning: return .duoOrange
        case .primary: return .duoGreen
        case .blue: return .duoBlue
        }
    }
    
    var background: SwiftUI.Color {
        foreground.opacity(0.1)
    }
    
    var border: SwiftUI.Color {
        foreground.opacity(0.2)
    }
}

import SwiftUI

struct EmergencyProblem: Identifiable {
    let id: String
    let title: String
    let icon: String // SF Symbol
    let color: ProblemColor
    let steps: (doNow: String, dontDo: String, consolidate: String)
}

// MARK: - Plan Day
struct PlanDay: Identifiable {
    var id: Int { day }
    let day: Int
    let title: String
    let desc: String
    let tips: String
    let duration: String
}

// MARK: - Taboo
struct TrainingTaboo: Identifiable {
    let id = UUID()
    let title: String
    let reason: String
}
