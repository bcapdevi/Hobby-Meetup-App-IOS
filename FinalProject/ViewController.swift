//
//  ViewController.swift
//  coreDataApp
//
//  Created by Brandon Capdevielle on 10/17/23.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as! AppDelegate
let context = appDelegate.persistentContainer.viewContext

var activeUser : String?
var currentAccount : Accounts?

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        lblIncorrect.isHidden = true
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var txtUsername: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
    
    @IBAction func btnRegisterUser(_ sender: Any) {
        addNewAccount(newAccountUsername: txtUsername.text!, newAccountPassword: txtPassword.text!)
    }
    
    
    
    func addNewAccount(newAccountUsername: String, newAccountPassword: String){
        
        
        let newAccount = Accounts (context: context)
        
        newAccount.username = newAccountUsername
        newAccount.password = newAccountPassword
        
        appDelegate.saveContext()
    }
    
    
    @IBAction func btnSignIn(_ sender: UIButton) {
        //create array of usernames and passwords
        var data = [Accounts]()
        
        do{
            data = try
                context.fetch(Accounts.fetchRequest())
            
            for existingAccount in data {
                if(existingAccount.username! == txtUsername.text && existingAccount.password! == txtPassword.text){
                    
                    activeUser = txtUsername.text
                    currentAccount = existingAccount
                    print("yay")
                    
                    lblIncorrect.isHidden = true
                    
                    let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                    let vc : UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "Map") as UIViewController
                    
                    self.present(vc, animated: true, completion: nil)
                    
                }else{
                    print("nay")
                    lblIncorrect.isHidden = false
                }
                
                
            }
            
            
        }
        catch{}
    }
    
    @IBOutlet weak var lblIncorrect: UILabel!
}

