
import Foundation
import UIKit

class TextViewWithPadding : UITextView {
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    textContainerInset = UIEdgeInsets(top: 12, left: 10, bottom: 12, right: 10)
  }
}
