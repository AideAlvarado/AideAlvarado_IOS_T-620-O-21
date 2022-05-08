//
//  UpdateTimeRecord.swift
//  ControlDePresenciaIOS2
//
//  Created by Aide Alvarado on 4/5/22.
//

import Foundation
struct UpdateTimeRecord:Codable{
    var id:String
    var userId:String
    var displayName:String
    var day:String
    var clockIn:String
    var clockOut:String
    var requestEntry:String
    var requestExit:String
    var minutes:Int
    var managerId:String
    var requestedTimeUpdate:String
    var confirmedTimeUpdate:String
    var requestId:String
    var status:Int
 
    var dictionary:[String:Any]{
        return ["clockIn":clockIn,
                "clockOut":clockOut,
                "confirmedTimeUpdate":confirmedTimeUpdate,
                "day":day,
                "displayName":displayName,
                "id":id,
                "managerId":managerId,
                "minutes":minutes,
                "requestEntry":requestEntry,
                "requestExit":requestExit,
                "requestId":requestId,
                "requestedTimeUpdate":requestedTimeUpdate,
                "status":status,
                "userId":userId]
    }
    var nsDictionary:NSDictionary {
        return dictionary as NSDictionary
    }
     
     }
