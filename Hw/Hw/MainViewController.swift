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
        guard let colCount = Int(colTextField.text!), colCount > 0 else {
            return
        }
        guard let rowCount = Int(rowTextField.text!), rowCount > 0 else {
            return
        }
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailVCID") as! DetailViewController
        vc.setData(column: colCount, row: rowCount)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func isValidInt(_ str:String) -> Bool {
        let regEx = "[0-9]+"
        let predicate = NSPredicate(format:"SELF MATCHES %@", regEx)
        return predicate.evaluate(with: str)
    }
}

extension MainViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (textField == colTextField || textField == rowTextField) {
            let text = (textField.text ?? "") as NSString
            let newText = text.replacingCharacters(in: range, with: string)
            return isValidInt(newText)
        } else {
            return true
        }
    }
}
