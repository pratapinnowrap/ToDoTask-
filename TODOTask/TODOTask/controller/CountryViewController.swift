//
//  CountryViewController.swift
//  TODOTask
//
//  Created by Pabitra on 06/01/19.
//  Copyright © 2019 Pabitra. All rights reserved.
//

import UIKit

class CountryViewController: UIViewController {

    @IBOutlet var idLbl: UILabel!
    @IBOutlet var nameLbl: UILabel!
    var strId = ""
    var strName = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        idLbl.text = strId
        nameLbl.text = strName
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 
    @IBAction func addPlayerAction(_ sender: Any) {
        let story:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let playerController =  story.instantiateViewController(withIdentifier: "country") as! CountryPlayerViewController
         self.navigationController?.pushViewController(playerController, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
