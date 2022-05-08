

import UIKit

//Output del Presenter
protocol EditTimePresenterOutputProtocol {
    func reloadInformationInView()
}

class EditTimeViewController: BaseView<EditTimePresenterInputProtocol> {
    //MARK: - Variables globales
    var data:EditTimeCoordinatorDTO?
    //MARK: - IBOutlets
    
    @IBOutlet weak var enviarBTN: UIButton!
    @IBOutlet weak var cancelarBTN: UIButton!
    @IBOutlet weak var nuevaHoraSalida: UITextField!
    @IBOutlet weak var nuevaEtiquetaSalidaLBL: UILabel!
    @IBOutlet weak var salidaRegistradaLBL: UILabel!
    @IBOutlet weak var horaSalidaLBL: UILabel!
    @IBOutlet weak var nuevaHoraEntrada: UITextField!
    @IBOutlet weak var horaDeEntradaLBL: UILabel!
    @IBOutlet weak var nuevaLBL: UILabel!
    @IBOutlet weak var registradaLBL: UILabel!
    @IBOutlet weak var horaEntradaLBL: UILabel!
    @IBOutlet weak var horaDeSalidaLBL: UILabel!
    @IBOutlet weak var dayLBL: UILabel!
    @IBOutlet weak var jornadaLBL: UILabel!
    //MARK: - IBActions
    
    @IBAction func cancelarAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func enviarAction(_ sender: Any) {
        self.presenter?.generateTimeRecord(data: (data?.model!)!,
                                           newEntry: nuevaHoraEntrada.text ?? "",
                                           newExit: nuevaHoraSalida.text ?? "")
        self.dismiss(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //

        //
        self.hideKeyboardWhenTappedAround() 
        configurarUI()
    }
    func configurarUI(){
        debugPrint(#function)
        //debugPrint(data)
        dayLBL.text = data?.model?.day
        horaDeEntradaLBL.text = data?.model?.clockIn
        horaDeSalidaLBL.text = data?.model?.clockOut
    }
}


//OUTPUT del presenter
extension EditTimeViewController: EditTimePresenterOutputProtocol {

    func reloadInformationInView() {
        
    }
}
