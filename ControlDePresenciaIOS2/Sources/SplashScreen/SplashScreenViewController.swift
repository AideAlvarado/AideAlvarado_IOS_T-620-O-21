

import UIKit
import Firebase
import Lottie
//Output del Presenter
protocol SplashScreenPresenterOutputProtocol {
    func reloadInformationInView()
}

class SplashScreenViewController: BaseView<SplashScreenPresenterInputProtocol> {
    //MARK: - Variables globales
    var user: Firebase.User? = Auth.auth().currentUser
    var charIndex = 0
    //MARK: - IBOutlets
    
    @IBOutlet weak var imageAnimation: AnimationView!
    
    @IBOutlet weak var splashMessage: UILabel!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var registerButton: UIButton!
    
    //MARK: - IBActions
    
    @IBAction func loginAction(_ sender: UIButton) {
        self.presenter?.showLogin()
    }
    
    
    @IBAction func registerAction(_ sender: Any) {
        self.presenter?.showRegister()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.getApiKeys()
        configurarUI()
        // Temporizamos y si tenemos
        Timer.scheduledTimer(withTimeInterval: 0.1 * Double(charIndex),
                             repeats: false) { (timer) in
            self.loginButton.isHidden = false
            self.registerButton.isHidden = false
            
            // Si el usuario ya está logueado, nos iremos directamente al menu
            if self.user != nil {
                //
                self.presenter?.showMainMenu()
            }
        }
    }
    
    
    func configurarUI()
    {
        debugPrint(#function)
        // Ocultar botones
        loginButton.isHidden = true
        registerButton.isHidden = true

        // configurar la animacion
        imageAnimation.contentMode = .scaleAspectFit
        imageAnimation.loopMode = .loop
        imageAnimation.animationSpeed = 0.5
        imageAnimation.play()
        // Animamos el texto del splash Screen
        self.splashMessage.text = ""
        let titleText = K.appName
        for letter in titleText {
            Timer.scheduledTimer(withTimeInterval: 0.1 * Double(charIndex),
                                 repeats: false) { (timer) in
                self.splashMessage.text?.append(letter)
            }
            charIndex += 1
        }
        

    }
}


//OUTPUT del presenter
extension SplashScreenViewController: SplashScreenPresenterOutputProtocol {
    
    func reloadInformationInView() {
        
    }
}
