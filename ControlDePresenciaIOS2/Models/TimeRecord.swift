//
//  TimeRecord.swift
//  ControlDePresenciaIOS2
//
//  Created by Aide Alvarado on 2/5/22.
//

import Foundation
struct TimeRecord:Codable {
    let id:String
    let userId: String
    let day: String
    let clockIn : String
    let clockOut : String
    let minutes : Int
    var dictionary:[String:Any]{
        return ["clockIn":clockIn,
                "clockOut":clockOut,
                "day":day,
                "id":id,
                "minutes":minutes,
                "userId":userId]
    }
    var nsDictionary:NSDictionary {
        return dictionary as NSDictionary
    }
}
