import UIKit
import Mapbox

class ViewController: UIViewController {
                            
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(MGLMapView(frame: view.bounds))
    }

}
