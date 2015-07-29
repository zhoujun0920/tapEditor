//
//  ViewController.swift
//  tapEditor
//
//  Created by Jun Zhou on 7/23/15.
//  Copyright (c) 2015 Jun Zhou. All rights reserved.
//

import UIKit


class ViewController: UIViewController, RAReorderableLayoutDelegate, RAReorderableLayoutDataSource {

    var collection: [String] = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15","16", "17", "18", "19", "20"]
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let nib = UINib(nibName: "verticalCell", bundle: nil)
        self.collectionView.registerNib(nib, forCellWithReuseIdentifier: "cell")
        self.collectionView.backgroundView?.backgroundColor = UIColor(patternImage: UIImage(named: "background.png")!)
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.collectionView.contentInset = UIEdgeInsetsMake(self.topLayoutGuide.length, 0, 0, 0)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let screenWidth = CGRectGetWidth(UIScreen.mainScreen().bounds)
        let fourPiecesWidth = floor(screenWidth / 4.0 - ((3.0 / 4) * 3))
        return CGSizeMake(fourPiecesWidth, fourPiecesWidth)
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell: RACollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("verticalCell", forIndexPath: indexPath) as! RACollectionViewCell
         cell.button.setTitle(collection[indexPath.item], forState: UIControlState.Normal)
        
        return cell
    }
    
    // RAReorderableLayout delegate datasource
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 2.0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 2.0
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 2.0, 0)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.collection.count
    }
    
    func collectionView(collectionView: UICollectionView, allowMoveAtIndexPath indexPath: NSIndexPath) -> Bool {
        if collectionView.numberOfItemsInSection(indexPath.section) <= 1 {
            return false
        }
        return true
    }
    
    func collectionView(collectionView: UICollectionView, atIndexPath: NSIndexPath, didMoveToIndexPath toIndexPath: NSIndexPath) {
        var number: String
        number = self.collection.removeAtIndex(atIndexPath.item)
        self.collection.insert(number, atIndex: toIndexPath.item)
    }
    
    func scrollTrigerEdgeInsetsInCollectionView(collectionView: UICollectionView) -> UIEdgeInsets {
        return UIEdgeInsetsMake(100.0, 100.0, 100.0, 100.0)
    }
    
    func collectionView(collectionView: UICollectionView, reorderingItemAlphaInSection section: Int) -> CGFloat {
        return 0.5
    }
    
    func scrollTrigerPaddingInCollectionView(collectionView: UICollectionView) -> UIEdgeInsets {
        return UIEdgeInsetsMake(self.collectionView.contentInset.top, 0, self.collectionView.contentInset.bottom, 0)
    }
}

class RACollectionViewCell: UICollectionViewCell {
    var imageView: UIImageView!
    var button: UIButton!
    var gradientLayer: CAGradientLayer?
    var hilightedCover: UIView!
    
   
    override var highlighted: Bool {
        didSet {
            self.hilightedCover.hidden = !self.highlighted
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configure()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.imageView.frame = self.bounds
        let side = self.bounds.height
        self.button.frame = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, side, side)
        self.button.layer.cornerRadius = 0.5 * button.bounds.size.width
        self.button.layer.borderWidth = 1
        self.hilightedCover.frame = self.bounds
        self.applyGradation(self.imageView)
        self.applyGradation(self.button)
    }
    
    private func configure() {
        self.button = UIButton()
        self.button.autoresizingMask = .FlexibleWidth | .FlexibleHeight
        self.button.contentMode = UIViewContentMode.ScaleAspectFill
        self.button.addTarget(self, action: "pressButton:", forControlEvents: UIControlEvents.TouchUpInside)
        self.button.addTarget(self, action: "changeButtonColor:", forControlEvents: UIControlEvents.TouchDown)
        self.button.addTarget(self, action: "rechangeButtonColor:", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(self.button)
        
        self.imageView = UIImageView()
        self.imageView.autoresizingMask = .FlexibleWidth | .FlexibleHeight
        self.imageView.contentMode = UIViewContentMode.ScaleAspectFill
//        self.addSubview(self.imageView)
        
        self.hilightedCover = UIView()
        self.hilightedCover.autoresizingMask = .FlexibleWidth | .FlexibleHeight
        self.hilightedCover.backgroundColor = UIColor(white: 0, alpha: 0.5)
        self.hilightedCover.hidden = true
        self.addSubview(self.hilightedCover)
    }
    
    private func applyGradation(gradientView: UIView!) {
        self.gradientLayer?.removeFromSuperlayer()
        self.gradientLayer = nil
        
        self.gradientLayer = CAGradientLayer()
        self.gradientLayer!.frame = gradientView.bounds
        self.gradientLayer?.cornerRadius = 0.5 * gradientView.bounds.size.width
        
        let mainColor = UIColor(white: 0, alpha: 0.3).CGColor
        let subColor = UIColor.clearColor().CGColor
        self.gradientLayer!.colors = [subColor, mainColor]
        self.gradientLayer!.locations = [0, 1]
        
        gradientView.layer.addSublayer(self.gradientLayer)
    }
    
    func pressButton(sender: UIButton) {
        var storyboard = UIStoryboard(name: "Main", bundle: nil)
        //let viewController = storyboard.instantiateViewControllerWithIdentifier("viewController") as! ViewController
        let tabPickerView = storyboard.instantiateViewControllerWithIdentifier("tabPicker") as! tabPickerViewViewController
        var viewController = window?.rootViewController
        viewController!.presentViewController(tabPickerView, animated: true, completion: nil)
        println("Press Button")
//        tabPickerView.transitioningDelegate = self
//        presentViewController(tabPickerView, animated: true, completion: nil)
//
        
    }
    
    func changeButtonColor(sender: UIButton) {
        UIView.animateWithDuration(0.15, animations: {
            sender.backgroundColor = UIColor.blackColor()
            sender.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        })
    }
    
    func rechangeButtonColor(sender:UIButton) {
        UIView.animateWithDuration(0.15, animations: {
            sender.backgroundColor = UIColor.whiteColor()
            sender.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        })
    }
}
