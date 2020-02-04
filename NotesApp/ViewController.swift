//
//  ViewController.swift
//  NotesApp
//
//  Created by apple on 04/02/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import CoreData

//Mark TableView cell class
class noteTableviewCell:UITableViewCell{
    @IBOutlet weak var titleLblel: UILabel!
    @IBOutlet weak var descriptionLblel: UILabel!
    
}

class ViewController: UIViewController , UITableViewDelegate , UITableViewDataSource , UISearchBarDelegate {
    
    //Mark - outlests
    @IBOutlet weak var notesTblVw: UITableView!
    @IBOutlet weak var noNotesLbl: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var tempNotes = [NotesModel]()
    var orignalNotes = [NotesModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       searchBar.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(true)
         self.fechDataFromDB()
    }
    
    //Mark - Add Notes Pressed
    @IBAction func acnAddnotes(_ sender: Any) {
        //AMrk - Action button
    }
    
    func fechDataFromDB(){
        orignalNotes.removeAll()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Notes")
        //request.predicate = NSPredicate(format: "age = %@", "12")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                print(data.value(forKey: "title") as! String)
                let obj = NotesModel(data: data)
                orignalNotes.append(obj)
            }
            
            tempNotes = orignalNotes
            if(tempNotes.count > 0){
              noNotesLbl.isHidden = true
            notesTblVw.isHidden = false
            }
            else{
                noNotesLbl.isHidden = false
                notesTblVw.isHidden = true
            }
            //Mark
            notesTblVw.reloadData()
            
        } catch {
            
            print("Failed")
        }
    }
    
    
    //Mark - Tableview Datasource and Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Mark
        return tempNotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Mark
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell") as? noteTableviewCell
        //Mark
        let obj = tempNotes[indexPath.row]
        
        cell?.titleLblel.text = obj.title
        cell?.descriptionLblel.text = obj.description
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Mark
        
    }
    
    //Mark
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //Mark
        if(searchText == ""){
            //Mark - load main original
            tempNotes = orignalNotes
           
        }
        else{
            tempNotes = tempNotes.filter {$0.title.contains(searchText) || $0.description.contains(searchText)}
        }
        
        print("searchText \(searchText)")
         notesTblVw.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
//Mark
    
    @IBAction func acnFilter(_ sender: Any) {
        let alert = UIAlertController(title: "Filter", message: nil, preferredStyle: .actionSheet)
        let dateBtn = UIAlertAction(title: "Sort By Date cretaed", style: .default){
            UIAlertAction in
            //Mark
            self.tempNotes = self.tempNotes.filter {$0.timeStamp <= Int(Date().timeIntervalSince1970)}
            self.notesTblVw.reloadData()
           
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel){
            UIAlertAction in
            self.tempNotes = self.orignalNotes
             self.notesTblVw.reloadData()
        }
        
        // Add the actions
        alert.addAction(dateBtn)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    
}

