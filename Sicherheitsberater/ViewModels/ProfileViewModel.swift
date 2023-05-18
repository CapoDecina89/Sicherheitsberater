//
//  ProfileViewModel.swift
//  Sicherheitsberater
//
//  Created by Benjamin Grunow on 25.04.23.
//

import Foundation

class ProfileViewModel: ObservableObject {
    
    @Published var businessProfile: Profile = Profile() {
        didSet {
            saveProfile()
        }
    }
    let profileKey: String = "business_profile"
  
    init() {
        getProfile()
    }
    ///gets the Profile by fetching json from UserDefaults and decoding
    func getProfile() {
        guard
            let data = UserDefaults.standard.data(forKey: profileKey),
            let savedProfile = try? JSONDecoder().decode(Profile.self, from: data)
        else { return }
        
        self.businessProfile = savedProfile
    }
    ///saves the profile as json to UserDefaults
    func saveProfile() {
        if let encodedData = try? JSONEncoder().encode(businessProfile) {
            UserDefaults.standard.set(encodedData, forKey: profileKey)
        }
    }
}
