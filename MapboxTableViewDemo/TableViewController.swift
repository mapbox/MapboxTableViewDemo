import UIKit
import Mapbox

class TableViewController: UITableViewController {

    let identifier = "MapboxCell"
    var points = [CLLocationCoordinate2D]()
    var totalMaps = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.registerClass(NSClassFromString("UITableViewCell"), forCellReuseIdentifier: identifier)

        if let path = NSBundle.mainBundle().pathForResource("airports", ofType: "geojson"),
           let geojson = NSData(contentsOfFile: path),
           let airports = NSJSONSerialization.JSONObjectWithData(geojson, options: nil, error: nil) as? NSDictionary,
           let features = airports["features"] as? [NSDictionary] {
            for feature in features {
                if let geometry = feature["geometry"] as? NSDictionary,
                   let coordinates = geometry["coordinates"] as? [Double] {
                    points.append(CLLocationCoordinate2D(latitude: coordinates[1], longitude: coordinates[0]))
                }
            }
        }
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 200
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell!

        if let reusableCell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as? UITableViewCell {
            cell = reusableCell

            cell.layer.borderColor = UIColor.redColor().colorWithAlphaComponent(0.5).CGColor
            cell.layer.borderWidth = 10
        }

        var map: MGLMapView!

        if let existingMap = cell.viewWithTag(1) {
            map = existingMap as! MGLMapView
        } else {
            map = MGLMapView(frame: cell.bounds)
            map.logoView.hidden = true
            map.attributionButton.hidden = true
            map.userInteractionEnabled = false
            map.tag = 1
            cell.addSubview(map)
            totalMaps++
        }

        map.setCenterCoordinate(points[indexPath.row], zoomLevel: 12, animated: false)

        println("cell: \(indexPath.row) of \(self.tableView(tableView, numberOfRowsInSection: 0)), total maps: \(totalMaps)")

        return cell
    }

}
