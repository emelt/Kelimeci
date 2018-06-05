//
//  ViewController.swift
//  Kelimeci
//
//  Created by Emel Topaloglu on 8/24/17.
//  Copyright © 2017 Emel Topaloglu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.styleClear()
        edgesForExtendedLayout = .all
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
    }
}
