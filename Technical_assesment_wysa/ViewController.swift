//
//  ViewController.swift
//  Technical_assesment_wysa
//
//  Created by Sarvad Shetty on 18/03/2021.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - @IBOutlets
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - Properties
    private var originalBounds: CGRect = .zero
    private var originalCenter: CGPoint = .zero
    
    // MARK: - UIKit dynamics properties
    private var animator: UIDynamicAnimator!
    private var attachmentBehaviour: UIAttachmentBehavior!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        animatorSetup()
    }

    // MARK: - @IBActions
    /// handling image drag
    @IBAction func handleAttachmentGesture(sender: UIPanGestureRecognizer) {
        let location = sender.location(in: self.view)
        let boxLocation = sender.location(in: self.imageView)
        
        switch sender.state {
        case .began:
            
            // adding properties to animator
            animator.removeAllBehaviors()
            
            // finding offset between tap on screen location and original imageview location
            let centerOffset = UIOffset(horizontal: boxLocation.x - imageView.bounds.midX, vertical: boxLocation.y - imageView.bounds.midY)
            // creating an anchor on the location the user has tapped on screen
            attachmentBehaviour = UIAttachmentBehavior(item: imageView, offsetFromCenter: centerOffset, attachedToAnchor: location)
            
            animator.addBehavior(attachmentBehaviour)
        
        case .ended:
            reset()
            
        default:
            attachmentBehaviour.anchorPoint = sender.location(in: self.view)
        }
    }
    
    // MARK: - Functions
    /// view controller’s view will be the reference view which defines the coordinate system for the animator.
    func animatorSetup() {
        animator = UIDynamicAnimator(referenceView: view)
        imageView.center = view.center
        originalBounds = imageView.bounds
        originalCenter = view.center
    }
    
    /// resets to original position after drag ends, with animation
    func reset() {
        animator.removeAllBehaviors()

        UIView.animate(withDuration: 0.45) {
            self.imageView.bounds = self.originalBounds
            self.imageView.center = self.originalCenter
            self.imageView.transform = CGAffineTransform.identity
        }
    }
    
}

