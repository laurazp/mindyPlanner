
import UIKit

class InfoViewController: UIViewController {

    @IBOutlet weak var infoTitleLabel: UILabel!
    @IBOutlet weak var firstTopicTitleLabel: UILabel!
    @IBOutlet weak var firstTopicDescriptionLabel: UILabel!
    @IBOutlet weak var secondTopicTitleLabel: UILabel!
    @IBOutlet weak var secondTopicDescriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLabels()
    }
    
    private func configureLabels() {
        infoTitleLabel.text = "Info"
        firstTopicTitleLabel.text = "First Topic"
        firstTopicDescriptionLabel.text = "First description"
        secondTopicTitleLabel.text = "Second Topic"
        secondTopicDescriptionLabel.text = "Second description"
    }
}
