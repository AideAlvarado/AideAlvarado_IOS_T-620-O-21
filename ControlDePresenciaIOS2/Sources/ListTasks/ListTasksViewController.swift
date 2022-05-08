

import UIKit
import Firebase
//Output del Presenter
protocol ListTasksPresenterOutputProtocol {
    func reloadInformationInView()
}

class ListTasksViewController: BaseView<ListTasksPresenterInputProtocol> {
    //MARK: - Variables globales
    var data:ListTasksCoordinatorDTO?
    var user = Auth.auth().currentUser
    var db = Firestore.firestore()
    var ref:DatabaseReference! = Database.database().reference()
    
    //MARK: - Datamodel
    var taskTable = [UpdateTimeRecord]()
    //MARK: - IBOutlets
    
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var logoutButton: UIBarButtonItem!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var navigationBar: UINavigationBar!
    //MARK: - IBActions
    
    @IBAction func logoutAction(_ sender: Any) {
        
    }
    @IBAction func goBackAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: TaskViewCell.defaultReuseIdentifier,
                                 bundle: nil),
                           forCellReuseIdentifier: TaskViewCell.defaultReuseIdentifier)
        self.presenter?.loadDataFromInteractor()
        
    }

}


//OUTPUT del presenter
extension ListTasksViewController: ListTasksPresenterOutputProtocol {

    func reloadInformationInView() {
        self.tableView.reloadData()
        self.hideKeyboardWhenTappedAround() 
    }
}
extension ListTasksViewController:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter?.numberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskViewCell.defaultReuseIdentifier, for: indexPath) as! TaskViewCell
        if let model = self.presenter?.informationForCell(indexPath:indexPath.row){
            debugPrint("delegate")
            cell.delegate = self
            cell.setupCell(data: model)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let model = self.presenter?.informationForCell(indexPath: indexPath.row) {
            self.presenter?.didSelectRow(data: model)
        }
    }
    
}
extension ListTasksViewController:TaskViewCellOutputProtocol{
    func editRecord(data: UpdateTimeRecord) {
        //
        debugPrint(#function, data)
        self.presenter?.didSelectRow(data: data)
    }
    
    
}
