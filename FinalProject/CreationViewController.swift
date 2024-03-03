//
//  createEventViewController.swift
//  FinalProject
//
//  Created by Turing on 12/5/23.
//

import UIKit
import Photos


class CreationViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let imagePicker = UIImagePickerController()
    var imagePicture = UIImage()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
       
    }

    @IBOutlet weak var txtTitle: UITextField!
    

    @IBOutlet weak var txtAddress: UITextField!
    
    
    @IBOutlet weak var txtTime: UITextField!
    
    
    @IBOutlet weak var txtAdmission: UITextField!
    
    @IBOutlet weak var txtDescription: UITextView!
    
    @IBAction func btnAddPhoto(_ sender: UIButton) {
        
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            present(imagePicker, animated: true, completion: nil)
        
            
    }
    
    @IBAction func btnCreateEvent(_ sender: Any) {
        
        if isFieldsFull() {
            
            let newEvent = Event(context: context)
            
            newEvent.username = activeUser
            newEvent.title = txtTitle.text
            newEvent.address = txtAddress.text
            newEvent.date = txtTime.text
            newEvent.admission = txtAdmission.text
            newEvent.desc = txtDescription.text
            newEvent.longitude = pinLongitude
            newEvent.latitude = pinLatitude
            newEvent.image = imagePicture.pngData()
            
            if(newEvent.image == nil){
                newEvent.image = UIImage(named: "logo-black")?.pngData()
            }
            
            newEvent.addToRsvpby(currentAccount!)
            
            appDelegate.saveContext()
            
            txtTitle.text = ""
            txtAddress.text = ""
            txtTime.text = ""
            txtAdmission.text = ""
            txtDescription.text = ""
            
            //self.tabBarController?.selectedIndex = 0
            
            let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let vc : UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "Map") as UIViewController
            
            self.present(vc, animated: true, completion: nil)
        }else{
            let alertController = UIAlertController(title: "Missing Fields", message: "You must fill all fields in order to create the event!", preferredStyle: .alert)
                                                    
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
                                                    
        }
    }
    
    
    func isFieldsFull() -> Bool {
        if(txtTime.text==nil || txtTitle.text == nil || txtAddress.text == nil || txtAdmission.text==nil || txtDescription.text == nil){
            return false
        }
        
        if(txtTime.text=="" || txtTitle.text == "" || txtAddress.text == "" || txtAdmission.text=="" || txtDescription.text == ""){
            return false
        }
        
        return true
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagePicture = (info[UIImagePickerController.InfoKey.originalImage] as? UIImage)!
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
}
