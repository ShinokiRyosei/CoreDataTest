//
//  ViewController.swift
//  CoreDataTest
//
//  Created by ShinokiRyosei on 2016/05/06.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var table: UITableView!
    
    var data = [NSManagedObject]()

    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        
        table.registerNib(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.read()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //データの読み込み
    func read() {
        let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDel.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "MemoStore")
        
        
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            data = results as! [NSManagedObject]
        }catch let error as NSError {
            print("\(error.localizedDescription)")
        }
        
        table.reloadData()
    }
    
    //データの削除
    func delete(numberOfRows number: Int) {
        let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
        let context: NSManagedObjectContext = appDel.managedObjectContext
        let request = NSFetchRequest(entityName: "MemoStore")
        
        do {
            let results = try context.executeFetchRequest(request)
            let obj = results[number] as! NSManagedObject
            context.deleteObject(obj)
            data.removeAtIndex(number)
            appDel.saveContext()
        }catch let error as NSError {
            print("\(error.localizedDescription)")
        }
        table.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! TableViewCell
        
        let index = data[indexPath.row]
        
        cell.descriptionLabel.text = index.valueForKey("memo") as! String
//        cell.dateLabel.text = index.valueForKey("date") as! String
        cell.dateLabel.text = convertDateToString(index.valueForKey("date") as! NSDate)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.delete(numberOfRows: indexPath.row)
    }
    
    func  convertDateToString(date: NSDate) -> String {
        let formatter = NSDateFormatter()
        formatter.locale = NSLocale(localeIdentifier: "ja_JP")
        formatter.dateFormat = "yyyy-MM-dd"
        let str = formatter.stringFromDate(date)
        return str
    }
}

