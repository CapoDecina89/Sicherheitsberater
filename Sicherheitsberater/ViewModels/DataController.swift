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
        //fetchRequirements()
    }
    
    func fetchRequirements() {
        let request = NSFetchRequest<RequirementEntity>(entityName: "RequirementEntity")
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching. \(error)")
        }
    }
    
    ///gibt ein anhand des Profils gefiltertes Array mit RequirementItems zurück
    func fetchRequirements(forProfile profile: Profile) {
        //Filter entsprechen des Profils einstellen
        let request = NSFetchRequest<RequirementEntity>(entityName: "RequirementEntity")
        var compoundPredicate: NSPredicate {
            var predicates: [NSPredicate] = []
            //Filter nach Praxisgröße
            var sizeFilter: NSPredicate? = nil
            switch profile.size {
            case .small:
                sizeFilter = NSPredicate(format: "(sizeCategory CONTAINS[c] 'all')")
            case .medium:
                sizeFilter = NSPredicate(format: "NOT(sizeCategory CONTAINS[c] 'large')")
            default:
                break
            }
            if (sizeFilter != nil) {
                predicates.append(sizeFilter!)
            }
            //Filter nach Devices
            var deviceFilter: [NSPredicate] = []
            if (profile.hasBigMedTech == false) {
                deviceFilter.append(NSPredicate(format: "NOT(objectType CONTAINS[c] 'Großgeräte')"))
            }
            if (profile.hasMobileDevice == false) {
                deviceFilter.append(NSPredicate(format: "NOT(objectType CONTAINS[c] 'Mobil')"))
                deviceFilter.append(NSPredicate(format: "NOT(objectType CONTAINS[c] 'Smartphone')"))
            }
            if (profile.hasWebServices == false) {
                deviceFilter.append(NSPredicate(format: "NOT(objectType CONTAINS[c] 'Internet')"))
            }
            //Filter mit AND verknüpfen
            predicates.append(contentsOf: deviceFilter)
            
            return NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
        }
        //Filterkombination für Request übergeben
        request.predicate = compoundPredicate
        
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
        newRequirement.sizeCategory = requirement.sizeCategory
        saveData()
        
    }
    
    func updateChangingTime(entity: RequirementEntity) {
        let newChangingDate = Date()
        entity.changingDate = newChangingDate
        saveData()
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
