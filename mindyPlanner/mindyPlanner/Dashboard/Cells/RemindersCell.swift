
import UIKit

class RemindersCell: UITableViewCell {
    
    @IBOutlet weak var remindersCardView: UIView!
    @IBOutlet weak var remindersTitleLabel: UILabel!
    @IBOutlet weak var remindersImageView: UIImageView!
    
    var indexPath: IndexPath = IndexPath()

    override func awakeFromNib() {
        super.awakeFromNib()
        updateUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func updateUI() {
        remindersCardView.backgroundColor = UIColor.white.withAlphaComponent(0.7)
        remindersCardView.layer.cornerRadius = 20
        remindersCardView.layer.masksToBounds = false
        remindersCardView.layer.shadowColor = UIColor.black.withAlphaComponent(0.4).cgColor
        remindersCardView.layer.shadowOffset = CGSize(width: 0, height: 0)
        remindersCardView.layer.shadowOpacity = 0.8
    }
}
