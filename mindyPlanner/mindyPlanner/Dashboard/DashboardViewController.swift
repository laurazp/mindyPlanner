
import UIKit

class DashboardViewController: UIViewController {
    
    @IBOutlet weak var remindersTableView: UITableView!
    @IBOutlet weak var addReminderButton: UIButton!
    var remindersList: [String] = ["Test1", "Test2", "Test3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Dashboard"
        setupTable()
        setupButton()
    }
    
    private func setupTable() {
        remindersTableView.delegate = self
        remindersTableView.dataSource = self
        remindersTableView.rowHeight = UITableView.automaticDimension
        definesPresentationContext = true
        //TODO: Delete when CardViews are implemented??
        remindersTableView.backgroundColor = UIColor.white.withAlphaComponent(0.0)
        remindersTableView.reloadData()
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
    
    private func configureCell(cell: RemindersCell, indexPath: IndexPath) {
        cell.remindersTitleLabel.text = remindersList[indexPath.row]
        print(remindersList[indexPath.row])
    }
}

extension DashboardViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return remindersList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RemindersCell", for: indexPath) as? RemindersCell else { return UITableViewCell() }
        cell.backgroundColor = UIColor.white.withAlphaComponent(0.0)
        configureCell(cell: cell, indexPath: indexPath)
        cell.indexPath = indexPath
        //cell.delegate = self
        return cell
    }
}
