//
//  TabBarConfigurationViewController.swift
//  TeamMoods
//
//  Created by Marco D'Agostino on 10/12/2019.
//  Copyright © 2019 com.ibm.cio.be.MD.TeamMoods. All rights reserved.
//

import UIKit

class TabBarConfigurationViewController: UITabBarController {
   
   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      self.tabBar.barTintColor = .white
      
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
   }
   
   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      
   }
}
