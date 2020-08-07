import UIKit
import SHDateFormatter

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let deDELocale = Locale(identifier: "de_DE")
        let enUSLocale = Locale(identifier: "en_US")
        let frFRLocale = Locale(identifier: "fr_FR")

        print(SHDateFormatter.is12hFormat(deDELocale))
        print(SHDateFormatter.is12hFormat(enUSLocale))
        print(SHDateFormatter.is12hFormat(frFRLocale))
    }
}
