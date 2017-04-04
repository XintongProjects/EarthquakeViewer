//
//  ListViewController.swift
//  EarthQuakeViewer
//
//  Created by Cindy Bi on 3/29/17.
//  Copyright © 2017 Cindy Bi. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    let cellIdentifier = "eqCell"
    let networkRequest = DataFetcher()
    let urlString: String = "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/2.5_day.geojson"
    var records = [EarthquakeViewModel]() {
        didSet {
            print(records.description)
            DispatchQueue.main.async {
                self.refreshUI()
            }
        }
    }

    init() {
        super.init(nibName: nil, bundle: nil)
        tableView.delegate = self
        tableView.dataSource = self
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 80

        networkRequest.requestData(with: urlString)
        networkRequest.onComplete = { (data, response, error) in
            guard data != nil else {
                return
            }
            DataContainer.sharedInstance.processData(data: data!)
            self.records = convertEarthquakeItemsToViewModel(earthquakeItems: DataContainer.sharedInstance.earthquakes)
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func refreshUI() {
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = records.count
        print("count:\(count)")
        return count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        //et cell = tableView.dequeueReusableCell(withIdentifier: "eqCell", for: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! EarthquakeTableCell
        let index = indexPath.row
        cell.datetimeLabel?.text = records[index].date
        cell.magLabel?.text = records[index].mag
        cell.placeLabel.text = records[index].place
        cell.latLongLabel.text = "lat:" + records[index].latitude + " long:" + records[index].longitude

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        //TODO:Navigate to details view
    }
}

