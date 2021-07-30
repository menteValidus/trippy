//
//  StyledNavigationController.swift
//  Trippy
//
//  Created by Denis Cherniy on 25.05.2021.
//

import UIKit

public class StyledNavigationController: UINavigationController {

    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBarHidden(true, animated: false)
    }
}
