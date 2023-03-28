
import UIKit

class ReminderEventViewController: UIViewController {
    
    @IBOutlet weak var titleTextView: UITextField!
    @IBOutlet weak var locationTextView: UITextField!
    @IBOutlet weak var allDayStackView: UIStackView!
    @IBOutlet weak var startDateStackView: UIStackView!
    @IBOutlet weak var endDateStackView: UIStackView!
    @IBOutlet weak var repeatMenuButton: UIButton!
    
    private var currentUserRepeatingOption: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureRepeatMenu()
        setupNavBar()
        setupViews()
    }
    
    func configureRepeatMenu() {
        var menuItems: [UIAction] {
            return [
                UIAction(title: "Custom", handler: updateRepeatOption),
                UIAction(title: "Every Year", handler: updateRepeatOption),
                UIAction(title: "Every Month", handler: updateRepeatOption),
                UIAction(title: "Every Two Weeks", handler: updateRepeatOption),
                UIAction(title: "Every Week", handler: updateRepeatOption),
                UIAction(title: "Every Day", handler: updateRepeatOption),
                UIAction(title: "Never", handler: updateRepeatOption)
            ]
        }
        
        var repeatMenu: UIMenu {
            return UIMenu(title: "Choose an option...", image: nil, identifier: nil, options: [], children: menuItems)
        }
        repeatMenuButton.menu = repeatMenu
        repeatMenuButton.showsMenuAsPrimaryAction = true
    }
    
    func updateRepeatOption(from action: UIAction) {
        repeatMenuButton.setTitle(action.title, for: .normal)
        //TODO: Do whatever is needed for every Repeating option
        
    }
    
    private func setupNavBar() {
        navigationController?.navigationBar.topItem?.title = "Add New Reminder"
        //Cancel button
        let cancelItem = UIBarButtonItem()
        cancelItem.title = "Cancel"
        navigationItem.leftBarButtonItem = cancelItem
        cancelItem.target = self
        cancelItem.action = #selector(cancelButtonPressed)
        //Add button
        let addItem = UIBarButtonItem()
        addItem.title = "Add"
        navigationItem.rightBarButtonItem = addItem
        addItem.target = self
        addItem.action = #selector(addButtonPressed)
    }
    
    private func setupViews() {
        titleTextView.layer.cornerRadius = 11
        titleTextView.layer.masksToBounds = true
        titleTextView.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: titleTextView.frame.height))
        titleTextView.leftViewMode = .always
        locationTextView.layer.cornerRadius = 11
        locationTextView.layer.masksToBounds = true
        locationTextView.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: locationTextView.frame.height))
        locationTextView.leftViewMode = .always
        allDayStackView.layer.cornerRadius = 10
        startDateStackView.layer.cornerRadius = 10
        endDateStackView.layer.cornerRadius = 10
    }
    
    @objc func cancelButtonPressed() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func addButtonPressed() {
        //TODO: Save Reminder and show it on Dashboard
        self.dismiss(animated: true, completion: nil)
    }
}
