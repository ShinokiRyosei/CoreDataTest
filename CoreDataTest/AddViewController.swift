//
//  AddViewController.swift
//  CoreDataTest
//
//  Created by ShinokiRyosei on 2016/05/06.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import UIKit
import CoreData

class AddViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var memoField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        memoField.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        memoField.becomeFirstResponder()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        memoField.resignFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func save() {
        guard let text = memoField.text else { return }
        create(text)
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func create(text: String) {
        let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDel.managedObjectContext
        let entity = NSEntityDescription.entityForName("MemoStore", inManagedObjectContext: managedContext)
        let memo = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        memo.setValue(text, forKey: "memo")
        memo.setValue(self.getDate(), forKey: "date")
        
        do {
            try managedContext.save()
        }catch let error as NSError {
            print("\(error.localizedDescription)")
        }
    }
    
    func getDate() -> NSDate{
        let now = NSDate()
        return now
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
