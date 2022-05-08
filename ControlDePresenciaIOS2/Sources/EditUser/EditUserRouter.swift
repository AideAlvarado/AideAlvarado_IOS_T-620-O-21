
import Foundation
import UIKit


//Input protocol
protocol EditUserRouterInputProtocol{

}

final class EditUserRouter: BaseRouter<EditUserViewController> {
    var data:EditUserCoordinatorDTO?
}

extension EditUserRouter: EditUserRouterInputProtocol {
    
}
