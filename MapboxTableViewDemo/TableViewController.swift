import UIKit

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
        } else {
            cell = UITableViewCell(style: .Default, reuseIdentifier: identifier)
        }

        cell.textLabel!.text = "Cell \(indexPath.row)"

        return cell
    }

}
