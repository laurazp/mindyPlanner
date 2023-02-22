
import UIKit

class EventDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    private func configureView() {
        // Edit button
        let editButton = UIBarButtonItem()
        editButton.title = "Edit"
        navigationItem.rightBarButtonItem = editButton
    }
}
