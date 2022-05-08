//
//  TimeRecordCell.swift
//  ControlDePresenciaIOS2
//
//  Created by Aide Alvarado on 2/5/22.
//

import UIKit

protocol TimeRecordCellOutputProtocol:AnyObject  {
    func editRecord(data:TimeRecord)
}
protocol TimeRecordCellInputProtocol{
    func setupCell(data:TimeRecord)
}
class TimeRecordCell: UITableViewCell, ReuseIdentifierProtocol {
    //MARK: - Variables locales
    var viewModelData : TimeRecord?
    
    //MARK: - Configuracion del delegado
    weak var delegate : TimeRecordCellOutputProtocol?
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var vistaRaiz: UIView!
    @IBOutlet weak var stackPrincipal: UIStackView!
    @IBOutlet weak var textoDiaLBL: UILabel!
    @IBOutlet weak var stackEntrada: UIStackView!
    @IBOutlet weak var textoHoraEntradaLBL: UILabel!
    @IBOutlet weak var horaEntradaLBL: UILabel!
    @IBOutlet weak var stackSalida: UIStackView!
    @IBOutlet weak var textoHoraSalidaLBL: UILabel!
    @IBOutlet weak var horaSalidaLBL: UILabel!
    @IBOutlet weak var editButton: UIButton!
    //MARK: - IBActions
    
    @IBOutlet weak var editTimeEntry: UIButton!
    
    
    @IBAction func editEntry(_ sender: Any) {
        debugPrint(#function)
        //debugPrint(viewModelData)
        //debugPrint(self.delegate)
        self.delegate?.editRecord(data: viewModelData!)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension TimeRecordCell:TimeRecordCellInputProtocol {
    func setupCell(data: TimeRecord) {
        //
        textoDiaLBL.text = data.day
        horaEntradaLBL.text = data.clockIn
        horaSalidaLBL.text = data.clockOut
        viewModelData = data
    }
    
    
}
