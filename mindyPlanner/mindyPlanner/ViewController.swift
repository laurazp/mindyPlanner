
import UIKit

class ViewController: UIViewController {

    var imageView: UIImageView = {
         let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        imageView.image = UIImage(named: "app_icon")
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            //self.performSegue(withIdentifier: "segue", sender: self)
            let storyboard = UIStoryboard(name: "IntroStoryboard", bundle: nil)
            if let viewController = storyboard.instantiateViewController(withIdentifier: "IntroViewController") as? IntroViewController {
                //viewController.title = "Home"
                viewController.navigationItem.setHidesBackButton(true, animated: true)
                self.navigationController?.pushViewController(viewController, animated: true)
            }
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.center = view.center
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.showAnimation()
        }
    }
    
    private func showAnimation() {
        UIView.animate(withDuration: 1) {
            let size = self.view.frame.size.width * 2
            let xPosition = size - self.view.frame.width
            let yPosition = self.view.frame.height - size
            
            self.imageView.frame = CGRect(x: -(xPosition/2), y: yPosition/2, width: size, height: size)
            self.imageView.alpha = 0
        }
    }
}
