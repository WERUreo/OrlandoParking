//
//  NibLoadableView.swift
//  OrlandoParking
//
//  Created by Keli'i Martin on 4/21/17.
//  Copyright © 2017 WERUreo. All rights reserved.
//

import UIKit

protocol NibLoadableView: class {}

extension NibLoadableView where Self: UIView
{
    static var nibName: String
    {
        return String(describing: self)
    }
}

extension UITableViewCell: NibLoadableView {}
