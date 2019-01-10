//
//  ToDoTableViewCell.swift
//  TODOTask
//
//  Created by Pabitra on 05/01/19.
//  Copyright © 2019 Pabitra. All rights reserved.
//

import UIKit

class ToDoTableViewCell: UITableViewCell {

    @IBOutlet var countryCodeLbl: UILabel!
    @IBOutlet var counrtyLbl: UILabel!
    @IBOutlet var countryImg: UIImageView!
    
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
