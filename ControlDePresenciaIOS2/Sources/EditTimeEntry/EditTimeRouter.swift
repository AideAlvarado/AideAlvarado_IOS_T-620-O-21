
import Foundation
import UIKit


//Input protocol
protocol EditTimeRouterInputProtocol{

}

final class EditTimeRouter: BaseRouter<EditTimeViewController> {
    var data:EditTimeCoordinatorDTO?
}

extension EditTimeRouter: EditTimeRouterInputProtocol {
    
}
