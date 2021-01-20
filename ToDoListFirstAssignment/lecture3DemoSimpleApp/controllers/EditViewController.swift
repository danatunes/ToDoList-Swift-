//
//  EditViewController.swift
//  lecture3DemoSimpleApp
//
//  Created by Магжан Бекетов on 19.01.2021.
//

import UIKit

class EditViewController: UIViewController {

    @IBOutlet var titleField : UITextField!
    @IBOutlet var dateField : UITextField!
    public  var complitionHandler : ((String? , String?) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
       
    }
    
    @IBAction func didTapSave(){
        
        complitionHandler?(titleField.text , dateField.text)
        dismiss(animated: true, completion: nil)
    }
    

}
