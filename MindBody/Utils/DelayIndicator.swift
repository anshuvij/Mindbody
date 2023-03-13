//
//  DelayIndicator.swift
//  MindBody
//
//  Created by Anshu Vij on 12/03/23.
//

import Foundation
import UIKit

public class DelayIndicator {
    
    var containerView = UIView()
    var progressView = UIView()
    var activityIndicator = UIActivityIndicatorView()

    
    public class var shared: DelayIndicator {
        struct Static {
            static let instance: DelayIndicator = DelayIndicator()
        }
        return Static.instance
    }
    
    var pinchImageView = UIImageView()
    
    public func showProgressView(uiView: UIView) {
        containerView.frame = CGRect(x: 0, y: 0, width: uiView.frame.width, height: uiView.frame.height)
        
        containerView.backgroundColor = UIColorFromHex(rgbValue: 0x000000, alpha: 0.3)
        
        let imageData = NSData(contentsOf: Bundle.main.url(forResource: "loader", withExtension: "gif")!)
        
        let animatedImage = UIImage.gifWithData(data: imageData!)
        pinchImageView = UIImageView(image: animatedImage)
        pinchImageView.frame = CGRect(x: 0.0, y: 0.0, width: 75.0, height: 75.0)

        progressView.frame = CGRect(x: 0, y: 0, width: (pinchImageView.frame.size.width), height: 60)
           
        progressView.center = uiView.center
        progressView.addSubview(pinchImageView)
        containerView.addSubview(progressView)
        uiView.addSubview(containerView)
    }
    
    public func hideProgressView() {
        
        activityIndicator.stopAnimating()
        pinchImageView.removeFromSuperview()
        activityIndicator.removeFromSuperview()
        progressView.removeFromSuperview()
        containerView.removeFromSuperview()
       
    }
    
    public func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
}
