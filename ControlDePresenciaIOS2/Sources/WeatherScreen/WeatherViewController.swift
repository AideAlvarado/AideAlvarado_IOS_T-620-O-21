//PFM


import UIKit

//Output del Presenter
protocol WeatherPresenterOutputProtocol {
    func reloadInformationInView()
}

class WeatherViewController: BaseView<WeatherPresenterInputProtocol> {
    //MARK: - Variables globales
    
    //MARK: - IBOutlets
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }

}


//OUTPUT del presenter
extension WeatherViewController: WeatherPresenterOutputProtocol {

    func reloadInformationInView() {
        
    }
}
