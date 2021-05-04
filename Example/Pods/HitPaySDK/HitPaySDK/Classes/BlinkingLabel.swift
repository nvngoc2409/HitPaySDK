//
//  BlinkingLabel.swift
//  HitPaySDK
//
//  Created by apple on 4/28/21.
//

public class BlinkingLabel : UILabel {
    public func startBlinking() {
        let options : UIView.AnimationOptions = .repeat
        UIView.animate(withDuration: 0.25, delay: 0.0, options: options) {
            self.alpha = 0
        } completion: { (finish) in
            
        }
    }
 
    public func stopBlinking() {
        alpha = 1
        layer.removeAllAnimations()
    }
}
