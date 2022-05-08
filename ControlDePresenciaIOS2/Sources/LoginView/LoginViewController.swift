

import UIKit
import Lottie
import Firebase
//Output del Presenter
protocol LoginPresenterOutputProtocol {
    func reloadInformationInView()
}

class LoginViewController: BaseView<LoginPresenterInputProtocol> {
    //MARK: - Variables globales
    var userName : String = ""
    var password : String = ""
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var animationView: AnimationView!
    @IBOutlet weak var userNameView: UIView!
    
    @IBOutlet weak var userIMG: UIImageView!
    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var passwordIMG: UIImageView!
    @IBOutlet weak var passwordTF: UITextField!
    
    
    @IBOutlet weak var loginAction: UIButton!
    
    @IBOutlet weak var navigationTitle: UINavigationItem!
    //MARK: - IBActions
    
    @IBOutlet weak var loginClickAction: UIButton!
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    @IBAction func login(_ sender: Any) {
        validarCampos()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround() 
        configurarUI()
    }
    func configurarUI(){
        //Utils.animateLottie(animationView)
        // configurar la animacion
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 0.5
        animationView.play()
        navigationTitle.title = K.appName
    }
    func validarCampos(){
        let correcto = !(userNameTF.text?.isEmpty ?? false) && !(passwordTF.text?.isEmpty ?? false)
        if correcto {
            Auth.auth().signIn(withEmail: userNameTF.text ?? "",
                               password: passwordTF.text ?? "") { auhtResult, error in
                if let e = error {
                    self.present(Utils.showAlert(title: "Login error",
                                                 message: e.localizedDescription),
                    animated: true)
                } else {
                    // Ir a menu principal
                    self.presenter?.showMainScreen()
                
                }
            }
        } else {
            self.present(Utils.showAlert(title: "Login error",
                            message: "Rellene usuario y contraseña"),
                          animated: true)
        }
    }
}


//OUTPUT del presenter
extension LoginViewController: LoginPresenterOutputProtocol {
    
    func reloadInformationInView() {
        
    }
}
