//
//  HomeMViewController.swift
//  Map
//
//  Created by Admin on 5/29/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlacesSearchController
import SDWebImage
class PickLoacationViewController: UIViewController {
    
    private var presenter:PickLoacationPresenter!
    
    private lazy var userOrder:Order = Order.sharedInstance()
    
    private lazy var datePicker: UIDatePicker = UIDatePicker()
    
    public var isSource : Bool = true
    
    @IBAction func didTapOnThreeBars(_ sender: UIButton) {
        let screen = ScreenController.navigationDrawerScreen;
        let destinationStoryboard = UIStoryboard(name: screen.storyBoardName(), bundle: nil)
        let vc = destinationStoryboard.instantiateViewController(withIdentifier: screen.rawValue.trimmingCharacters(in: CharacterSet.whitespaces))
        presentFromLeft(vc)
    }
    
    @IBOutlet weak var searchTextField: SearchUITextField!{
        didSet{
            searchTextField.searchFunc=search
            searchTextField.clearFunc=dismissPlacesSearch
            searchTextField.addTarget(self, action: #selector(search), for: UIControlEvents.allEditingEvents)
            searchTextField.delegate=self
            if (carrierDropListView != nil)
            {
                isSource=true
            }
            else
            {
                isSource=false
            }
        }
    }
    
    // init places menu
    private lazy var placesDropDownMenu=PlacesDropDownMenu(withView:searchView)
    
    // init carrier menu
    private lazy var carrierDropDownMenu=DropDownMenu(withView:carrierDropListView!, whenPressOnButton:dropDownBtn,andFoldingOrientation:FoldingOptions.up)
    
    @IBOutlet weak var dropDownBtn: UIButton!
    
    @IBOutlet weak var searchView: UIView!
    
    @IBOutlet weak var map: GMSMapView!{
        didSet{
            map.settings.zoomGestures=false
            map.delegate=self
        }
    }
    
    @IBOutlet weak var carrierDropListView: UIView?
    
    @IBOutlet weak var addressLabel: UILabel!
    
    private var addressTitle:String = ""{
        willSet{
            if newValue != "" {
                addressLabel.text=newValue
            }
        }
    }
    @IBOutlet weak var carrierView: UIView!
    
    
    
    // create order and move to destination (OR) set destination and move to create order
    @IBAction func didPressOnNextButton(_ sender: RoundedButton) {
        if isSource {
            dismissAllPopups()
        }
        presenter.moveForward()
    }
    
    // render calender to select date
    @IBAction func didTapOnCalendar(_ sender: RoundedButton) {
        dismissAllPopups()
        showDatePicker()
    }
    
    // select carrier
    @IBAction func didTapOnSelectCarrier(_ sender: UIButton) {
        dismissAllPopups()
        presenter.getCarriers()
        carrierDropDownMenu.didSelectedButton()
    }
    
    // set current Location
    @IBAction func didTapCurrentLocation(_ sender: Any) {
        dismissAllPopups()
        presenter.getCurrentLocation()
    }
    
    // mark: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter=PickLoacationPresenter(withController: self)
        if (isSource && userOrder.source == nil) || (!isSource && userOrder.destination == nil)
        {presenter.getCurrentLocation()}
        
        if(isSource){
            carrierDropDownMenu.didSelectedItemIndex=presenter.didSelectCarrier
            presenter.getCarriers()
        }
        
        placesDropDownMenu.didSelectedItemIndex=presenter.didSelectplace
        
            if(isSource && userOrder.source != nil){
                addressLabel.text=userOrder.source?.address
                placeMarker(onLocation: userOrder.source!.coordinates!, withTitle: userOrder.source!.address!)
            }else{
                if(userOrder.destination != nil)
                {
                    addressLabel.text=userOrder.destination!.address
                    placeMarker(onLocation: userOrder.destination!.coordinates!, withTitle: userOrder.destination!.address!)
                }
            }
    }
    
    private func dismissAllPopups(){
        searchTextField.resignFirstResponder()
        self.view.endEditing(true)
        if(isSource){
            self.dismissDatePicker()
        }
        self.dismissPlacesSearch()
    }
}


// mark : google map delagate
extension PickLoacationViewController:GMSMapViewDelegate
{
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        dismissAllPopups()
    }
}

// mark : view delagate
extension PickLoacationViewController:PickLocationViewProtocol
{
    func updateCarrierArray(withCarriers carriers: [Provider]) {
         carrierDropDownMenu.items=carriers
    }
    
    var isCurrentScreenSourcePickUp: Bool {
        return self.isSource
    }
    
