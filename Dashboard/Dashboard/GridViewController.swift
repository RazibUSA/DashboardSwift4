//
//  GridViewController.swift
//  Dashboard
//
//  Created by Mollick, Md Razib Uddin on 2/26/18.
//  Copyright © 2018 Ashley Furniture. All rights reserved.
//

import UIKit

class GridViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //self.view.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
    }

   
    @IBAction func dismissBtmClicked(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
}
