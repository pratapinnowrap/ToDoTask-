//
//  ViewController.swift
//  TODOTask
//
//  Created by Pabitra on 05/01/19.
//  Copyright © 2019 Pabitra. All rights reserved.
//

import UIKit
struct Country : Decodable {
    var name : String
    var image : String
    var id : String
}

class ViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource {
    
 var arrData = [Country]()
    var imageUrl : String = ""
    var imagedata = Data ()
   
    @IBOutlet var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
         getData()
        self.tableview.delegate = self
        self.tableview.dataSource = self 
        
        // Do any additional setup after loading the view, typically from a nib.
    }

 
    func getData()  {
        let url  = URL(string:"https://demo6869072.mockable.io/cricket/countries" )
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            do{
                if error == nil {
                    self.arrData = try JSONDecoder().decode([Country].self, from: data!)
                    for mainArr in self.arrData{
                        print(mainArr.name )
                        print(mainArr.id)
                        print(mainArr.image)
                        DispatchQueue.main.async {
                            self.tableview.reloadData()
                        }
                    }
                }
            }
            catch{
                 print("Error occured")
            }
            
            
        }.resume()
        
        
    }




    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : ToDoTableViewCell = tableview.dequeueReusableCell(withIdentifier: "ToDoTableViewCell", for: indexPath) as! ToDoTableViewCell
        cell.countryCodeLbl.text = "\(arrData[indexPath.row].id)"
        cell.counrtyLbl.text = "\(arrData[indexPath.row].name)"
//        imageUrl = arrData[indexPath.row].image
//        do{
//        imagedata = try NSData(contentsOfFile: imageUrl) as Data
//        
//        cell.imageView?.image = UIImage(data: imagedata)
//        }catch{
//            print("erorr")
//        }
//    cell.countryImg.image = UIImage(contentsOfFile: imageUrl)
         return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let country : CountryViewController = self.storyboard?.instantiateViewController(withIdentifier: "CountryViewController") as! CountryViewController
        country.strId = arrData[indexPath.row].id
        country.strName = arrData[indexPath.row].name
        self.navigationController?.pushViewController(country, animated: true)
    }

}
    



