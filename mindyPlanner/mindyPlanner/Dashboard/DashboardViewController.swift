
import UIKit

class DashboardViewController: UIViewController {

    @IBOutlet weak var addReminderButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Dashboard"
        setupButton()
    }
    
    private func setupButton() {
        addReminderButton.layer.cornerRadius = addReminderButton.frame.width / 2
        addReminderButton.clipsToBounds = true
        addReminderButton.setImage(UIImage(named:"thumbsUp.png"), for: .normal)
        addReminderButton.backgroundColor = .white
        addReminderButton.addTarget(self, action: #selector(addReminderButtonPressed), for: .touchUpInside)
    }

    @objc func addReminderButtonPressed() {
        print("Add Reminder Button pressed")
    }
}
