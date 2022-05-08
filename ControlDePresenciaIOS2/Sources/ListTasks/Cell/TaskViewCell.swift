//
//  TaskViewCell.swift
//  ControlDePresenciaIOS2
//
//  Created by Aide Alvarado on 4/5/22.
//

import UIKit
protocol TaskViewCellInputProtocol{
    func setupCell(data:UpdateTimeRecord)
}
protocol TaskViewCellOutputProtocol:AnyObject{
    func editRecord(data:UpdateTimeRecord)
}
class TaskViewCell: UITableViewCell,ReuseIdentifierProtocol {
    //MARK: - Variables globales
    var viewModelData:UpdateTimeRecord?
    //MARK: - configuracion del delegado
    weak var delegate:TaskViewCellOutputProtocol?
    //MARK: - IBOutlets
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var displayName: UILabel!
    //MARK: - IBAction
    
    @IBAction func editRecord(_ sender: Any) {
        debugPrint(#function)
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
extension TaskViewCell:TaskViewCellInputProtocol {
    func setupCell(data: UpdateTimeRecord) {
        //
        viewModelData = data
        dayLabel.text = viewModelData?.day
        displayName.text = viewModelData?.displayName
    }
    
    
}
