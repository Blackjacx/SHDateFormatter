import UIKit
import SHDateFormatter

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let deDE_Locale = Locale(identifier: "de_DE")
        let enUS_Locale = Locale(identifier: "en_US")
        let frFR_Locale = Locale(identifier: "fr_FR")

        print(SHDateFormatter.is12hFormat(deDE_Locale))
        print(SHDateFormatter.is12hFormat(enUS_Locale))
        print(SHDateFormatter.is12hFormat(frFR_Locale))
    }
}
