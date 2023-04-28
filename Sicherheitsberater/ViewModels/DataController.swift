//
//  DataController.swift
//  Sicherheitsberater
//
//  Created by Benjamin Grunow on 28.04.23.
//

import CoreData

import Foundation

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Requirements")
    @Published var savedEntities: [RequirementEntity] = []
    @Published var objectTypes: [String] = []
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
        preloadJSONToCoreData()
        fetchRequirements()
        getObjectTypes()
    }
    
    func fetchRequirements() {
        let request = NSFetchRequest<RequirementEntity>(entityName: "RequirementEntity")
        
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching. \(error)")
        }
    }
    
    func addRequirement(requirement: RequirementItem) {
        let newRequirement = RequirementEntity(context: container.viewContext)
        newRequirement.id = requirement.id
        newRequirement.name = requirement.name
        newRequirement.objectType = requirement.objectType
        newRequirement.explanation = requirement.explanation
        newRequirement.isFulfilled = requirement.isFulfilled ?? false
        newRequirement.changingDate = requirement.changingDate
        saveData()
        
    }
    
    func updateRequirement(entity: RequirementEntity) {
        
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
            fetchRequirements()
        } catch let error {
            print("Error saving. \(error)")
        }
    }
    
    func getObjectTypes() {
        objectTypes = Array(savedEntities.map { $0.objectType ?? ""}).uniqued()
        print(objectTypes)
    }
    
    func preloadJSONToCoreData() {
        // check to see if data has been loaded into Core Data already.
        // if not,  load data items to Core Data directly from the .json file now
        
        let preloadedDataKey = "didPreloadData"
        let userDefaults = UserDefaults.standard
        if userDefaults.bool(forKey: preloadedDataKey) == false {
            let requirements: [RequirementItem] = Bundle.main.decode([RequirementItem].self, from: "requirements.json")
            for requirement in requirements {
                addRequirement(requirement: requirement)
            }
        }
        userDefaults.set(true, forKey: preloadedDataKey)
    }
}
