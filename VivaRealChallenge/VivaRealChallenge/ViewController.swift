//
//  ViewController.swift
//  VivaRealChallenge
//
//  Created by Hoff Henry Pereira da Silva on 01/08/17.
//  Copyright © 2017 Hoff Henry Pereira da Silva. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var controller = GameController()

    override func viewDidLoad() {
        super.viewDidLoad()
        controller.getGames(quantity: 10)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

