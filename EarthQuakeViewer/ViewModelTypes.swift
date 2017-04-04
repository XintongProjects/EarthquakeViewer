//
//  ViewModelType.swift
//  EarthQuakeViewer
//
//  Created by Cindy Bi on 3/31/17.
//  Copyright © 2017 Cindy Bi. All rights reserved.
//

import Foundation

struct EarthquakeViewModel {
    var id = ""
    var mag = ""
    var place = ""
    var date = ""
    var detailsUrlString = ""
    var longitude = ""
    var latitude = ""
    var depth = ""
}

func convertEarthquakeItemForDisplay (earthquakeItem: EarthQuakeItem) -> EarthquakeViewModel {
    var result = EarthquakeViewModel()
    result.id = earthquakeItem.id
    result.mag = String(format: "%.2f", earthquakeItem.mag)
    result.place = earthquakeItem.place
    result.date = convertDoubleToDate(fromNum: earthquakeItem.date/1000)
    result.detailsUrlString = earthquakeItem.detailsUrlString
    result.longitude = String(format: "%.4f", earthquakeItem.coordinates.longitude)
    result.latitude = String(format: "%.4f", earthquakeItem.coordinates.latitude)
    result.depth = String(format: "%.2f", earthquakeItem.coordinates.depth) + "km"

    return result
}

func convertEarthquakeItemsToViewModel(earthquakeItems: [EarthQuakeItem]) -> [EarthquakeViewModel] {
    var eqViewModels = [EarthquakeViewModel]()
    for item in earthquakeItems {
        let convertedViewModel = convertEarthquakeItemForDisplay(earthquakeItem: item)
        eqViewModels.append(convertedViewModel)
    }
    return eqViewModels
}

func convertDoubleToDate(fromNum num:Double) -> String {
    let date = NSDate(timeIntervalSince1970: num)
    let dateFormatter = DateFormatter()
    dateFormatter.timeStyle = DateFormatter.Style.medium
    dateFormatter.dateStyle = DateFormatter.Style.medium
    let localDate = dateFormatter.string(from: date as Date)
    return localDate
}
