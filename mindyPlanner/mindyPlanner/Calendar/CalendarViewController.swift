
import EventKitUI
import EventKit
import UIKit

class CalendarViewController: UIViewController {
    
    let calendarView = UICalendarView()
    let eventStore = EKEventStore()
    //var eventController = EKEventEditViewController()
    @IBOutlet weak var calendarBackView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var tableView: UITableView!
    
    //TEST --> DELETE !!
    var calendarEventsData = ["Event 1","Event 2","Event 3"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemMint
        navigationItem.title = "Calendar"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddButton))
        createCalendar()
        configureTableView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    private func createCalendar() {
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        calendarView.calendar = .current
        calendarView.locale = .current
        calendarView.fontDesign = .rounded
        calendarView.delegate = self
        calendarView.selectionBehavior = UICalendarSelectionSingleDate(delegate: self)
        calendarView.backgroundColor = .systemBackground
        calendarView.layer.cornerCurve = .continuous
        calendarView.layer.cornerRadius = 20
        calendarView.tintColor = UIColor.systemTeal
        calendarView.wantsDateDecorations = false
        
        calendarBackView.addSubview(calendarView)
                
        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            calendarView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            calendarView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            calendarView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    private func configureTableView() {
        tableView.register(UINib(nibName: "CalendarEventCell", bundle: nil), forCellReuseIdentifier: "CalendarEventCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .systemMint
        tableView.estimatedRowHeight = 150
        definesPresentationContext = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addSubview(tableView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            //Hide keyboard
            self.view.endEditing(true)
        }
    
    @IBAction func addToCalendar(sender: AnyObject) {
        
    }
    
    @objc func didTapAddButton() {
        eventStore.requestAccess(to: .event) { [weak self] success, error in
            if success, error == nil {
                DispatchQueue.main.async {
                    guard let store = self?.eventStore else { return }
                    //self?.eventController.editViewDelegate = self
                    let eventViewController = EKEventEditViewController()
                    eventViewController.eventStore = store
                    eventViewController.editViewDelegate = self
                    
//                    eventViewController.addObserver(forName: NSNotification.Name(rawValue: "EKEventStoreChangedNotification"), object: store, queue: updateQueue) {
//                                notification in
//
//                            if ignoreEKEventStoreChangedNotification {
//                                ignoreEKEventStoreChangedNotification = false
//                                return
//                            }
//
//                            // Rest of your code here.
//
//                    }
                    
                    let newEvent = EKEvent(eventStore: store)
                    newEvent.startDate = Date()
                    newEvent.endDate = Date()
            
                     //Save the event
                     do {
                         try store.save(newEvent, span: .thisEvent, commit: true)
                         //TODO: Add event to data list
                         self?.calendarEventsData.append(newEvent.title)
                     } catch let err as NSError{
                         print ("An error occured \(err.description)")
                     }
        
                    
                    
                    eventViewController.event = newEvent
                    self?.present(eventViewController, animated: true, completion: nil)
//                    let eventViewController = EKEventViewController()
//                    eventViewController.delegate = self
//                    eventViewController.event = newEvent
//                    let navigationController = UINavigationController(rootViewController: eventViewController)
//                    self?.present(navigationController, animated: true)
                }
            }
        }
    }
}

extension CalendarViewController: UICalendarViewDelegate, UICalendarSelectionSingleDateDelegate, EKEventViewDelegate, EKEventEditViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return calendarEventsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CalendarEventCell")! as UITableViewCell
        cell.textLabel!.text = calendarEventsData[indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.bold)
        cell.textLabel?.textColor = UIColor.systemBackground
        return cell
    }
    
    
    func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        //TODO: Mostrar eventos del día al hacer click
        
    }
    
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        //let font = UIFont.systemFont(ofSize: 10)
        //let configuration = UIImage.SymbolConfiguration(font: font)
        //let image = UIImage(systemName: "star.fill", withConfiguration: configuration)?.withRenderingMode(.alwaysOriginal)
        //return .image(image)

//        switch database.eventType(on: dateComponents) {
//            case .none:
//                return nil
//            case .busy:
//                return .default()
//            case .travel:
//                return .image(airplaneImage, color: .systemOrange)
//            case .party:
//                return .customView {
//                    MyPartyEmojiLabel()
//                }
//            }
        return .default()
    }
    
    func eventViewController(_ controller: EKEventViewController, didCompleteWith action: EKEventViewAction) {
        controller.dismiss(animated: true, completion: nil)
        //Update calendar and decorations when data has changed
//        delegateName.observeEventChanges { changedDates in
//            calendarView.reloadDecorations(for: changedDates, animated: true)
//        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        //Update calendar and decorations when data has changed
        //calendarView.reloadDecorations(forDateComponents: dateComponents, animated: true)
        
    }
}
