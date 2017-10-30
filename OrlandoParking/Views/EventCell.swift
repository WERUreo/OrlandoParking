//
//  EventCell.swift
//  OrlandoParking
//
//  Created by Keli'i Martin on 4/19/17.
//  Copyright © 2017 WERUreo. All rights reserved.
//

import UIKit
import OPRequestService

class EventCell: UITableViewCell
{
    ////////////////////////////////////////////////////////////
    // MARK: - IBOutlets
    ////////////////////////////////////////////////////////////

    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var venueTimeLabel: UILabel!
    
    func configure(with event: OPEvent)
    {
        
    }
}
