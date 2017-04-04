//
//  EarthquakeTableCell.swift
//  EarthQuakeViewer
//
//  Created by Cindy Bi on 4/2/17.
//  Copyright © 2017 Cindy Bi. All rights reserved.
//

import Foundation
import UIKit

class EarthquakeTableCell: UITableViewCell {
    @IBOutlet weak var datetimeLabel: UILabel!
    @IBOutlet weak var magLabel: UITextField!
    @IBOutlet weak var latLongLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
}
