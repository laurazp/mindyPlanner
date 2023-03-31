
import EventKitUI
import EventKit
import UIKit

class CalendarViewController: UIViewController {
    
    let calendarView = UICalendarView()
    let eventStore = EKEventStore()
    var calendarEventsData = [String]()
    //var eventController = EKEventEditViewController()
    @IBOutlet weak var calendarBackView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = .systemMint
        navigationItem.title = "Calendar"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddButton))
        navigationItem.rightBarButtonItem?.tintColor = .systemMint
        createCalendar()
        configureTableView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let nav = self.navigationController?.navigationBar
        nav?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    private func createCalendar() {
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        calendarView.calendar = Calendar(identifier: .gregorian)
        calendarView.locale = .current
        calendarView.fontDesign = .rounded
        calendarView.delegate = self
        calendarView.selectionBehavior = UICalendarSelectionSingleDate(delegate: self)
        calendarView.backgroundColor = .systemBackground
        calendarView.layer.cornerCurve = .continuous
        calendarView.layer.cornerRadius = 20
        calendarView.tintColor = UIColor.systemTeal
        //calendarView.wantsDateDecorations = false
        
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
        tableView.backgroundColor = UIColor.white.withAlphaComponent(0.0)
        //tableView.backgroundColor = .systemMint
        tableView.estimatedRowHeight = 150
        definesPresentationContext = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addSubview(tableView)
    }
     
    @objc func didTapAddButton() {
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
    
    func searchForEvents(selectedDate: Date) {
        self.calendarEventsData.removeAll()
        let dayAfter = Calendar.current.date(byAdding: .day, value: 1, to: selectedDate)!
        var predicate: NSPredicate? = nil
        predicate = eventStore.predicateForEvents(withStart: selectedDate, end: dayAfter, calendars: nil)
        
        if let aPredicate = predicate {
            do {
                try self.eventStore.commit()
                eventStore.enumerateEvents(matching: aPredicate){ (event, stop) in
                    if event != nil {
                        self.calendarEventsData.append(event.title)
                    }
                }
            } catch let err as NSError{
                print ("An error occured \(err.description)")
            }
            self.tableView.reloadData()
        }
    }
    
    func dayHasEvents(selectedDate: Date) -> Bool {
        var dayHasEvents: Bool
        let dayAfter = Calendar.current.date(byAdding: .day, value: 1, to: selectedDate)!
        let predicate: NSPredicate? = eventStore.predicateForEvents(withStart: selectedDate, end: dayAfter, calendars: nil)
        var events: [EKEvent]? = [EKEvent]()
        
        if let aPredicate = predicate {
            do {
                try self.eventStore.commit()
                events = eventStore.events(matching: aPredicate)
            } catch let err as NSError{
                print ("An error occured \(err.description)")
            }
        }

        if events == [] {
            dayHasEvents = false
        } else {
            dayHasEvents = true
        }
        return dayHasEvents
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
        cell.backgroundColor = UIColor.white.withAlphaComponent(0.0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "EventDetailStoryboard", bundle: nil)
        if let viewController = storyboard.instantiateViewController(withIdentifier: "EventDetailViewController") as? EventDetailViewController {
            viewController.title = "Event details"
            navigationController?.pushViewController(viewController, animated: true) // Navegacion
        }
    }
    
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        searchForEvents(selectedDate: (dateComponents?.date)!)
    }
    
//    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
//                
//        //TODO: Add image for days with events
//        let dayHasEvents = dayHasEvents(selectedDate: dateComponents.date ?? Date())
//        if dayHasEvents {
//            let font = UIFont.systemFont(ofSize: 10)
//            let configuration = UIImage.SymbolConfiguration(font: font)
//            let image = UIImage(systemName: "star.fill", withConfiguration: configuration)?.withRenderingMode(.alwaysOriginal)
//            return .image(image)
//        } else {
//            return nil
//        }
//    }
    
    func eventViewController(_ controller: EKEventViewController, didCompleteWith action: EKEventViewAction) {
        controller.dismiss(animated: true, completion: nil)
        //Update calendar and decorations when data has changed
//        delegateName.observeEventChanges { changedDates in
//            calendarView.reloadDecorations(for: changedDates, animated: true)
//        }
    }
    
    func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
        self.dismiss(animated: true, completion: nil)
    }
}
