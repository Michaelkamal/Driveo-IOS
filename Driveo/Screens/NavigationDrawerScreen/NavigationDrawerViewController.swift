//
//  NavigationDrawerViewController.swift
//  Driveo
//
//  Created by Admin on 6/12/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import UIKit
import SDWebImage
enum NavigationDrawerOptions:Int {
    case trips
    case editProfile
    case chagePassword
    case logout
    case about
    
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
                return "My orders"
            case .editProfile:
                return "Edit profile"
            case .chagePassword:
                return "Change password"
            case .logout:
                return "Logout"
            case .about:
                return "About"
            }
        }
    }
}

class NavigationDrawerViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBAction func didTapOnCloseButton(_ sender: UIButton) {
        popToLeft()
    }
    private lazy var user = UserDAL.sharedInstance().getUser()
    override func viewDidLoad() {
        super.viewDidLoad()
      //  profilePicture.sd_setImage(with: URL(string:(user?.avatar?.url)!), completed: nil)
        if let userName=user?.name{
             self.userName.text=userName
        }else{
             self.userName.text=user?.email
        }
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
            if (option.description == "Logout" || option.description == "About" ){
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
            
            case .about:
                
                cell.view.addTapGesture(tapNumber: 1, target: self, action: #selector(pushAbout))
            }
        }
        return cell
    }
   
    @objc func pushTrips(){
        let screen = ScreenController.tripsScreen;
        let destinationStoryboard = UIStoryboard(name: screen.storyBoardName(), bundle: nil)
        let vc = destinationStoryboard.instantiateViewController(withIdentifier: screen.rawValue)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func pushEditProfile(){
        let screen = ScreenController.editProfileScreen;
        let destinationStoryboard = UIStoryboard(name: screen.storyBoardName(), bundle: nil)
        let vc = destinationStoryboard.instantiateViewController(withIdentifier: screen.rawValue)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func pushChangePassword(){
        let screen = ScreenController.changePasswordScreen;
        let destinationStoryboard = UIStoryboard(name: screen.storyBoardName(), bundle: nil)
        let vc = destinationStoryboard.instantiateViewController(withIdentifier: screen.rawValue)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func pushAbout(){
        let screen = ScreenController.aboutScreen;
        let destinationStoryboard = UIStoryboard(name: screen.storyBoardName(), bundle: nil)
        let vc = destinationStoryboard.instantiateViewController(withIdentifier: screen.rawValue)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func logout(){
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey :"auth_token")
        defaults.removeObject(forKey :"verified")
        defaults.synchronize()
        let screen = ScreenController.loginScreen;
        let destinationStoryboard = UIStoryboard(name: screen.storyBoardName(), bundle: nil)
        let vc = destinationStoryboard.instantiateViewController(withIdentifier: screen.rawValue)
        vc.modalTransitionStyle = .crossDissolve
        self.navigationController?.viewControllers.removeAll()
        self.present(vc, animated: true, completion: nil)
        UIApplication.shared.keyWindow?.rootViewController = vc
        
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
        
        let deleteAction:UIAlertAction = UIAlertAction.init(title: "Delete", style: .default, handler: {(alert: UIAlertAction!) in
            self.profilePicture.image=#imageLiteral(resourceName: "ic_user")
            self.changeImage(image:#imageLiteral(resourceName: "ic_user"))
        })
        let cancelAction:UIAlertAction = UIAlertAction.init(title: "cancel", style: .cancel, handler: nil)
        chooseImageProviderAlert.addAction(photoFromCamera)
        chooseImageProviderAlert.addAction(photoFromGallery)
        chooseImageProviderAlert.addAction(deleteAction)
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
                
                self.changeImage(image:image)
            }
            dismiss(animated: true, completion: nil)
        }
}
extension NavigationDrawerViewController {
    
    func changeImage(image:UIImage){
        let model = NetworkDAL.sharedInstance()
        let defaults = UserDefaults.standard
        if let token = defaults.string(forKey: "auth_token"){
            model.processPutReq(withBaseUrl: ApiBaseUrl.mainApi, andUrlSuffix: SuffixUrl.update.rawValue, andParameters: ["avatar":UIImageJPEGRepresentation(image, 0.9)!], onSuccess: { (data) in
                if let response = try? JSONDecoder().decode(SigninResult.self, from: data){
                let user = response.user
                    UserDAL.sharedInstance().saveUser(user: user!)
                self.user = user
                }
            }, onFailure: {(err) in}, headers: ["Authorization":token])
        }
    }
}
