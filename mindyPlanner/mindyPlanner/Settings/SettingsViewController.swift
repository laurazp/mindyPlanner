
import UIKit
import AVFoundation

class SettingsViewController: UIViewController {

    @IBOutlet weak var musicCardView: UIView!
    @IBOutlet weak var musicSwitch: UISwitch!
    
    var player: AVAudioPlayer!
    private var isMusicPlaying: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationItems()
        setupView()
        setupNotificationCenter()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let nav = self.navigationController?.navigationBar
        nav?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    private func configureNavigationItems() {
        navigationItem.title = "Settings"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "info.circle"), style: .done, target: self, action: #selector(didTapInfoButton))
        navigationItem.rightBarButtonItem?.tintColor = .white
    }
    
    private func setupView() {
        musicSwitch.isOn = false
        musicCardView.layer.cornerRadius = 20
    }
    
    private func setupNotificationCenter() {
        let notificationCenter = NotificationCenter.default
        //App enters background
        notificationCenter.addObserver(self, selector: #selector(applicationDidEnterBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
        //App comes to foreground
        notificationCenter.addObserver(self, selector: #selector(applicationDidEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    @objc func didTapInfoButton() {
        let storyboard = UIStoryboard(name: "InfoStoryboard", bundle: nil)
        if let viewController = storyboard.instantiateViewController(withIdentifier: "InfoViewController") as? InfoViewController {
        navigationController?.pushViewController(viewController, animated: true)
        //navigationController?.present(viewController, animated: true)
        }
    }
    
    @IBAction func didTapMusicSwitch() {
        if let player = player, player.isPlaying {
            player.stop()
        } else {
            playMusic()
        }
    }
    
    private func playMusic() {
        let urlString = Bundle.main.path(forResource: "chilled-acoustic-indie-folk", ofType: "mp3")
        do {
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            guard let urlString = urlString else {
                return
            }
            player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString))
            guard let player = player else {
                return
            }
            player.numberOfLoops = -1 //loop
            player.play()
        } catch {
            print("Something went wrong...")
            print(error)
        }
    }
    
    @objc func applicationDidEnterBackground() {
        if player != nil {
            player.pause()
            player = nil
        }
    }
    
    @objc func applicationDidEnterForeground() {
        playMusic()
    }
}
