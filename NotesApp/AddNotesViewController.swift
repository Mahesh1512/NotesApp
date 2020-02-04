//
//  AddNotesViewController.swift
//  NotesApp
//
//  Created by apple on 04/02/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import CoreData
import KMPlaceholderTextView

class AddNotesViewController: UIViewController {
    
    @IBOutlet weak var titlealbl: UITextField!
    @IBOutlet weak var descriptionlbl: KMPlaceholderTextView!
    @IBOutlet weak var attachementBtn: UIButton!
    
    var imageData = Data()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    //Mark
    func save(title: String,desciption:String,timeStamp:Int,imagedata:Data) {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        // 1
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        // 2
        let entity =
            NSEntityDescription.entity(forEntityName: "Notes",
                                       in: managedContext)!
        
        let notes = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        
        // 3
        notes.setValue(title, forKey: "title")
        notes.setValue(desciption, forKey: "descript")
        notes.setValue(timeStamp, forKey: "timestamp")
        notes.setValue(imagedata, forKey: "image")
        
        // 4
        do {
            try managedContext.save()
            //
            self.navigationController?.popViewController(animated: true)
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func acnSave(_ sender: Any) {
        //Mark
        if(titlealbl.text!.isEmpty){
            let alertWarning = UIAlertController(title: "Error", message: "Please enter title", preferredStyle:.alert)
            let okAction = UIAlertAction(title: "Ok", style: .default) { (action:UIAlertAction) in
                
                
            }
            alertWarning.addAction(okAction)
            self.present(alertWarning, animated:false, completion: nil)
            
        }
        else if(descriptionlbl.text.isEmpty){
            let alertWarning = UIAlertController(title: "Error", message: "Please enter description", preferredStyle:.alert)
            let okAction = UIAlertAction(title: "Ok", style: .default) { (action:UIAlertAction) in
                
                
            }
            alertWarning.addAction(okAction)
            self.present(alertWarning, animated:true, completion: nil)
            
        }
        else{
            self.save(title:titlealbl.text!, desciption: descriptionlbl.text!, timeStamp:Int(Date().timeIntervalSince1970), imagedata: self.imageData)
        }
        
        
    }
    
    @IBAction func acnAttachement(_ sender: Any) {
        ImagePickerManager().pickImage(self){ image in
            
            
            self.attachementBtn.setTitle("", for: .normal)
            //here is the image
            print(image)
            self.attachementBtn.setBackgroundImage(image, for: .normal)
            self.imageData = image.pngData()!
        }
    }
}
