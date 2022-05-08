//
//  UserViewCell.swift
//  ControlDePresenciaIOS2
//
//  Created by Aide Alvarado on 4/5/22.
//

import UIKit
import Kingfisher
protocol UserViewCellInputProtocol{
    func setupCell(data:UserRecord)
}
protocol UserViewCellOutputProtocol:AnyObject{
    func editRecord(data:UserRecord)
}
class UserViewCell: UITableViewCell,ReuseIdentifierProtocol {
    //MARK: - Variables globales
    var viewModelData: UserRecord?
    
    //configuracion del delegado
    weak var delegate:UserViewCellOutputProtocol?
    //MARK: - IBOutlets
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var displayNameLBL: UILabel!
    @IBOutlet weak var esGerenteLBL: UILabel!
    @IBOutlet weak var imgAvatar: UIImageView!
    //MARK: - IBActions
    
    @IBAction func editAction(_ sender: Any) {
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
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}

extension UserViewCell:UserViewCellInputProtocol{
    func setupCell(data: UserRecord) {
        //
        displayNameLBL.text = data.displayName
        if data.esGerente {
            esGerenteLBL.text = "es gerente"
            
        } else {
            esGerenteLBL.text = "No es gerente"
            
        }
        esGerenteLBL.isEnabled = data.esGerente
        viewModelData = data
        displayNameLBL.isEnabled = data.estaActivado
        self.imgAvatar.layer.cornerRadius = self.imgAvatar.frame.width/2.0
        self.imgAvatar.layer.borderWidth = 2.0

        let imageWidht = imgAvatar.image?.size.width
        
        //debugPrint("Image width", imageWidht)
        
        if (!data.avatar.isEmpty){
            imgAvatar.kf.setImage(with:URL(string:data.avatar)) { result in
                //debugPrint(result)
                switch(result){
                case .success(let value): do {
                    debugPrint("------> ", value.image.size.width)
                    self.imgAvatar.image = self.resizeImage(image: value.image, newWidth: imageWidht ?? 30.0)
                }
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                
                }
                
            }
        }
    }
}

/*
 
 let url = URL(string: urlImage)
 
 cell.imageView?.kf.setImage(with: url,
 placeholder: nil,
 options: [.transition(ImageTransition.fade(1))],
 progressBlock: { receivedSize, totalSize in
 print("\(indexPath.row + 1): \(receivedSize)/\(totalSize)")
 },
 completionHandler: { image, error, cacheType, imageURL in
 
 print("\(indexPath.row + 1): Finished")
 print(image?.size)
 cell.imageView?.image = self.resizeImage(image: image!, newWidth: 40.0)
 
 })
 */
