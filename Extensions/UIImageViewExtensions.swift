import UIKit

extension UIImageView {
    
    
    
    static func sensorImage(fromString inputString: String, withPlaceholderImage placeHolder: UIImage) -> UIImage {
        
        if let firstChacter = inputString.lowercased().first {
            let trimmedSensorName = inputString.lowercased().removingWhitespaces()
            
            let something = sensorTitleToImageMap.keys.filter { (key) -> Bool in
                trimmedSensorName.contains(key)
            }

            return sensorTitleToImageMap[something.first ?? ""] ?? UIImage(named: "\(firstChacter)") ?? placeHolder
        }
        
        return placeHolder
    }
}

let sensorTitleToImageMap = ["backdoor" : #imageLiteral(resourceName: "backdoor-icon"),
                             "bathroom" : #imageLiteral(resourceName: "bathroom-icon"),
                             "bedroom": #imageLiteral(resourceName: "bedroom-icon"),
                             "den": #imageLiteral(resourceName: "den-icon"),
                             "diningroom": #imageLiteral(resourceName: "diningroom-icon"),
                             "frontdoor": #imageLiteral(resourceName: "frontdoor-icon"),
                             "garagedoor": #imageLiteral(resourceName: "garagedoor-icon"),
                             "gateway": #imageLiteral(resourceName: "gateway-icon"),
                             "hallway": #imageLiteral(resourceName: "hallway-icon"),
                             "kitchen": #imageLiteral(resourceName: "kitchen-icon"),
                             "livingroom": #imageLiteral(resourceName: "livingroom-icon"),
                             "slider": #imageLiteral(resourceName: "slidingdoor-icon"),
                             "staircase": #imageLiteral(resourceName: "stairs-icon"),
                             "temperature": #imageLiteral(resourceName: "temperature-icon")]
