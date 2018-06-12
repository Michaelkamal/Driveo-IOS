//
//  NavigationDrawerViewController.swift
//  Driveo
//
//  Created by Admin on 6/12/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import UIKit

enum NavigationDrawerOptions:Int {
    case trips
    case editProfile
    case chagePassword
    case logout
    
    internal static var caseCount: Int {
        var count = 0
        while let _ = self.init(rawValue: count) {
            count += 1
        }
        return count
    }
    var description : String {
        get {
            switch(self) {
            case .trips:
                return "Trips"
            case .editProfile:
                return "Edit profile"
            case .chagePassword:
                return "Change password"
            case .logout:
                return "Logout"
            
            }
        }
    }
}

class NavigationDrawerViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var profilePicture: UIImageView!
    @IBAction func didTapOnCloseButton(_ sender: UIButton) {
        dismissToLeft()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profilePicture.addTapGesture(tapNumber: 1, target: self, action: #selector(ImageProviderAlert))
        if(CGFloat(NavigationDrawerOptions.caseCount) * tableView.rowHeight > tableView.frame.height)
        {
            tableView.isScrollEnabled=true
        }
        else
        {
            tableView.isScrollEnabled=false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
extension NavigationDrawerViewController: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NavigationDrawerOptions.caseCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NavigationDrawerTableViewCell")
        as! NavigationDrawerTableViewCell
        
        
        if let option = NavigationDrawerOptions.init(rawValue: indexPath.row){
        cell.optionLabel.text=option.description
            if (option.description == "Logout"){
            cell.moreImage.isHidden=true
            }else{
                cell.moreImage.isHidden=false
            }
            switch option{
            case .trips:
                
                cell.view.addTapGesture(tapNumber: 1, target: self, action: #selector(pushTrips))
            case .editProfile:
                cell.view.addTapGesture(tapNumber: 1, target: self, action: #selector(pushEditProfile))
            case .chagePassword:
                
                cell.view.addTapGesture(tapNumber: 1, target: self, action: #selector(pushChangePassword))
            case .logout:
                
                cell.view.addTapGesture(tapNumber: 1, target: self, action: #selector(logout))
            
            }
        }
        return cell
    }
   
    @objc func pushTrips(){
        
        print("Trips ")
    }
    
    @objc func pushEditProfile(){
        print("EditProfile ")
    }
    @objc func pushChangePassword(){
        
        print("Change PW ")
    }
    @objc func logout(){
        
        print("Logout ")
    }
    
}
extension NavigationDrawerViewController{
    
    @objc func ImageProviderAlert(){
        
        let chooseImageProviderAlert = UIAlertController.init(title: "", message:nil, preferredStyle: .actionSheet)
        
        let photoFromGallery:UIAlertAction = UIAlertAction.init(title: "Gallery", style: .default, handler: {(alert: UIAlertAction!) in
            self.getPhotoFromGallery()
        })
        
        let photoFromCamera:UIAlertAction = UIAlertAction.init(title: "Recapture", style: .default, handler: {(alert: UIAlertAction!) in
            self.getPhotoFromCamera()
        })
        
        let cancelAction:UIAlertAction = UIAlertAction.init(title: "Delete", style: .cancel, handler: {(alert: UIAlertAction!) in
            // TODO : delete user image
            self.profilePicture.image=#imageLiteral(resourceName: "ic_user")
        })
        chooseImageProviderAlert.addAction(photoFromCamera)
        chooseImageProviderAlert.addAction(photoFromGallery)
        chooseImageProviderAlert.addAction(cancelAction)
        
        present(chooseImageProviderAlert, animated: true, completion: nil)
    }
    
    //create Image Picker Controller for Gallery
    func getPhotoFromGallery() {
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = .photoLibrary
        self.present(controller, animated: true, completion: nil)
    }
    
    
    //create Image Picker Controller for Camera
    func getPhotoFromCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .camera
            picker.allowsEditing = false
            picker.sourceType = UIImagePickerControllerSourceType.camera
            picker.cameraCaptureMode = .photo
            picker.modalPresentationStyle = .fullScreen
            
            self.present(picker, animated: true, completion: nil)
        } else {
          //  showAlert(withTitle: "No Camera", withMsg: "No Camera or Permission is Needed")
        }
    }
}

extension NavigationDrawerViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            dismiss(animated: true, completion: nil)
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
            if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
          profilePicture.image=image
            }
            dismiss(animated: true, completion: nil)
        }
}
