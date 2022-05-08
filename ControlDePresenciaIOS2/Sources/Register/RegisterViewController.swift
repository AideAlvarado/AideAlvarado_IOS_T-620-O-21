

import UIKit
import Lottie
import Firebase
import FirebaseStorage
//Output del Presenter
protocol RegisterPresenterOutputProtocol {
    func reloadInformationInView()
}

class RegisterViewController: BaseView<RegisterPresenterInputProtocol> {
    //MARK: - Variables globales
    var  hasImage:Bool = false
    var profileUrl:String?
    //MARK: - IBOutlets
    
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var navigationTitle: UINavigationItem!
    @IBOutlet weak var hacerFotoBTN: UIButton!
    @IBOutlet weak var registrarBTN: UIButton!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var iconoPassword: UIImageView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var iconUsernameImage: UIImageView!
    @IBOutlet weak var userNameView: UIView!
    @IBOutlet weak var friendlyNameTF: UITextField!
    @IBOutlet weak var displayNameView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    //MARK: - IBAction
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    @IBAction func registrarAction(_ sender: Any) {
        validarCampos()
        
    }
    @IBAction func getFotoAction(_ sender: Any) {
        let camaraProvider = CameraProvider(delegate: self)
        do {
            var picker:UIImagePickerController?
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                 picker = try camaraProvider.getCamera(canEditPhotos: true,
                                                       onlyImages: true)
            } else {
                picker = try camaraProvider.getImagePicker(source: .photoLibrary,
                                                           canEditPhotos: false,
                                                           onlyImages: true)
                
            }
           //
            present(picker!,animated: true)
            self.hasImage = true
        } catch {
            debugPrint("Error ", error.localizedDescription)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationTitle.title = K.appName
        self.hideKeyboardWhenTappedAround()
        
    }
    
    func validarCampos(){
        let correcto = !(friendlyNameTF.text?.isEmpty ?? false) &&
        !(userNameTF.text?.isEmpty ?? false) &&
        !(passwordTF.text?.isEmpty ?? false)
        debugPrint("Correcto : %@",correcto)
        let usuario = userNameTF.text ?? ""
        let password = passwordTF.text ?? ""
        debugPrint("Usuario", usuario, " Password:", password)
        if correcto {
            Auth.auth().createUser(withEmail: usuario,
                                   password: password) { authDataResult, error in
                //debugPrint(authDataResult)
                //debugPrint(error)
                if let e = error {
                    self.present(Utils.showAlert(title: "Error de registro",
                                                 message: e.localizedDescription),
                                 animated: true)
                } else {
                    // vamos a actualizar la foto de perfil, si existe
                    let imageName = UUID().uuidString
                    let storageRef = Storage.storage().reference().child("profile_images").child("\(imageName).jpg")
                    guard let uid = authDataResult?.user.uid else { return }
                    if let uploadData = self.imageView.image?.jpegData(compressionQuality: 0.1) {
                        storageRef.putData(uploadData, metadata: nil) { (_, error) in
                            if let error = error {
                                print(error)
                                return
                            }
                            storageRef.downloadURL { (url, error) in
                                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                                changeRequest?.displayName = self.friendlyNameTF.text
                                if let error = error {
                                    debugPrint(error)
                                } else {
                                    debugPrint("guardando la foto de perfil")
                                    guard let photoUrl = url else {return}
                                    self.profileUrl = photoUrl.absoluteString
                                    changeRequest?.photoURL = photoUrl.absoluteURL
                                    
                                }
                                changeRequest?.commitChanges(){ _ in
                                    self.presenter?.saveUserData(uid:uid,
                                        username: usuario,
                                                                 friendlyName: self.friendlyNameTF.text ?? "-",
                                                                 password: password,
                                                                 profilePicture: self.profileUrl ?? "-")
                                    
                                }
                            }
                        }
                    }

                    
                    self.presenter?.showMainScreenFromRegister(displayName: self.userNameTF.text!,
                                                               imageView: self.imageView)
                }
            }
        } else {
            self.present(Utils.showAlert(title: "Error de registro",
                                         message: "Datos incompletos"),
                         animated: true)
        }
    }
/*
    func createNewUser(name: String, email: String, phone: String, photo: UIImage, password: String, onCompletion: @escaping (Bool, RequestErrors?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print("Login error: \(error.localizedDescription)")
                onCompletion(false, .authError)
                return
            }

            let imageName = UUID().uuidString
            let storageRef = Storage.storage().reference().child("profile_images").child("\(imageName).jpg")

            guard let uid = result?.user.uid else { return }

            if let uploadData = photo.jpegData(compressionQuality: 0.1) {
                storageRef.putData(uploadData, metadata: nil, completion: { (_, error) in
                    if let error = error {
                        print(error)
                        return
                    }
                    storageRef.downloadURL(completion: { (url, error) in
                        if let error = error {
                            print(error)
                            return
                        }
                        guard let photoUrl = url else { return }
                        let values = ["displayName": name, "email": email, "phoneNumber": phone, "photoURL": photoUrl.absoluteString]
                        let ref = Database.database().reference()
                        let usersReference = ref.child("users").child(uid)
                        usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
                            if err != nil {
                                print(err!)
                                return
                            }
                            User.shared = User(uid: uid, displayName: name, email: email, phoneNumber: phone, photoURL: photoUrl)
                            onCompletion(true, nil)
                        })
                    })
                })
            }
        }
 */
}


//OUTPUT del presenter
extension RegisterViewController: RegisterPresenterOutputProtocol {

    func reloadInformationInView() {
        
    }
}
extension RegisterViewController:UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = (
            info[UIImagePickerController.InfoKey.editedImage] as? UIImage ??
            info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        )
        picker.dismiss(animated: true) {
            self.imageView.image = image
        }
    }
}
