//
//  MainViewController.swift
//  Hw
//
//  Created by rex on 2019/2/16.
//  Copyright © 2019年 Jimmy. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var colTextField: UITextField!
    @IBOutlet weak var rowTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onStartClick(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailVCID") as? DetailViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    

}
