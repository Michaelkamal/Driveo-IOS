//
//  CreateRequestView.swift
//  Driveo
//
//  Created by Admin on 6/4/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import UIKit
import BeautifulTextField

class CreateRequestView: UIViewController, CreateRequestViewProtocol ,UIGestureRecognizerDelegate  {

    lazy var presenter:CreateRequestPresenterProtocol = CreateRequestPresenter(withView:self)
    var spinner:UIView?
    var alert:UIAlertController?
    var chooseImageProviderAlert:UIAlertController?
    var deleteImageAlert:UIAlertController?
    var imagePickerController:UIImagePickerController?
    var images:[UIImage] = [UIImage.init(named: "ic_upload_image")!]
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var titleTextField: BaseBeautifulTextField!
    @IBOutlet weak var collectionViewWidth: NSLayoutConstraint!
    
    @IBOutlet weak var uploadImageCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let longPressOnCellGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        longPressOnCellGesture.minimumPressDuration = 0.5
        longPressOnCellGesture.delaysTouchesBegan = true
        longPressOnCellGesture.delegate = self
        self.uploadImageCollectionView.addGestureRecognizer(longPressOnCellGesture)
    }

    @objc func handleLongPress(gestureReconizer: UILongPressGestureRecognizer) {
        if gestureReconizer.state != UIGestureRecognizerState.ended {
            return
        }
        let point = gestureReconizer.location(in: self.uploadImageCollectionView)
        let indexPath = self.uploadImageCollectionView.indexPathForItem(at: point)
        
        if let index = indexPath {
            var cell = self.uploadImageCollectionView.cellForItem(at: index)
            // do stuff with your cell, for example print the indexPath
            if   index.row < (images.count-1){
                presenter.deletePhotoAlert(withindex: index.row)
            }
        } else {
            //longpress outside collection view
            print("out \n")
        }
    }
    
    
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        var sendImagesArray:[UIImage] = images
        sendImagesArray.remove(at: sendImagesArray.count-1)
        presenter.createRequestclicked(withTitle: titleTextField.text!, withDescription: descriptionTextView.text, withImages:sendImagesArray)
    }
    
    
    func deletePhoto(atIndex index: Int) {
        images.remove(at: index)
        uploadImageCollectionView.reloadData()
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

