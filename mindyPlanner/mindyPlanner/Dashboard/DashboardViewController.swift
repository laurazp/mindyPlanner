
import UIKit
import EventKit
import EventKitUI

class DashboardViewController: UIViewController {
    
    @IBOutlet weak var remindersTableView: UITableView!
    @IBOutlet weak var addReminderButton: UIButton!
    var remindersList: [String] = ["Cumpleaños María", "Aniversario papis", "Renovar DNI"]
    
    
    let eventStore = EKEventStore()
    
    
    
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
        remindersTableView.backgroundColor = UIColor.white.withAlphaComponent(0.0)
        //remindersTableView.reloadData()
    }
    
    private func setupButton() {
        addReminderButton.layer.cornerRadius = addReminderButton.frame.width / 2
        addReminderButton.clipsToBounds = true
        addReminderButton.setImage(UIImage(named: "addReminder.png"), for: .normal)
        //addReminderButton.backgroundColor = .white
        addReminderButton.addTarget(self, action: #selector(addReminderButtonPressed), for: .touchUpInside)
    }

    @objc func addReminderButtonPressed() {
        print("Add Reminder Button pressed")
        
        eventStore.requestAccess(to: .event) { [weak self] success, error in
            if success, error == nil {
                DispatchQueue.main.async {
                    guard let store = self?.eventStore else { return }
                    let eventViewController = EKEventEditViewController()
                    eventViewController.eventStore = store
                    eventViewController.editViewDelegate = self
                    
                    let newEvent = EKEvent(eventStore: store)
                    //TODO: Change date depending on selected date from user
                    newEvent.startDate = Date()
                    newEvent.endDate = Date()
                     //Save the event
                    do {
                        try store.save(newEvent, span: .thisEvent, commit: true)
                        //TODO: TableView se debería actualizar al añadir un evento !!
                         
                    } catch let err as NSError{
                        print ("An error occured \(err.description)")
                    }
                    eventViewController.event = newEvent
                    self?.present(eventViewController, animated: true, completion: nil)
                }
            }
        }
    }
    
    private func configureCell(cell: RemindersCell, indexPath: IndexPath) {
        cell.remindersTitleLabel.text = remindersList[indexPath.row]
        //TODO: Change icons depending on "Type" of reminder
        cell.remindersImageView.image = UIImage(named: "cake.png")
    }
}

extension DashboardViewController: UITableViewDelegate, UITableViewDataSource, EKEventViewDelegate, EKEventEditViewDelegate {
    
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
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "ReminderDetailStoryboard", bundle: nil)
        if let viewController = storyboard.instantiateViewController(withIdentifier: "ReminderDetailViewController") as? ReminderDetailViewController {
            
//            viewController.viewModel.viewDelegate = viewController
//            let reminder = viewModel.getReminder(at: indexPath.row)
//            viewController.viewModel.reminder = reminder
//
            //Back button
            let backItem = UIBarButtonItem()
            backItem.title = "Back"
            navigationItem.backBarButtonItem = backItem
            //TODO: navigationItem.title = remindersList[indexPath.row].title
            
            remindersTableView.deselectRow(at: indexPath, animated: true)
            navigationController?.pushViewController(viewController, animated: true)
            //navigationController?.present(viewController, animated: true)
        }
    }
    
    func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func eventViewController(_ controller: EKEventViewController, didCompleteWith action: EKEventViewAction) {
        controller.dismiss(animated: true, completion: nil)
    }
}
