
import HorizonCalendar
import UIKit

class CalendarViewController: UIViewController, UITabBarControllerDelegate {

    let calendarView = UICalendarView()
//    let scrollView: UIScrollView = {
//        let scrollView = UIScrollView()
//        scrollView.translatesAutoresizingMaskIntoConstraints = false
//        scrollView.backgroundColor = .systemMint
//        return scrollView
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemMint
                
//        view.addSubview(scrollView)
//        scrollView.addSubview(calendarView)
        createCalendar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        let contentG = scrollView.contentLayoutGuide
        
//        NSLayoutConstraint.activate([
//            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//            scrollView.heightAnchor.constraint(equalToConstant: 400),
//            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            calendarView.leadingAnchor.constraint(equalTo: contentG.leadingAnchor),
//            calendarView.trailingAnchor.constraint(equalTo: contentG.trailingAnchor),
//            calendarView.bottomAnchor.constraint(equalTo: contentG.bottomAnchor),
//            calendarView.topAnchor.constraint(equalTo: contentG.topAnchor)
//        ])
        
    }
    
    private func createCalendar() {
        //Option 2
        /*let calendar = Calendar.current
        let startDate = calendar.date(from: DateComponents(year: 2020, month: 01, day: 01))!
        let endDate = calendar.date(from: DateComponents(year: 2022, month: 12, day: 31))!
        let content = CalendarViewContent(calendar: calendar,
                                          visibleDateRange: startDate...endDate,
                                          monthsLayout: .vertical(options: VerticalMonthsLayoutOptions()))
        let calendarView = CalendarView(initialContent: content)
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(calendarView)
        NSLayoutConstraint.activate([
            calendarView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            calendarView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            calendarView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            calendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])*/
        
        //Option 1
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
            calendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            calendarView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            calendarView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            calendarView.heightAnchor.constraint(equalToConstant: 300)
            //calendarView.leadingAnchor.constraint(equalTo: contentG.leadingAnchor, constant: 10),
            //calendarView.trailingAnchor.constraint(equalTo: contentG.trailingAnchor, constant: -10),
            //calendarView.bottomAnchor.constraint(equalTo: contentG.bottomAnchor, constant: -10),
            //calendarView.topAnchor.constraint(equalTo: contentG.topAnchor, constant: 10)
        ])
    }
}

extension CalendarViewController: UICalendarViewDelegate, UICalendarSelectionSingleDateDelegate {
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        //TODO: Mostrar eventos del día al hacer click
        print("Date selected: ", dateComponents?.date)
    }
    
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        return nil
    }
}