    // mark: put place marker on location
    
    internal func placeMarker(onLocation location:CLLocation,withTitle title:String,andImage image:UIImage? = nil) ->Void {
        self.map.clear();
        let marker = GMSMarker(position: location.coordinate);
        marker.title=title
        self.addressLabel.text=title
        
        if image != nil{
            marker.icon=image
        }else
        {
            marker.icon=#imageLiteral(resourceName: "ic_destination_b")
        }
        marker.map = self.map
        self.map.camera = GMSCameraPosition(target: location.coordinate,
                                            zoom: 60, bearing: 0, viewingAngle: 0)
    }
    
    // clear search text
    
    func clearSearchText()->Void{
        self.searchTextField.text=""
    }
    
    // display selected carrier logo on drop up list
    
    func displaySelectedCarrier(withLogoUrl url:String)->Void
    {
        self.carrierView.subviews.forEach { $0.removeFromSuperview() }
        let imageView:UIImageView=UIImageView()
        imageView.frame = CGRect(x:20, y:5, width: self.carrierView.frame.width-20, height: self.carrierView.frame.height-10)
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        imageView.sd_setImage(with: URL(string: ApiBaseUrl.mainApi.rawValue+url), completed: nil)
        self.carrierView.addSubview(imageView)
    }
    
    // display places in list
    
    public func renderPlaces(placesArray arr:[PlaceDPItem]){
        placesDropDownMenu.items=arr
    }
    
    // dismiss places list
    public func dismissPlacesSearch()
    {
        placesDropDownMenu.dismissMenu()
    }
    
    // show alert
    
    func showAlert(ofError error:ErrorType)->Void{
        let alert = UIViewController.getAlertController(ofErrorType: error, withTitle: "Error")
        guard let visibleViewController = self.navigationController?.visibleViewController else{
            present(alert, animated: true, completion: nil)
            return
        }
        if !visibleViewController.isKind(of: UIAlertController.self)  {
            present(alert, animated: true, completion: nil)
        }
    }
    
    // move to second screen
    
    func presentToNextScreen(){
        if self.navigationController != nil{
            let screen = ScreenController.createOrderScreen
            let destinationStoryboard = UIStoryboard(name: screen.storyBoardName(), bundle: nil)
            let vc = destinationStoryboard.instantiateViewController(withIdentifier: screen.rawValue.trimmingCharacters(in: CharacterSet.whitespaces))
            self.navigationController!.pushViewController(vc, animated: true)
            }else{
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}
// mark : places auto complete extention
extension PickLoacationViewController {
    @objc public func search(){
        guard let searchString=searchTextField.text else {
            return
        }
        if searchString != ""
        {
            presenter.searchForPlace(withName:searchString)
        }
    }
    
}


// mark : date picker
extension PickLoacationViewController
{
    // show date picker
    func showDatePicker(){
        
        // Posiiton date picket within a view
        datePicker.frame = CGRect(x: 0, y: UIScreen.main.bounds.maxY-200, width: self.view.frame.width, height: 200)
        datePicker.backgroundColor = UIColor.white
        
        datePicker.setDate(Date(), unit:.year, deltaMinimum:0, deltaMaximum:1, animated:true)
        
        if let date = userOrder.date{
            // Create date formatter
            let dateFormatter: DateFormatter = DateFormatter()
            // Set date format
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000Z"
            let date = dateFormatter.date (from: date)
            datePicker.setDate(date!, animated: false)
        }
        // Add an event to call onDidChangeDate function when value is changed.
        datePicker.addTarget(presenter, action: #selector(presenter.datePickerValueChanged), for: .valueChanged)
        
        // Add DataPicker to the view
        
        UIView.animate(withDuration: 0.25, delay: 0.0,
                       options: [UIViewAnimationOptions.curveEaseIn],
                       animations:{ [unowned self] in
                        
                        self.view.addSubview(self.datePicker)
            }, completion: nil)
    }
    
    // mark: dismiss datepicker
    private func dismissDatePicker(){
        if (self.datePicker.window != nil){
            UIView.animate(withDuration: 0.25, delay: 0.0,
                           options: [UIViewAnimationOptions.curveEaseOut],
                           animations:{ [unowned self] in
                            self.datePicker.sendActions(for: .valueChanged)
                            self.datePicker.frame = CGRect(x: 0, y: self.view.frame.maxY, width: self.view.frame.size.width, height: 0)
                }, completion: { [unowned self] finished in
                    self.datePicker.removeFromSuperview()
                    self.view.layoutIfNeeded()
            })
        }
    }
    
}
extension PickLoacationViewController:UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
