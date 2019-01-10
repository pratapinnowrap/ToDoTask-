//
//  CountryPlayerViewController.swift
//  TODOTask
//
//  Created by Pabitra on 06/01/19.
//  Copyright © 2019 Pabitra. All rights reserved.
//

import UIKit
import CoreData

class CountryPlayerViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource {
    
   
    @IBOutlet weak var tableView: UITableView!
    
    var people : [NSManagedObject] = []
    
    
    @IBAction func addName(_ sender: Any) {
        
        let alert = UIAlertController(title: "New Name",
                                      message: "Add a new name",
                                      preferredStyle: .alert)
        
        
        alert.addTextField(configurationHandler: { (textFieldName) in
            textFieldName.placeholder = "name"
        })
        
        alert.addTextField(configurationHandler: { (textFieldSSN) in
            
            textFieldSSN.placeholder = "ssn"
        })
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { [unowned self] action in
            
            guard let textField = alert.textFields?.first,
                let nameToSave = textField.text else {
                    return
            }
            
            guard let textFieldSSN = alert.textFields?[1],
                let SSNToSave = textFieldSSN.text else {
                    return
            }
            
            self.save(name: nameToSave, ssn: Int16(SSNToSave)!)
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default)
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
   
    func save(name: String, ssn : Int16) {
        
        let person = CoreDataManager.sharedManager.insertPerson(name: name, ssn: ssn)
        
        if person != nil {
            people.append(person!)
            tableView.reloadData()
        }
    }
    
    @IBAction func deleteAction(_ sender: Any) {
        
        
        let alert = UIAlertController(title: "Delete by ssn", message: "Enter ssn", preferredStyle: .alert)
    
        let deleteAction = UIAlertAction(title: "Delete", style: .default) { [unowned self] action in
            guard let textField = alert.textFields?.first , let itemToDelete = textField.text else {
                return
            }
            self.delete(ssn: itemToDelete)
          
            self.tableView.reloadData()
            
        }
        
        let cancelAciton = UIAlertAction(title: "Cancel", style: .default)
        alert.addTextField()
        alert.addAction(deleteAction)
        alert.addAction(cancelAciton)
        
        present(alert, animated: true, completion: nil)
    }
    
    func delete(ssn: String) {
        
        let arrRemovedObjects = CoreDataManager.sharedManager.delete(ssn: ssn)
        people = people.filter({ (param) -> Bool in
            
            if (arrRemovedObjects?.contains(param as! Person))!{
                return false
            }else{
                return true
            }
        })
        
    }
    
    func fetchAllPersons(){
        
        if CoreDataManager.sharedManager.fetchAllPersons() != nil{
            
            people = CoreDataManager.sharedManager.fetchAllPersons()!
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchAllPersons()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "Cell")
         self.tableView.delegate = self
        self.tableView.dataSource = self
        
    }
    
    func delete(person : Person){
        CoreDataManager.sharedManager.delete(person: person)
    }
    
    func update(name:String, ssn : Int16, person : Person) {
        CoreDataManager.sharedManager.update(name: name, ssn: ssn, person: person)
    }




    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let person = people[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",
                                                 for: indexPath)
        cell.textLabel?.text = person.value(forKeyPath: "name") as? String
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let person = people[indexPath.row]
        
        let alert = UIAlertController(title: "Update Name",
                                      message: "Update Name",
                                      preferredStyle: .alert)

        alert.addTextField(configurationHandler: { (textFieldName) in
            textFieldName.placeholder = "name"
            textFieldName.text = person.value(forKey: "name") as? String
            })
        
        alert.addTextField(configurationHandler: { (textFieldSSN) in
            textFieldSSN.placeholder = "ssn"
            textFieldSSN.text = "\(person.value(forKey: "ssn") as? Int16 ?? 0)"
        })
        
        let updateAction = UIAlertAction(title: "Update", style: .default) { [unowned self] action in
            
            guard let textField = alert.textFields?[0],
                let nameToSave = textField.text else {
                    return
            }
            
            guard let textFieldSSN = alert.textFields?[1],
                let SSNToSave = textFieldSSN.text else {
                    return
            }
            self.update(name : nameToSave, ssn: Int16(SSNToSave)!, person : person as! Person)
            self.tableView.reloadData()
    }
        let deleteAction = UIAlertAction(title: "Delete", style: .default) { [unowned self] action in
            
            
            self.delete(person : person as! Person)
            
            self.people.remove(at: (self.people.index(of: person))!)
            
            self.tableView.reloadData()
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default)
        alert.addAction(updateAction)
        alert.addAction(cancelAction)
        alert.addAction(deleteAction)
        
        present(alert, animated: true)
        
    }


}
