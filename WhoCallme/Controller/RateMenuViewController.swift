//
//  RateMenuViewController.swift
//  WhoCallme
//
//  Created by Muhammad Imran on 17/05/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit
import StoreKit
class RateMenuViewController: UIViewController {
   let urlApp : String = " itms://itunes.apple.com/app/1514491311?mt=8"
      //let urlApp: String = "https://apps.apple.com/us/app/leprekon-isha/id1507932783"
      let moreappsLink = "https://apps.apple.com/developer/imran-rasheed/id1502818231"
     let imageArray = ["Use","Share","About","More"]
    @IBOutlet weak var mycollectionview: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

   func rateApp() {
   if #available(iOS 10.3, *) {
   SKStoreReviewController.requestReview()
   } else if let url = URL(string: urlApp) {
   if #available(iOS 10, *) {
   UIApplication.shared.open(url, options: [:], completionHandler: nil)
   } else {
   UIApplication.shared.openURL(url)
   } }
   }
   func displayShareSheet(shareContent:String) {
          let activityViewController = UIActivityViewController(activityItems: [shareContent as NSString], applicationActivities: nil)
          present(activityViewController, animated: true, completion: {})
      }

}


extension RateMenuViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "menucell", for: indexPath) as! RateMenuCollectionViewCell
        cell.myimage.image = UIImage(named: imageArray[indexPath.row])
        cell.layer.cornerRadius = 10
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "HowToUseViewController") as! HowToUseViewController
           
        navigationController?.pushViewController(newViewController, animated: true)
        }
        if indexPath.row == 1 {
          displayShareSheet(shareContent: urlApp)
        }
        
        if indexPath.row == 2 {
         UIApplication.shared.open(URL(string: "http://www.itridtechnologies.com")! as URL)
        }
        
        if indexPath.row == 3 {
        UIApplication.shared.open(URL(string: moreappsLink)!)
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
    
    
    
    
    
    
    
}

