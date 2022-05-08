
import Foundation
import UIKit


//Input protocol
protocol AprobarCambioRouterInputProtocol{

}

final class AprobarCambioRouter: BaseRouter<AprobarCambioViewController> {
    var data:AprobarCambioCoordinatorDTO?
    
}

extension AprobarCambioRouter: AprobarCambioRouterInputProtocol {
    
}
