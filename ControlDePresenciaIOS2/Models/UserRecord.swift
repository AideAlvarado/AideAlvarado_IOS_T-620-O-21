//
//  User.swift
//  ControlDePresenciaIOS2
//
//  Created by Aide Alvarado on 2/5/22.
//

import Foundation
struct UserRecord:Codable{
    var displayName:String
    var email:String
    var tenant:String
    var manager:String
    var estaActivado:Bool
    var esGerente:Bool
    var uuid :String
    var avatar:String
    var dictionary:[String:Any]{
        return ["displayName":displayName,
                "email":email,
                "esGerente":esGerente,
                "tenant":tenant,
                "manager":manager,
                "estaActivado":estaActivado,
                "uuid":uuid,
                "avatar":avatar]
    }
    var nsDictionary:NSDictionary {
        return dictionary as NSDictionary
    }
}
