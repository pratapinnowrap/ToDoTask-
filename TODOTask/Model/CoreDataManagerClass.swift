//
//  CoreDataManagerClass.swift
//  TODOTask
//
//  Created by Pabitra on 05/01/19.
//  Copyright © 2019 Pabitra. All rights reserved.
//

import Foundation
import UIKit
import CoreData


class CoreDataManager{
    
    static let sharedManager = CoreDataManager()
    private init() {} // Prevent clients from creating another instance.
    
   
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "Person")
        
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    //3
    func saveContext () {
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
  
    func insertPerson(name: String, ssn : Int16)->Person? {
        
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext

        let entity = NSEntityDescription.entity(forEntityName: "Person",
                                                in: managedContext)!
        
        let person = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        
        person.setValue(name, forKeyPath: "name")
        person.setValue(ssn, forKeyPath: "ssn")
        
        
        do {
            try managedContext.save()
            return person as? Person
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            return nil
        }
    }
    
    func update(name:String, ssn : Int16, person : Person) {
        
       
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        do {
            
            person.setValue(name, forKey: "name")
            person.setValue(ssn, forKey: "ssn")
            
            print("\(person.value(forKey: "name"))")
            print("\(person.value(forKey: "ssn"))")
            
    
            do {
                try context.save()
                print("saved!")
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            } catch {
                
            }
            
        } catch {
            print("Error with request: \(error)")
        }
    }
    
    
    func delete(person : Person){
        
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        do {
            managedContext.delete(person)
            
        } catch {
            
            print(error)
        }
        
        do {
            try managedContext.save()
        } catch {
        }
    }
    
    func fetchAllPersons() -> [Person]?{
        
    let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
    
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Person")
    
        do {
            let people = try managedContext.fetch(fetchRequest)
            return people as? [Person]
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
    }
    
    func delete(ssn: String) -> [Person]? {
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Person")
        
        fetchRequest.predicate = NSPredicate(format: "ssn == %@" ,ssn)
        do {
            let item = try managedContext.fetch(fetchRequest)
            var arrRemovedPeople = [Person]()
            for i in item {
                managedContext.delete(i)
                try managedContext.save()
                arrRemovedPeople.append(i as! Person)
            }
            return arrRemovedPeople
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
        
    }

}
