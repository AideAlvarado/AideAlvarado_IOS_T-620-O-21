
import Foundation
import Firebase
//Input del interactor
protocol ClockInInteractorInputProtocol {
    func loadConfig() -> LocalConfig
    func saveLocalData(config:LocalConfig)
    func transformDataFromInteractor()
    func saveTimeRecordEntry(data:TimeRecord)
    func transformWeatherDataFromInteractor(city:String)
}

final class ClockInInteractor: BaseInteractor<ClockInInteractorOutputProtocol> {
    var defaults = UserDefaults.standard
    var user: Firebase.User? = Auth.auth().currentUser
    let provider: ClockInProviderInputProtocol = ClockInProvider ()
    var ref: DatabaseReference! = Database.database().reference()
    var timeRecords = [TimeRecord]()
    /*
    func userIsAdmin()->Bool{
        let user = Auth.auth().currentUser
        return true
    }
     */
}


//Input del interactor
extension ClockInInteractor: ClockInInteractorInputProtocol {
    func transformWeatherDataFromInteractor(city: String) {
        //
        self.provider.fetchData(city: city) { [weak self] (result) in
            guard self != nil else {return}
            switch result {
            case .success(let main): do {
                self?.presenter?.dataFromWeather(data: main)
                debugPrint(main)
            
            }
            case .failure(let error): do {
                debugPrint(error)
            }
            } // end switch
        }
    }
    

    
    func saveTimeRecordEntry(data:TimeRecord){
        //self.ref.child("users").child(user.uid).setValue(["username": username])
        let datos: [String:Any] = [
            "clockIn":data.clockIn,
            "clockOut":data.clockOut,
            "day":data.day,
            "id":data.id,
            "userId":data.userId,
            "minutes":data.minutes,]
      ref.child(K.timeRecordsTable).child(data.id).setValue(datos) { error, dbReference in
            if let e = error {
                debugPrint("Error " + e.localizedDescription)
            }
        }
        
    }


    func transformDataFromInteractor() {
        self.transformWeatherDataFromInteractor(city:"Madrid")
        debugPrint(#function)
        debugPrint("User " + (user?.uid ?? "--No user--") )
        ref.child(K.timeRecordsTable)
            .queryOrdered(byChild: K.userIDKey)
            .queryEqual(toValue: user?.uid)
            .observe(DataEventType.value){ (users) in
                if let user = users.value as? [String:Any]{
                    self.timeRecords = []
                    debugPrint(user)
                    for object in user.values {
                        if let objectItem = object as? [String:Any]{
                            let mClockIn = objectItem["clockIn"] as? String
                            let mClockOut = objectItem["clockOut"] as? String
                            let mDay = objectItem["day"] as? String
                            let mId = objectItem["id"] as? String
                            let mMinutes = objectItem["minutes"] as? Int
                            let mUserId = objectItem["userId"] as? String
                            self.timeRecords.append(TimeRecord(id: mId ?? "",
                                                               userId: mUserId ?? "",
                                                               day: mDay ?? "",
                                                               clockIn: mClockIn ?? "",
                                                               clockOut: mClockOut ?? "",
                                                               minutes: mMinutes ?? 0))
                        }
                    }
                    self.presenter?.dataTransformedFromInteractor(data: self.timeRecords)
                }
                
            }
    }
    
    func saveLocalData(config:LocalConfig) {
        defaults.set(config.clockIn,forKey: K.clockInTime)
        defaults.set(config.clockOut,forKey: K.clockOutTime)
        defaults.set(config.clockedIn,forKey: K.clockedIn)
        defaults.set(config.day, forKey: K.currentDay)
    }
    
    func loadConfig() -> LocalConfig {
        let clockInTime = defaults.object(forKey: K.clockInTime) as? String ?? ""
        let clockOutTime = defaults.object(forKey: K.clockOutTime) as? String ?? ""
        let clockedIn = defaults.object(forKey: K.clockedIn) as? Bool ?? false
        let day = defaults.object(forKey: K.currentDay) as? String ?? ""
        return LocalConfig(day: day,
                           clockIn: clockInTime,
                           clockOut: clockOutTime,
                           clockedIn: clockedIn)
    }
    
    
}
