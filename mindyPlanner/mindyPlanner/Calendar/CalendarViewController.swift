
import EventKitUI
import EventKit
import UIKit

class CalendarViewController: UIViewController {
    
    let calendarView = UICalendarView()
    let eventStore = EKEventStore()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemMint
        navigationItem.title = "Calendar"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
        createCalendar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    @objc func didTapAdd() {
        eventStore.requestAccess(to: .event) { [weak self] success, error in
            if success, error == nil {
                DispatchQueue.main.async {
                    guard let store = self?.eventStore else { return }
                    let newEvent = EKEvent(eventStore: store)
                    newEvent.startDate = Date()
                    newEvent.endDate = Date()
                    
                    //TODO: configurar botones cancel y add
                    
                    
                    let eventViewController = EKEventEditViewController()
                    eventViewController.eventStore = store
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
    
    private func createCalendar() {
        calendarView.translatesAutoresizingMaskIntoConstraints = false
//        calendarView.calendar = .current
        calendarView.locale = .current
        calendarView.fontDesign = .rounded
//        calendarView.delegate = self
        calendarView.selectionBehavior = UICalendarSelectionSingleDate(delegate: self)
        calendarView.layer.cornerRadius = 20
        calendarView.backgroundColor = .systemBackground
        view.addSubview(calendarView)
        
        
        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            calendarView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            calendarView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            calendarView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
}

extension CalendarViewController: UICalendarViewDelegate, UICalendarSelectionSingleDateDelegate, EKEventViewDelegate {
    
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        //TODO: Mostrar eventos del día al hacer click
        print("Date selected: ", dateComponents?.date)
    }
    
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        return nil
    }
    
    func eventViewController(_ controller: EKEventViewController, didCompleteWith action: EKEventViewAction) {
        controller.dismiss(animated: true, completion: nil)
    }
}
