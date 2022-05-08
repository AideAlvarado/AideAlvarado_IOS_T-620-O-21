

import UIKit

//Output del Presenter
protocol EditUserPresenterOutputProtocol {
    func reloadInformationInView()
}

class EditUserViewController: BaseView<EditUserPresenterInputProtocol> {
    //MARK: - Variables globales
    var data:EditUserCoordinatorDTO?
    var currentManager:String?
    //MARK: - IBOutlets
    
    @IBOutlet weak var updateBTN: UIButton!
    @IBOutlet weak var managerPicker: UIPickerView!
    @IBOutlet weak var isEnableLBL: UILabel!
    @IBOutlet weak var esGerenteLBL: UILabel!
    @IBOutlet weak var cancelarBTN: UIButton!
    @IBOutlet weak var isManagerSwitch: UISwitch!
    @IBOutlet weak var isEnabledSwitch: UISwitch!
    @IBOutlet weak var displayNameLBL: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var icBanner: UIImageView!
    
    //MARK: - IBAction
    
    @IBAction func cambiarEstaActivado(_ sender: UISwitch) {
        debugPrint("Esta activado ",isEnabledSwitch.isOn)
        isEnableLBL.isEnabled = isEnabledSwitch.isOn
    }
    @IBAction func estaActivado(_ sender: UISwitch) {
        debugPrint("Es gerente ",isManagerSwitch.isOn)
        esGerenteLBL.isEnabled = isManagerSwitch.isOn
    }
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated:false, completion: nil)
        
    }
    
    @IBAction func updateAction(_ sender: Any) {
        if self.presenter?.updateUser(initial: (data?.model!)!,
                                      displayName: displayNameLBL.text!, isManager: isManagerSwitch.isOn, isEnabled: isEnabledSwitch.isOn, manager: currentManager!) ?? false {
            self.dismiss(animated: true)
        } else {
            self.present(Utils.showAlert(title: "Editar usuario", message: "No ha habido cambios"), animated: true)
            
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround() 
        managerPicker.delegate = self
        managerPicker.dataSource = self
        
        debugPrint(#function)
        //debugPrint(data)
        if let viewModelData = data {
            if let model = viewModelData.model {
                isManagerSwitch.isOn = model.esGerente
                esGerenteLBL.isEnabled = model.esGerente
                isEnabledSwitch.isOn = model.estaActivado
                isEnableLBL.isEnabled = model.estaActivado
                displayNameLBL.text = model.displayName
                currentManager = model.manager
                email.text = model.email
            
            }
            
            
        }
        self.presenter?.loadDataFromInteractor()
    }
    
}


//OUTPUT del presenter
extension EditUserViewController: EditUserPresenterOutputProtocol {
    
    func reloadInformationInView() {
        self.managerPicker.reloadAllComponents()
        let currentManagerIndex = self.presenter?.selectedManager(currentManager!) ?? 0
        //debugPrint(currentManagerIndex,currentManager)
        self.managerPicker.selectRow(currentManagerIndex , inComponent: 0, animated: true)
    }
}

//Extension del Picker View
extension EditUserViewController: UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return  1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.presenter?.numberOfComponents() ?? 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.presenter?.titleForRow(indexPath:row)
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currentManager = self.presenter?.titleForRow(indexPath: row)
        //print(currentManager)
    }
}
