//
//  File.swift
//  MyStudDetectorIos
//
//  Created by mac on 27/03/2019.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation
import GoogleMobileAds

struct Constants {
    
    
    // Test
    static let bannarId : String = "ca-app-pub-3940256099942544/2934735716"
    static let interstitialId : String = "ca-app-pub-3940256099942544/4411468910"
    static let appId : String = "ca-app-pub-3940256099942544~1458002511"
        
    
    
    static func addBannerViewToView(viewController: UIViewController) {
         let bannerView = GADBannerView(adSize: kGADAdSizeBanner)
  
            bannerView.adUnitID = Constants.bannarId
            
            bannerView.rootViewController = viewController
           
            
            bannerView.translatesAutoresizingMaskIntoConstraints = false
            viewController.view.addSubview(bannerView)
            viewController.view.addConstraints(
                [NSLayoutConstraint(item: bannerView,
                attribute: .bottom,
                relatedBy: .equal,
                toItem: viewController.view.safeAreaLayoutGuide,
                attribute: .bottom,
                multiplier: 1,
                constant: 0),
                 NSLayoutConstraint(item: bannerView,
                                    attribute: .centerX,
                                    relatedBy: .equal,
                                    toItem: viewController.view.safeAreaLayoutGuide,
                                    attribute: .centerX,
                                    multiplier: 1,
                                    constant: 0)
                ])
            
        
         bannerView.load(GADRequest())
    }

    
    static func showInterstitial(viewController: UIViewController) {
        

            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
                let app = UIApplication.shared.delegate as! AppDelegate
                
                app.i = app.i + 1
                
                if app.i > 5 {
                    
                    app.i = 0
                    
                    if app.interstitial.isReady {
                        app.interstitial.present(fromRootViewController: viewController.self)
                    } else {
                        print("Not Ready")
                    }
                }
                
            })
        
        
        
    }
    

}

