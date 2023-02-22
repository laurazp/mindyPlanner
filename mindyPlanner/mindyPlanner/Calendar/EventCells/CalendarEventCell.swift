
import UIKit

class CalendarEventCell: UITableViewCell {

    @IBOutlet weak var eventLabel: UILabel!
    var cardView = UIView()
    
    var calendarViewController: CalendarViewController = CalendarViewController()
    
    //var indexPath: IndexPath = IndexPath()
    //weak var delegate: CalendarViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func configureCell() {
        cardView.backgroundColor = .black
        cardView.layer.cornerRadius = 10.0
        cardView.layer.shadowColor = UIColor.gray.cgColor
        cardView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        cardView.layer.shadowRadius = 6.0
        cardView.layer.shadowOpacity = 0.7
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        eventLabel.text = nil
    }
}
