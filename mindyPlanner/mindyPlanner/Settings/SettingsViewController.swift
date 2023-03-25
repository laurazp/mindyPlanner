
import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationItems()
    }
    
    private func configureNavigationItems() {
        navigationItem.title = "Settings"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "info.circle"), style: .done, target: self, action: #selector(didTapInfoButton))
        navigationItem.rightBarButtonItem?.tintColor = .white
    }
    
    @objc func didTapInfoButton() {
        let storyboard = UIStoryboard(name: "InfoStoryboard", bundle: nil)
        if let viewController = storyboard.instantiateViewController(withIdentifier: "InfoViewController") as? InfoViewController {
        navigationController?.pushViewController(viewController, animated: true)
        //navigationController?.present(viewController, animated: true)
        }
    }
}
