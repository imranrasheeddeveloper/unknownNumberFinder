//
//  MenuViewController.swift
//  WhoCallme
//
//  Created by Muhammad Imran on 12/05/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak var howtouse: UILabel!
    @IBOutlet weak var myCollectionView: UICollectionView!
   let imageArray = ["PhoneNumber","CNIC","World","History","International Search","Privacy"]
    //let imageArray = ["PhoneNumber","CNIC","World","Privacy"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped))
        howtouse.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    
    @objc func tapped(){
        
    }
}


extension MenuViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "menucell", for: indexPath) as! MenuCollectionViewCell
        cell.menuImage.image = UIImage(named: imageArray[indexPath.row])
        cell.layer.cornerRadius = 10
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            if Reachability.isConnectedToNetwork(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                navigationController?.pushViewController(newViewController, animated: true)
            }
           
            else{
                Alert(title: "Network error", message: "Please Check Your Internet Connection")
            }
     
        }
        if indexPath.row == 1 {
            
            if Reachability.isConnectedToNetwork(){
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "SearchByCINCViewController") as! SearchByCINCViewController
                navigationController?.pushViewController(newViewController, animated: true)
            }
                  else{
                      Alert(title: "Network error", message: "Please Check Your Internet Connection")
                  }
        }
        
        if indexPath.row == 2 {
            if Reachability.isConnectedToNetwork(){
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "InternationalNumberViewController") as! InternationalNumberViewController
                    //newViewController.numbers.removeAll()
                    navigationController?.navigationItem.title = "International Numbers"
                navigationController?.pushViewController(newViewController, animated: true)
            }
                  else{
                      Alert(title: "Network error", message: "Please Check Your Internet Connection")
                  }
        
        }
        if indexPath.row == 3 {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "HistoryViewController") as! HistoryViewController
            newViewController.numbers.removeAll()
            navigationController?.navigationItem.title = "History"
        navigationController?.pushViewController(newViewController, animated: true)
        }

        if indexPath.row == 4 {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "InternationalHistoryViewController") as! InternationalHistoryViewController
                newViewController.numbers.removeAll()
                navigationController?.navigationItem.title = "Internation History"
            navigationController?.pushViewController(newViewController, animated: true)
            }
        if indexPath.row == 5 {
                   let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                   let newViewController = storyBoard.instantiateViewController(withIdentifier: "PrivacyPolicyViewController") as! PrivacyPolicyViewController
                       navigationController?.navigationItem.title = "Privacy Policy"
                   navigationController?.pushViewController(newViewController, animated: true)
                   }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let noOfCellsInRow = 2

        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout

        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))

        return CGSize(width: size, height: size)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return  5
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return  5
    }
    
    
    
    func Alert(title: String, message: String){
        view.shake()
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    
    
    
}
