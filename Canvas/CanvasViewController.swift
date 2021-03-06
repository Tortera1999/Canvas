//
//  CanvasViewController.swift
//  Canvas
//
//  Created by Nikhil Iyer on 2/21/18.
//  Copyright © 2018 Nikhil Iyer. All rights reserved.
//

import UIKit

var trayOriginalCenter: CGPoint!
var newlyCreatedFaceOriginalCenter: CGPoint!

class CanvasViewController: UIViewController {

    @IBOutlet weak var trayView: UIView!
    var trayDownOffset: CGFloat!
    var trayUp: CGPoint!
    var trayDown: CGPoint!
    var newlyCreatedFace: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        trayDownOffset = 240
        trayUp = trayView.center
        trayDown = CGPoint(x: trayView.center.x ,y: trayView.center.y + trayDownOffset)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didPanTray(_ sender: UIPanGestureRecognizer) {
        
        let translation = sender.translation(in: view)
        
        if(sender.state == UIGestureRecognizerState.began){
            trayOriginalCenter = trayView.center
        }
        else if(sender.state == UIGestureRecognizerState.changed){
            trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
        }
        else if(sender.state == UIGestureRecognizerState.ended){
            var velocity = sender.velocity(in: view)
            
            if(velocity.y > 0){
                UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options:[] , animations: { () -> Void in
                    self.trayView.center = self.trayDown
                }, completion: nil)
                
                
            }
            else{
                UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options:[] , animations: { () -> Void in
                    self.trayView.center = self.trayUp
                }, completion: nil)
                

            }
        }
        
    }

    @IBAction func didPanFace(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        if(sender.state == UIGestureRecognizerState.began){
            var imageView = sender.view as! UIImageView
            newlyCreatedFace = UIImageView(image: imageView.image)
            view.addSubview(newlyCreatedFace)
            newlyCreatedFace.center = imageView.center
            newlyCreatedFace.center.y += trayView.frame.origin.y
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center
            newlyCreatedFace.isUserInteractionEnabled = true
            let tapGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(didTap(_:)))
            newlyCreatedFace.addGestureRecognizer(tapGestureRecognizer)
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center
            
        }
        else if(sender.state == UIGestureRecognizerState.changed){
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)
        }
        else if(sender.state == UIGestureRecognizerState.ended){
            
        }
    }
    
    @IBAction func didTap(_ sender: UIPanGestureRecognizer) {
        print("Sdasds")
        
        let translation = sender.translation(in: view)
        if sender.state == .began {
            newlyCreatedFace = sender.view as! UIImageView
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center
        }
        else if sender.state == .changed {
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)
        }
        else if sender.state == .ended {
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
