import UIKit
import Mapbox

class TableViewController: UITableViewController {

    let identifier = "MapboxCell"

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.registerClass(NSClassFromString("UITableViewCell"), forCellReuseIdentifier: identifier)
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

            let map = MGLMapView(frame: cell.bounds)
            map.logoView.hidden = true
            map.attributionButton.hidden = true
            map.userInteractionEnabled = false
            cell.addSubview(map)
        } else {
            cell = UITableViewCell(style: .Default, reuseIdentifier: identifier)
        }

        cell.textLabel!.text = "Cell \(indexPath.row)"

        return cell
    }

}
