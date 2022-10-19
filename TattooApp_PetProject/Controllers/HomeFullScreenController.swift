//
//  HomeFullScreenController.swift
//  TattooApp_PetProject
//
//  Created by Поляндий on 19.10.2022.
//

import UIKit

class HomeFullScreenController: UIViewController, UIScrollViewDelegate {

    var selectedIndex: Int = 0
    var myImageArray: [MyCustomData] = []
    
    private var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.contentMode = .scaleAspectFit
        sv.showsVerticalScrollIndicator = false
        sv.showsHorizontalScrollIndicator = true
        sv.backgroundColor = .black
        sv.minimumZoomScale = 1
        sv.maximumZoomScale = 6
        return sv
    }()
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        
        view.backgroundColor = .black
        view.addSubview(scrollView)
        
        scrollView.delegate = self
        scrollView.addSubview(imageView)
        
        setupConstraints()
        setupGesture()
        loadImage()
    }
    
    private func setupConstraints() {
        scrollView.frame = view.bounds
        imageView.frame = scrollView.bounds
    }
    
    private func loadImage() {
        imageView.image = myImageArray[selectedIndex].image
    }
    
    //MARK: - UIGesture (Zoom)
    
    private func setupGesture() {
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTapOnScrollView(recognizer: )))
        doubleTapGesture.numberOfTapsRequired = 2
        scrollView.addGestureRecognizer(doubleTapGesture)
        
//        let rightSwipe: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeFrom(recognizer:)))
//        let leftSwipe: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeFrom(recognizer:)))
//        
//        rightSwipe.direction = .right
//        leftSwipe.direction = .left
//        
//        scrollView.addGestureRecognizer(rightSwipe)
//        scrollView.addGestureRecognizer(leftSwipe)
    }
    
//    @objc func handleSwipeFrom(recognizer: UISwipeGestureRecognizer) {
//        let direction: UISwipeGestureRecognizer.Direction = recognizer.direction
//        
//        switch direction{
//        case UISwipeGestureRecognizer.Direction.right:
//            self.selectedIndex -= 1
//        case UISwipeGestureRecognizer.Direction.left:
//            self.selectedIndex += 1
//        default:
//            break
//        }
//        self.selectedIndex = (self.selectedIndex < 0) ? (self.myImageArray.count - 1) : self.selectedIndex % self.myImageArray.count
//        loadImage()
//    }
    
    @objc func handleDoubleTapOnScrollView(recognizer: UITapGestureRecognizer ) {
        if scrollView.zoomScale == 1{
            scrollView.zoom(to: zoomRectForScale(scale: scrollView.maximumZoomScale, center: recognizer.location(in: recognizer.view)), animated: true)
            self.navigationController?.navigationBar.isHidden = true
        } else {
            scrollView.setZoomScale(1, animated: true)
            self.navigationController?.navigationBar.isHidden = false
        }
    }
    
    private func zoomRectForScale(scale: CGFloat, center: CGPoint) -> CGRect {
        var zoomRect = CGRect.zero
        zoomRect.size.height = imageView.frame.size.height / scale
        zoomRect.size.width = imageView.frame.size.width / scale

        let newCenter = imageView.convert(center, from: scrollView)
        zoomRect.origin.x = newCenter.x - (zoomRect.size.width / 2.0)
        zoomRect.origin.y = newCenter.y - (zoomRect.size.height / 2.0)
        
        return zoomRect
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        if scrollView.zoomScale > 1 {
            if let image = imageView.image {
                let ratioWidth = imageView.frame.width / image.size.width
                let ratioHeight = imageView.frame.height / image.size.height
                
                let ratio = ratioWidth < ratioHeight ? ratioWidth : ratioHeight
                
                let newWidth = image.size.width * ratio
                let newHeight = image.size.height * ratio
                
                let left = 0.5 * (newWidth * scrollView.zoomScale > imageView.frame.width ? (newWidth - imageView.frame.width) : (scrollView.frame.width - scrollView.contentSize.width))
                let top = 0.5 * (newHeight * scrollView.zoomScale > imageView.frame.height ? (newHeight - imageView.frame.height) : (scrollView.frame.height - scrollView.contentSize.height))
                
                scrollView.contentInset = UIEdgeInsets(top: top, left: left, bottom: top, right: left)
            }
        } else {
            scrollView.contentInset = UIEdgeInsets.zero
        }
    }
}
