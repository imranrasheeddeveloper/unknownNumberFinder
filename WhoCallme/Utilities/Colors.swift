//
//  Colors.swift
//  My Recpies Book
//
//  Created by Muhammad Imran on 21/03/2020.
//  Copyright © 2020 itrid Technologies. All rights reserved.
//

import Foundation
import UIKit

class Colors{
    
    var gl: CAGradientLayer!
    
    init() {
        let colorTop = UIColor(red: 192.0 / 255.0, green: 38.0 / 255.0, blue: 42.0 / 255.0, alpha: 1.0).cgColor
               let colorBottom = UIColor(red: 35.0 / 255.0, green: 2.0 / 255.0, blue: 2.0 / 255.0, alpha: 1.0).cgColor

               self.gl = CAGradientLayer()
               self.gl.colors = [colorTop, colorBottom]
               self.gl.locations = [0.0, 1.0]
    }
}

