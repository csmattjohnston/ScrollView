//
//  ViewController.swift
//  ScrollView
//
//  Created by Matt Foo on 9/19/17.
//  Copyright © 2017 Matt Foo. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    var images = [UIImageView]()
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let leftGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        leftGesture.direction = .left
        view.addGestureRecognizer(leftGesture)
        
        let rightGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        rightGesture.direction = .right
        view.addGestureRecognizer(rightGesture)
    }
    
    func handleSwipe(sender:UISwipeGestureRecognizer){
        
        let direction = sender.direction.rawValue //2 for right, 1 for left
        let scrollWidth = scrollView.frame.size.width //220
        let scrollHeight = scrollView.frame.size.height
        let leftEdgeOfScrollView = scrollView.bounds.minX

        
        //right
        if direction == 2 {
            scrollView.scrollRectToVisible(CGRect(x:leftEdgeOfScrollView + scrollWidth,y:scrollHeight / 2,width: scrollWidth, height:scrollHeight ), animated: true)
        }else{
            scrollView.scrollRectToVisible(CGRect(x:leftEdgeOfScrollView - scrollWidth,y:scrollHeight / 2,width: scrollWidth, height:scrollHeight ), animated: true)
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        var contentWidth: CGFloat = 0.0
        
        //size of scroll width
        let scrollWidth = scrollView.frame.size.width //220
  
        //Since we know the size of the scroll width, we can set the mid outisde of the for loop.
        //This is the same for each iteration
        let midOfScrollWidth = scrollWidth / 2 //110
        
        //store dimensions in constants
        let imageDimensions: CGFloat = 150
        let imageDimensionOffset: CGFloat = imageDimensions / 2
        
        //there are a total of 3 images
        for x in  0...2 {
            //load images from assets
            let image = UIImage(named:"icon\(x).png")
            //create an image view with that image
            let imageView = UIImageView(image:image)
            //add images to image view array
            images.append(imageView)
            
            //initialize x coordiante
            var newX: CGFloat = 0.0

            //add SCROLL WIDTH to  the  current content width
            //contentWdith: 220, 440, 660
            contentWidth += scrollWidth
            
            //The mid will always be the same for each iteration since the content width stays the same size.
            //only need to subtract the mid from the current content width
            //newX: 110, 330, 550
            newX = contentWidth - midOfScrollWidth

            //add imageview to scrollview
            scrollView.addSubview(imageView)
            
            //since the image height is 150px and view coorindates start at the top left corner, the x corrdinate must have an offset of 1/2
            imageView.frame = CGRect(x: newX - imageDimensionOffset, y: (scrollView.frame.size.height / 2) - imageDimensionOffset, width: imageDimensions, height: imageDimensions)
        }
        
        scrollView.clipsToBounds = false
        scrollView.contentSize = CGSize(width: contentWidth, height: view.frame.size.height)
 
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

