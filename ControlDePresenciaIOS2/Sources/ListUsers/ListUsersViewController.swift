

import UIKit
import Firebase
import Kingfisher
//Output del Presenter
protocol ListUsersPresenterOutputProtocol {
    func reloadInformationInView()
}

class ListUsersViewController: BaseView<ListUsersPresenterInputProtocol> {

    
    //MARK: - Variables globales
    var user = Auth.auth().currentUser
    var ref: DatabaseReference! = Database.database().reference()
    
    //MARK: - DataModel
    var userTable = [UserRecord]()
    //MARK: - IBOutlets
    
    @IBOutlet weak var rightBarButton: UIBarButtonItem!
    @IBOutlet weak var leftBarButton: UIBarButtonItem!
    @IBOutlet weak var navBarTittle: UINavigationItem!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - IBActions
    
    @IBAction func backPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func logOutAction(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            debugPrint("Intentando el logout")
            try firebaseAuth.signOut()
            // navigationController?.popViewController(animated: true)
            
            //self.navigationController?.popToRootViewController(animated: true)
            self.presenter?.showSplashScreen()
        } catch let signOutError as NSError {
            debugPrint("Error signing out: %@", signOutError)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround() 
        self.navBarTittle.title = "Listar usuarios"
        configurarTableView()
        self.presenter?.getProfilePictures()
        self.presenter?.loadDataFromInteractor()
        
    }
    @objc func done() { // remove @objc for Swift 3
        debugPrint("Go back")
    }
    func configurarTableView(){
        tableView.estimatedRowHeight = 90
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: UserViewCell.defaultReuseIdentifier,
                                 bundle: nil),
                           forCellReuseIdentifier: UserViewCell.defaultReuseIdentifier)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        debugPrint("view will appear")
        //W.A. al volver de la edición, asocia mal los datos, asi que releemos todo.
        self.presenter?.loadDataFromInteractor()
    }
    
}


//OUTPUT del presenter
extension ListUsersViewController: ListUsersPresenterOutputProtocol {

    func reloadInformationInView() {
        self.tableView.reloadData()
    }
}

extension ListUsersViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter?.numberOfRows()  ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserViewCell.defaultReuseIdentifier, for: indexPath) as! UserViewCell
        if let model = self.presenter?.informationForCell(indexPath: indexPath.row) {
            //
            cell.delegate = self
            cell.setupCell(data: model)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let model = self.presenter?.informationForCell(indexPath: indexPath.row){
            self.presenter?.didSelectRow(data: model)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }

}

extension ListUsersViewController:UserViewCellOutputProtocol{
    func editRecord(data:UserRecord){
        self.presenter?.showEditUser(data: data)
    }
}
