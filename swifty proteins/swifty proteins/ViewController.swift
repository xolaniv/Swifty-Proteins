//
//  ViewController.swift
//  swifty proteins
//
//  Created by Xolani VILAKAZI on 2019/11/29.
//  Copyright © 2019 Xolani VILAKAZI. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {
    var authError: NSError?
    
    var context : LAContext = LAContext()

    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var userNameTxt: UITextField!
    @IBOutlet weak var biometricsText: UILabel!
    @IBOutlet weak var biometricsButton: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    var authID : Bool = false
    
    var error: NSError?
    
    
    
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if authID == true {
            authID = false
            return true
        }else{
            return false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
        // Do any additional setup after loading the view.
        if !context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil){
            print("yes")
            biometricsButton.isHidden = true
            biometricsText.isHidden = true
        }
        else {
            biometricsButton.isHidden = false
            biometricsText.isHidden = false
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        userNameTxt.text = ""
        passwordTxt.text = ""
        
    }
    @IBAction func TouchIdAction(_ sender: Any) {
        context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: "We need your TouchID", reply: {
            (wasSuccessful, error) in
            if wasSuccessful
            {
                print("WAS A SUCCESS")
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "showLigandScreen", sender: nil)
                }
            }
            else
            {
                print("NOT LOGGED IN")
            }
        })
    }
    
    @IBAction func boimetricsButton(_ sender: Any) {
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Authenticate Biometrics to Log in"
            context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                [weak self] success, authenticationError in
                if success{
                DispatchQueue.main.async {
                    self?.performSegue(withIdentifier: "showlingands", sender: nil)
                    }
                }
                else{
                    let ac = UIAlertController(title: "Authentcation Failed", message: "You could not be verified please try again", preferredStyle: .alert)
                    let myAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    ac.addAction(myAction)
                    self?.present(ac, animated: true)
                }
            }
    
        }
        else {
            let ac = UIAlertController(title: "Biometry not availble", message: "Your device is not configured for biometric authentication", preferredStyle: .alert)
            let myAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            ac.addAction(myAction)
            self.present(ac, animated: true)
            
        }
        
    }


    @IBAction func loginBtn(_ sender: Any) {
        
        DispatchQueue.main.async {
            if (self.passwordTxt.text == "admin" && self.userNameTxt.text == "admin"){
                self.performSegue(withIdentifier: "showlingands", sender: nil)
            }
            else {
                let alertController = UIAlertController(title: "Error", message: "Wrong username and/or password", preferredStyle: .alert)
                  let myAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                  alertController.addAction(myAction)
                  self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
}
    

