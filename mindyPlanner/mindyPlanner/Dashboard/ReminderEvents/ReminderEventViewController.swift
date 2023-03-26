
import UIKit

class ReminderEventViewController: UIViewController {
    
    @IBOutlet weak var titleTextView: UITextField!
    @IBOutlet weak var locationTextView: UITextField!
    @IBOutlet weak var allDayStackView: UIStackView!
    @IBOutlet weak var startDateStackView: UIStackView!
    @IBOutlet weak var endDateStackView: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupViews()
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
