//
//  DetailViewController.swift
//  WhoCallme
//
//  Created by Muhammad Imran on 13/05/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit
import CoreData
class DetailViewController: UIViewController {
    
    var history = [NSManagedObject]()
    var detailArray = [Detail]()
    var sectionNAme : [String] = ["Name" , "CNIC" , "Number" , "Address" , "Address1" ,"City" , "Region" ,"MS Date" , "Status Date"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        Constants.addBannerViewToView(viewController: self)
        if detailArray.count != 0{
            if Search(number: detailArray[0].number) != 0{
                   print("number Already Exist")
                   }
                   else{
                   save()
                   }
        }
        else{return}
       
    }
    

    
    func Search(number: String) -> Int
    {
        var count: Int = 0
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "History")
        let searchString = number
        request.predicate = NSPredicate(format: "number == %@", searchString)
        do {
            let result = try context.fetch(request)
            if result.count > 0 {
                for online in result {
                   let  mynumber = (online as AnyObject).value(forKey: "number") as? String
                }
                count = result.count
            } else {
                
            }
         
        } catch {
            print(error)
        }
        
        return count
    }

    func save() {
      
      guard let appDelegate =
        UIApplication.shared.delegate as? AppDelegate else {
        return
      }
      
      // 1
      let managedContext =
        appDelegate.persistentContainer.viewContext
      
      // 2
      let entity =
        NSEntityDescription.entity(forEntityName: "History",
                                   in: managedContext)!
      
      let numberhistory = NSManagedObject(entity: entity,
                                   insertInto: managedContext)
      
      // 3

        numberhistory.setValue(detailArray[0].name, forKeyPath: "name")
        numberhistory.setValue(detailArray[0].address, forKeyPath: "address")
        numberhistory.setValue(detailArray[0].address1, forKeyPath: "address1")
        numberhistory.setValue(detailArray[0].city, forKeyPath: "city")
        numberhistory.setValue(detailArray[0].cninc, forKeyPath: "cnic")
        numberhistory.setValue(detailArray[0].msDate, forKeyPath: "msdate")
        numberhistory.setValue(detailArray[0].number, forKeyPath: "number")
        numberhistory.setValue(detailArray[0].region, forKeyPath: "region")
        numberhistory.setValue(detailArray[0].statusDate, forKeyPath: "statusdate")
        
        
      
      // 4
      do {
        try managedContext.save()
        history.append(numberhistory)
      } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
      }
    }
    
    

    
}

extension DetailViewController: UITableViewDelegate,UITableViewDataSource{
    
    

    
    func numberOfSections(in tableView: UITableView) -> Int {
       return sectionNAme.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "detailcell" , for: indexPath)
        cell.textLabel?.numberOfLines = 0
        switch (indexPath.section) {
           case 0:
            cell.textLabel?.text = detailArray[indexPath.row].name
           case 1:
            cell.textLabel?.text = detailArray[indexPath.row].cninc
            case 2:
                cell.textLabel?.text = detailArray[indexPath.row].number
            case 3:
                cell.textLabel?.text = detailArray[indexPath.row].address
            case 4:
                cell.textLabel?.text = detailArray[indexPath.row].address1
            case 5:
                cell.textLabel?.text = detailArray[indexPath.row].city
            case 6:
                cell.textLabel?.text = detailArray[indexPath.row].region
            case 7:
                cell.textLabel?.text = detailArray[indexPath.row].msDate
            case 8:
                cell.textLabel?.text = detailArray[indexPath.row].statusDate
           default:
             cell.textLabel?.text = "Data Not Found Retry"
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sectionNAme[section]
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {

     //For Header Background Color
//     view.tintColor = .black
        
        // This is the blur effect

        let blurEffect = UIBlurEffect(style: .light)
           let blurEffectView = UIVisualEffectView(effect: blurEffect)

           // Gets the header view as a UITableViewHeaderFooterView and changes the text colour and adds above blur effect
           let headerView: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        headerView.textLabel!.textColor = UIColor.darkGray
           headerView.textLabel!.font = UIFont(name: "HelveticaNeue-Light", size: 13)
        headerView.tintColor = .groupTableViewBackground
           headerView.backgroundView = blurEffectView

    // For Header Text Color
    let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = .white
        
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
        
    }
    override func viewWillAppear(_ animated: Bool) {
           Constants.showInterstitial(viewController: self)
       }
    
}
