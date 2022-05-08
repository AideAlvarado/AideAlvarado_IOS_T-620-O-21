//
//  TimeUtils.swift
//  ControlDePresenciaIOS2
//
//  Created by Aide Alvarado on 2/5/22.
//

import Foundation
class TimeUtils {
    static func fechaHoraActual()-> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/YYYY HH:mm:ss"   // HH for 24h clock
        let date = Date()
        let timeString = dateFormatter.string(from: date)
        return timeString    }
    static  func horaActual() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"   // HH for 24h clock
        let date = Date()
        let timeString = dateFormatter.string(from: date)
        return timeString
        
    }
    static func diaActual() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/YYYY"
        let date = Date()
        return dateFormatter.string(from: date)
    }
    static func timeToMinutes(data:String) -> Int{
        let componentes = data.split(separator: ":")
        if (componentes.count != 2) {
            return -1
            
        } else
        {
            let horaI = Int(componentes[0])
            let minutoI = Int(componentes[1])
            if let hora = horaI , let minuto = minutoI {
                if (hora < 0 || hora >= 24 || minuto < 0 || minuto > 60) {
                    return -1
                } else {
                    return hora*60 + minuto
                }
            } else
            {
                return -1
            }
        }
       
    }
}
