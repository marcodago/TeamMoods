//
//  CustomTableViewCell.swift
//  TeamMoods
//
//  Created by Marco D'Agostino on 10/12/2019.
//  Copyright © 2019 com.ibm.cio.be.MD.TeamMoods. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var marble: UIImageView!
    @IBOutlet weak var feedback: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
      
    }

}
