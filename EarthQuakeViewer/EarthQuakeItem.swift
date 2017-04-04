//
//  EarthQuakeItem.swift
//  EarthQuakeViewer
//
//  Created by Cindy Bi on 3/30/17.
//  Copyright © 2017 Cindy Bi. All rights reserved.
//

import Foundation

struct EarthQuakeItem {
    var id = ""
    var coordinates = Coordinates()
    var mag = Float()
    var place = ""
    var date = Double()
    var detailsUrlString = ""
}

struct Coordinates {
    var latitude = Float()
    var longitude = Float()
    var depth = Float()
}

