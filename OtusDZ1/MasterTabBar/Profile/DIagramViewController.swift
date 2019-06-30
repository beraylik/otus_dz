//
//  DIagramViewController.swift
//  OtusDZ1
//
//  Created by Генрих Берайлик on 06/06/2019.
//  Copyright © 2019 Генрих Берайлик. All rights reserved.
//

import UIKit

// MARK: - Behavior

final class InfinityScrollBehavior: ViewControllerLifecycleBehavior {
    
    private var delegate: InfinityScrollable
    
    init(delegate: InfinityScrollable) {
        self.delegate = delegate
    }
    
    // MARK: - Life cycle
    
    func afterLoading(_ viewController: UIViewController) {
        
        addImageViews()
    }
    
    func afterLayingOutSubviews(_ viewController: UIViewController) {
        delegate.scrollViewSize = delegate.scrollView.frame
        delegate.scrollView.contentSize = CGSize(width: delegate.scrollViewSize.width*3,
                                                 height: delegate.scrollViewSize.height)
        delegate.scrollView.contentOffset = CGPoint(x: delegate.scrollViewSize.width, y: 0)
        delegate.layoutImages()
    }
    
    // MARK: - API
    
    func addImageViews() {
        (0..<3).forEach { (i) in
            if let image = Services.diagramImageProvider.random() {
                delegate.images.append(image)
                delegate.imageViews[i].image = image
                delegate.scrollView.addSubview(delegate.imageViews[i])
            }
            
        }
    }
    
}


protocol InfinityScrollable {
    
    var images: [UIImage] { get set }
    var imageViews: [UIImageView] { get }
    
    var scrollView: UIScrollView! { get }
    var scrollViewSize: CGRect { get set }
    
    func layoutImages()
    
}

// MARK: - View Controller

final class DIagramViewController: UIViewController, InfinityScrollable {

    var images = [UIImage]()
    lazy var imageViews: [UIImageView] = {
        let imageViews = [
            UIImageView(frame: .zero),
            UIImageView(frame: .zero),
            UIImageView(frame: .zero),
        ]
        imageViews.forEach({ (imageView) in
            imageView.contentMode = .scaleAspectFit
        })
        return imageViews
    }()
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var dragging: Bool = false
    var scrollViewSize: CGRect = .zero
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addBehaviors(behaviors: [InfinityScrollBehavior(delegate: self)])
    }
    
    // MARK: - API
    
    func layoutImages() {
        imageViews.enumerated().forEach { (index: Int, element: UIImageView) in
            element.image = images[index]
            element.frame = CGRect(x: scrollViewSize.width * CGFloat(index),
                                   y: 0,
                                   width: scrollViewSize.width,
                                   height: scrollViewSize.height)
        }
        
    }
    
}

// MARK: - Scroll view delegate

extension DIagramViewController: UIScrollViewDelegate {
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        dragging = false
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        dragging = true
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !dragging {
            return
        }
        
        let offsetX = scrollView.contentOffset.x
        
        // Right
        if offsetX > (scrollView.frame.size.width*1.5) {
            if let newImage = Services.diagramImageProvider.random() {
                images.remove(at: 0)
                images.append(newImage)
                layoutImages()
                scrollView.contentOffset.x -= scrollViewSize.width
            }
        }
        
        // Left
        if offsetX < (scrollView.frame.size.width*0.5) {
            if let newImage = Services.diagramImageProvider.random() {
                images.removeLast()
                images.insert(newImage, at: 0)
                layoutImages()
                scrollView.contentOffset.x += scrollViewSize.width
            }
        }
    }
}
