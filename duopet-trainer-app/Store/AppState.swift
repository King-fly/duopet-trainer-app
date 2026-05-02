//
//  AppState.swift
//  duopet-trainer-app
//
//  Observable state manager with UserDefaults persistence
//

import SwiftUI
import Combine

@MainActor
class AppState: ObservableObject {
    // MARK: - Keys
    private enum Keys {
        static let profile = "duopet-profile"
        static let completedDays = "duopet-plan-days"
    }
    
    // MARK: - Published Properties
    @Published var profile: PetProfile {
        didSet { saveProfile() }
    }
    
    @Published var completedDays: Set<Int> {
        didSet { saveCompletedDays() }
    }
    
    // MARK: - Computed
    var isOnboarded: Bool {
        profile.isComplete
    }
    
    var progressPercentage: Double {
        Double(completedDays.count) / 7.0
    }
    
    // MARK: - Init
    init() {
        // Load profile
        if let data = UserDefaults.standard.data(forKey: Keys.profile),
           let decoded = try? JSONDecoder().decode(PetProfile.self, from: data) {
            self.profile = decoded
        } else {
            self.profile = PetProfile()
        }
        
        // Load completed days
        let savedDays = UserDefaults.standard.array(forKey: Keys.completedDays) as? [Int] ?? []
        self.completedDays = Set(savedDays)
    }
    
    // MARK: - Actions
    func toggleDay(_ day: Int) {
        if completedDays.contains(day) {
            completedDays.remove(day)
        } else {
            completedDays.insert(day)
        }
    }
    
    func resetPlan() {
        completedDays.removeAll()
    }
    
    func resetAll() {
        completedDays.removeAll()
        profile = PetProfile()
    }
    
    func selectPet(type: PetType, age: PetAge) {
        profile = PetProfile(type: type, age: age)
    }
    
    // MARK: - Persistence
    private func saveProfile() {
        if let data = try? JSONEncoder().encode(profile) {
            UserDefaults.standard.set(data, forKey: Keys.profile)
        }
    }
    
    private func saveCompletedDays() {
        UserDefaults.standard.set(Array(completedDays), forKey: Keys.completedDays)
    }
}
