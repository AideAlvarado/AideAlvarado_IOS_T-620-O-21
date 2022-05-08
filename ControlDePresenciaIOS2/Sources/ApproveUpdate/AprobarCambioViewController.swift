

import UIKit

//Output del Presenter
protocol AprobarCambioPresenterOutputProtocol {
    func reloadInformationInView()
}

class AprobarCambioViewController: BaseView<AprobarCambioPresenterInputProtocol> {
    //MARK: - Variables globales
    var data:AprobarCambioCoordinatorDTO?
    //MARK: - IBOutlets
    
    @IBOutlet weak var newEntryLBL: UILabel!
    @IBOutlet weak var approveBTN: UIButton!
    @IBOutlet weak var denyBTN: UIButton!
    @IBOutlet weak var newExitLBL: UILabel!
    @IBOutlet weak var clockOut: UILabel!
    @IBOutlet weak var clockInLBL: UILabel!
    @IBOutlet weak var txtSalida: UILabel!
    @IBOutlet weak var txtEntrada: UILabel!
    @IBOutlet weak var dayLBL: UILabel!
    @IBOutlet weak var txtDia: UILabel!
    @IBOutlet weak var avatarIMG: UIImageView!
    @IBOutlet weak var displayNameLBL: UILabel!
    //MARK: - IBAction
    
    @IBAction func denyAction(_ sender: Any) {
        self.presenter?.updateTask(data: registroActualizado(data: (data?.model)!, aprove: true))
        self.dismiss(animated: true)
    }
    
    @IBAction func aproveAction(_ sender: Any) {
        self.presenter?.updateTask(data: registroActualizado(data: (data?.model)!, aprove: true))
        self.dismiss(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        configurarUI()
    }
    func configurarUI(){
        displayNameLBL.text = data?.model?.displayName
        dayLBL.text = data?.model?.day
        clockInLBL.text = data?.model?.clockIn
        clockOut.text = data?.model?.clockOut
        newEntryLBL.text = data?.model?.requestEntry
        newExitLBL.text = data?.model?.requestExit
    }
    func registroActualizado(data:UpdateTimeRecord, aprove:Bool)->UpdateTimeRecord{
        let newStatus = aprove ? K.STATUS_CONFIRMED : K.STATUS_CANCELED
        let confirmedTime = TimeUtils.fechaHoraActual()
        
        return UpdateTimeRecord(id: data.id,
                                userId: data.userId,
                                displayName: data.displayName,
                                day: data.day,
                                clockIn: data.clockIn,
                                clockOut: data.clockOut,
                                requestEntry: data.requestEntry,
                                requestExit: data.requestExit,
                                minutes: data.minutes,
                                managerId: data.managerId,
                                requestedTimeUpdate: data.requestedTimeUpdate,
                                confirmedTimeUpdate: confirmedTime,
                                requestId: data.requestId,
                                status: newStatus)
    }
}


//OUTPUT del presenter
extension AprobarCambioViewController: AprobarCambioPresenterOutputProtocol {

    func reloadInformationInView() {
        
    }
}
