import UIKit
import Swinject

protocol WireframeInterface: AnyObject {
}

class BaseWireframe<ViewController> where ViewController: UIViewController {

    private unowned var _viewController: ViewController
    
    // We need it in order to retain the view controller reference upon first access
    private var temporaryStoredViewController: ViewController?

    init(viewController: ViewController) {
        temporaryStoredViewController = viewController
        _viewController = viewController
    }

}

extension BaseWireframe: WireframeInterface {

}

extension BaseWireframe {
    
    var viewController: ViewController {
        defer { temporaryStoredViewController = nil }
        return _viewController
    }

    var navigationController: UINavigationController? {
        return viewController.navigationController
    }
    
    var tabBarController: UITabBarController? {
        return viewController.tabBarController
    }

}

extension UIViewController {
    
    func presentWireframe<ViewController>(_ wireframe: BaseWireframe<ViewController>, animated: Bool = true, completion: (() -> Void)? = nil) {
        present(wireframe.viewController, animated: animated, completion: completion)
    }

}

extension UINavigationController {
    
    func pushWireframe<ViewController>(_ wireframe: BaseWireframe<ViewController>, animated: Bool = true) {
        pushViewController(wireframe.viewController, animated: animated)
    }
    
    func setRootWireframe<ViewController>(_ wireframe: BaseWireframe<ViewController>, animated: Bool = true) {
        setViewControllers([wireframe.viewController], animated: animated)
    }

}

extension UITabBarController {
    func setWireframes(_ wireframes: [TabBarViewType]) {
        var viewControllers = [UIViewController]()
        for wireframe in wireframes {
            let tabBarItem = UITabBarItem()
            tabBarItem.image = wireframe.tabIcon
            tabBarItem.title = wireframe.tabTitle
            
            let navigationController = UINavigationController(rootViewController: wireframe.tabView)
            navigationController.tabBarItem = tabBarItem
            
            viewControllers.append(navigationController)
        }
        self.viewControllers = viewControllers
    }
}
