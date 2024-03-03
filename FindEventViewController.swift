//
//  FindEventViewController.swift
//  FinalProject
//
//  Created by Turing on 12/5/23.
//

import UIKit

class FindEventViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        items = []
        
        var data = [Event]()
        
        do{
            data = try context.fetch(Event.fetchRequest())
            
            for existingEvent in data{

                    items.append(existingEvent.title!)
            }
        }catch{}
        
        tblItems.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "Cell")
        
        var content = cell.defaultContentConfiguration()
        
        content.text = items[indexPath.row]
        
        cell.contentConfiguration = content
        
        //cell.textLabel?.text = items[indexPath.row]
        
        //btn.titleLabel?.text = content.text
        let tapGestRec = UITapGestureRecognizer(target: self, action: #selector(cellTapped(_:)))
        
        tapGestRec.name = content.text!
        
        cell.addGestureRecognizer(tapGestRec)
        
        return cell
    }
    
    
    
    @objc func cellTapped(_ gestureRecognizer: UITapGestureRecognizer) {
            if gestureRecognizer.state == .ended {
                // Handle cell tap
                print("Cell tapped")
            }
        
        
        var data = [Event]()
        
        do{
            data = try context.fetch(Event.fetchRequest())
            
            for existingEvent in data{
                if existingEvent.title == gestureRecognizer.name{
                    selectedEvent = existingEvent
                }
            }
        }catch{}
        
        
       // UserDefaults.standard.set(siteName, forKey: "siteName")
        
        print("cell tapped")
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc : UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "info") as UIViewController
        
        self.present(vc, animated: true, completion: nil)
        
        }


    @IBOutlet weak var tblItems: UITableView!
    
}
