//
//  ViewController.swift
//  lecture3DemoSimpleApp
//
//  Created by admin on 06.01.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func signIn(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(identifier: "SecondViewController") as! SecondViewController
        navigationController?.pushViewController(vc, animated: true)
    }

}

