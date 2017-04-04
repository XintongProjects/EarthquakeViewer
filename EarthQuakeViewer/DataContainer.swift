//
//  DataContainer.swift
//  EarthQuakeViewer
//
//  Created by Cindy Bi on 3/30/17.
//  Copyright © 2017 Cindy Bi. All rights reserved.
//

import Foundation

class DataContainer {
    var earthquakes = [EarthQuakeItem]()
    static let sharedInstance: DataContainer = {
        let instance = DataContainer(earthquakeItems:[])
        return instance
    }()

    init() {

    }

    init(earthquakeItems: [EarthQuakeItem]) {
        earthquakes = earthquakeItems
    }

    func processData(data: Data) {
        do {
            guard let dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                return
            }

            let entries = dict["features"] as? [[String: Any]] //array of dictionary
            guard entries != nil else {
                print("did not get a list")
                return
            }
            earthquakes.removeAll()
            for item in entries! {
                earthquakes.append(processRecord(earthQuakeItem: item))
            }
            DataContainer.sharedInstance.earthquakes = earthquakes
            
        } catch {
            print("failed serializing data")
            return
        }
    }

    func processDetailsData(data: Data) -> EarthQuakeItem? {
        do {
            guard let dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                return nil
            }
            return processRecord(earthQuakeItem: dict)
        } catch {
            print("failed serializing detail data")
            return nil
        }
    }

    func processRecord(earthQuakeItem: [String:Any]) -> EarthQuakeItem {
        var earthquakeItem = EarthQuakeItem()
        let id = earthQuakeItem["id"]
        earthquakeItem.id = id as! String
        if let properties = earthQuakeItem["properties"] as? [String: Any] {
            if let mag = properties["mag"] {
                earthquakeItem.mag = mag as! Float
            }
            if let place = properties["place"] {
                earthquakeItem.place = place as! String
            }
            if let time = properties["time"] {
                earthquakeItem.date = time as! Double
            }
            if let detail = properties["detail"] {
                earthquakeItem.detailsUrlString = detail as! String
            }
        }
        if let geometry = earthQuakeItem["geometry"] as? [String: Any] {
            let coordinates = geometry["coordinates"] as! [Float]
            var cord = Coordinates()
            cord.longitude = coordinates[0]
            cord.latitude = coordinates[1]
            cord.depth = coordinates[2]
            earthquakeItem.coordinates = cord
        }
        return earthquakeItem;
    }

    func processResponse(response: URLResponse) {
        //TODO
    }

    deinit {
        earthquakes.removeAll()
    }
}
