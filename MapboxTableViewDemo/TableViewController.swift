import UIKit
import Mapbox

class TableViewController: UITableViewController {

    let identifier = "MapboxCell"
    var maxMapCount: UInt!
    var maps = [MGLMapView]()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.registerClass(NSClassFromString("UITableViewCell"), forCellReuseIdentifier: identifier)

        maxMapCount = UInt(view.bounds.size.height / tableView(tableView, heightForRowAtIndexPath: NSIndexPath(forRow: 0, inSection: 0))) + 2
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

            var map: MGLMapView?

            for existingMap in maps {
                let mapRect = existingMap.convertRect(existingMap.frame, toView: view)
                if CGRectIntersection(mapRect, view.frame) == CGRectNull {
                    map = existingMap
                    println("reused existing map for row \(indexPath.row)")
                }
            }

            if map == nil {
                let map = MGLMapView(frame: cell.bounds)
                map.logoView.hidden = true
                map.attributionButton.hidden = true
                map.userInteractionEnabled = false
                cell.addSubview(map)
                maps.append(map)
                println("made new map \(maps.count - 1) for row \(indexPath.row)")
            }
        }

        return cell
    }

}
