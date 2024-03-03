//
//  InformationViewController.swift
//  FinalProject
//
//  Created by Turing on 12/5/23.
//

import UIKit

class InformationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        btnRSVP.isEnabled = true
        
        txtTitle.text = selectedEvent?.title
        txtDesc.text = selectedEvent?.desc
        txtTime.text = selectedEvent?.date
        txtAddress.text = selectedEvent?.address
        txtAdmission.text = selectedEvent?.admission
        
        if(selectedEvent?.image == nil){
            imgEvent.image = UIImage(named: "logo-black")
        }else{
            imgEvent.image = UIImage(data: (selectedEvent?.image)!)
        }
        
        
        
        if((selectedEvent?.rsvpby?.contains(currentAccount!))!){
            btnRSVP.isEnabled = false
        }
    }
    
    @IBOutlet weak var imgEvent: UIImageView!
    
    @IBOutlet weak var txtTitle: UILabel!
    
    @IBOutlet weak var txtDesc: UILabel!
    
    @IBOutlet weak var txtAddress: UILabel!
    
    @IBOutlet weak var txtTime: UILabel!
    
    @IBOutlet weak var txtAdmission: UILabel!
    
    @IBOutlet weak var btnRSVP: UIButton!
    
    @IBAction func btnRSVP(_ sender: UIButton) {
        selectedEvent?.addToRsvpby(currentAccount!)
        btnRSVP.isEnabled = false
        
    }
    
}
