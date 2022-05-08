//
//  Utils.swift
//  CiceMusic
//
//  Created by Andres Felipe Ocampo Eljaiek on 4/2/22.
//

import Foundation
import UIKit
import MessageUI
import Lottie

enum HTTPMethods: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case put = "PUT"
    case options = "OPTIONS"
}

enum TargetEnvironment: Int {
    case DEV = 0
    case PRE = 1
    case PRO = 3
}

struct RequestDTO {
    var params: [String: AnyObject]?
    var arrayParams: [[String: AnyObject]]?
    var method: HTTPMethods
    var endpoint: String
    var urlContext: URLEnpoint.BaseUrlContext
    
    init(params: [String: AnyObject]?, method: HTTPMethods, endpoint: String, urlContext: URLEnpoint.BaseUrlContext) {
        self.params = params
        self.method = method
        self.endpoint = endpoint
        self.urlContext = urlContext
    }
    
    init(arrayParams: [[String: AnyObject]]?, method: HTTPMethods, endpoint: String, urlContext: URLEnpoint.BaseUrlContext) {
        self.arrayParams = arrayParams
        self.method = method
        self.endpoint = endpoint
        self.urlContext = urlContext
    }
}

struct URLEnpoint {
    
#if DEV
    static let environmentDefault: TargetEnvironment = TargetEnvironment.DEV
#elseif PRE
    static let environmentDefault: TargetEnvironment = TargetEnvironment.PRE
#else
    static let environmentDefault: TargetEnvironment = TargetEnvironment.PRO
#endif
    
    enum BaseUrlContext{
        case backend
        case webService
        case heroku
    }

    static let weather = "weather?q=%@&appid=%@&units=metric"
    static let music = "%@/music/most-played/%@/songs.json"
    static let podcast = "%@/podcasts/top/%@/podcast-episodes.json"
    static let books = "%@/books/top-free/%@/books.json"
    static let apps = "%@/apps/top-free/%@/apps.json"
    
    static let menu = "iCoMenuResponse"
    static let tipsTraining = "iCoResponseConsejos"
    
}

struct LocalConfig {
    var day : String
    var clockIn : String
    var clockOut : String
    var clockedIn : Bool
}
extension URLEnpoint{
    static func getUrlBase(urlContext: BaseUrlContext) -> String {
        switch urlContext{
        case.backend:
            switch self.environmentDefault{
            case .DEV:
                return "https://www.azurecloud.com/api/v2/des-mgmt"
            case .PRE:
                return "https://www.azurecloud.com/api/v2/pre-devls"
            case .PRO:
                return "https://api.openweathermap.org/data/2.5/"
            }
        case .webService:
            switch self.environmentDefault{
            case .DEV:
                return "https://rss.applemarketingtools.com/api/v2/"
            case .PRE:
                return ""
            case .PRO:
                return ""
            }
        case .heroku:
            switch self.environmentDefault{
            case .DEV:
                return "https://icospartan-app.herokuapp.com/"
            case .PRE:
                return ""
            case .PRO:
                return ""
            }
        }
    }
}

class Utils {
    
    struct Constantes {
        let kUsername = "USERNAME"
        let kPassword = "PASSWORD"
        let kUsuarioLogado = "USUARIO_LOGADO"
        let kPrefer = UserDefaults.standard
        let BearerAuthetication = "Bearer 123456789"
        let Authetication = "Authorization"
    }
    static func animateLottie( _ imageAnimation: AnimationView){
        imageAnimation.contentMode = .scaleAspectFit
        imageAnimation.loopMode = .loop
        imageAnimation.animationSpeed = 0.5
        imageAnimation.play()
    }
    
    static func showAlert(title: String, message: String) -> UIAlertController {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        return alertVC
    }
    
    static func configuracionMailCompose(delegate: MFMailComposeViewControllerDelegate, data: [String]) -> MFMailComposeViewController {
        let mailCompo = MFMailComposeViewController()
        mailCompo.mailComposeDelegate = delegate
        mailCompo.setToRecipients(["info@mail.com", "masinfo@mail.es"])
        mailCompo.setSubject("este es en mensaje para el equipo de soporte")
        let emailBody = "Los datos del formualario de registro son \(data)"
        mailCompo.setMessageBody(emailBody, isHTML: false)
        return mailCompo
    }
    
    static func userPasswordCompleted(usuario: UITextField, password:UITextField) -> Bool {
        var  correcto = false
        correcto = !(usuario.text?.isEmpty ?? false) && !(password.text?.isEmpty ?? false)
        return correcto
        
    }
    
}


protocol ReuseIdentifierProtocol: AnyObject {
    static var defaultReuseIdentifier: String { get }
}

extension ReuseIdentifierProtocol where Self: UIView {
    static var defaultReuseIdentifier: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}

