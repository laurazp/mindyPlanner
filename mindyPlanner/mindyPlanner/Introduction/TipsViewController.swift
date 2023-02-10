
import UIKit

class TipsViewController: UIViewController {

    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //TODO: Change look of button
    }
    
    @IBAction func buttonIsClicked(_ sender: Any) {
        let storyboard = UIStoryboard(name: "HomeStoryboard", bundle: nil)
        if let viewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController {
            //viewController.title = "Home"
            viewController.navigationItem.setHidesBackButton(true, animated: true)
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
