import UIKit

func showAlert(forViewController vc: UIViewController, title: String?, message: String?, andActions actions: [UIAlertAction]) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
    actions.forEach { (action) in
        alertController.addAction(action)
    }

    vc.present(alertController, animated: true, completion: nil)
}

func showOkCancelAlert(forViewController vc: UIViewController, title: String?, message: String?) {
    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    
    showAlert(forViewController: vc, title: title, message: message, andActions: [cancelAction, okAction])
}

func showOkAlert(forViewController vc: UIViewController, title: String?, message: String?, handler: ((UIAlertAction) -> Swift.Void)? = nil) {
    let okAction = UIAlertAction(title: "OK", style: .default, handler: handler)
    
    showAlert(forViewController: vc, title: title, message: message, andActions: [okAction])
}
