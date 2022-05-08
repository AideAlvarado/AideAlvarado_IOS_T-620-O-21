
import Foundation
import Firebase
//Input del interactor
protocol SplashScreenInteractorInputProtocol {
    func getApiKeys()
}

final class SplashScreenInteractor: BaseInteractor<SplashScreenInteractorOutputProtocol> {
    var defaults = UserDefaults.standard
    let provider: SplashScreenProviderInputProtocol = SplashScreenProvider ()
}


//Input del interactor
extension SplashScreenInteractor: SplashScreenInteractorInputProtocol {
    func getApiKeys() {
//
        let remoteConfig = RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
        remoteConfig.fetch { (status,error) in
            remoteConfig.activate()
            let apiKey = remoteConfig.configValue(forKey: K.apiKey).stringValue ?? "-"
            self.defaults.set(apiKey, forKey: K.apiKey)
        }
        
    }
}
