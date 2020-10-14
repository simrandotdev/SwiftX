extension UIView {
    func pulsate() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.6
        pulse.fromValue = 0.95
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.repeatCount = 2
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        
        layer.add(pulse, forKey: nil)
    }
    
    func flash() {
        let flash = CASpringAnimation(keyPath: "opacity")
        flash.duration = 0.5
        flash.fromValue = 1.0
        flash.toValue = 0.1
        flash.autoreverses = true
        flash.repeatCount = 3
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        
        layer.add(flash, forKey: nil)
    }
    
    func shake() {
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.1
        shake.repeatCount = 2
        shake.autoreverses = true
        
        let fromPoint = CGPoint(x: center.x - 5, y: center.y)
        let fromValue = NSValue(cgPoint: fromPoint)
        
        let toPoint = CGPoint(x: center.x + 5, y: center.y)
        let toValue = NSValue(cgPoint: toPoint)
        
        shake.fromValue = fromValue
        shake.toValue = toValue
        
        layer.add(shake, forKey: nil)
    }
    
    
    /// Helps to chain animation calls without nested closure.
    /// Just remember to set totalDuration = 0 in the last call in the chain.
    static var totalDuration: TimeInterval = 0
    func animation(withDuration duration: TimeInterval,
                   options: UIView.AnimationOptions = UIView.AnimationOptions.allowUserInteraction,
                   completion: @escaping () -> Void) -> UIView {
        
        UIView.totalDuration += duration
        UIView.animate(withDuration: duration, delay: UIView.totalDuration, options: options, animations: completion, completion: nil)
        
        return self
    }
}
