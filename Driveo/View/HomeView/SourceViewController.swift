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

class SourceViewController: UIViewController {
    
    private var presenter:SourceViewPresenter!
    
    private lazy var datePicker: UIDatePicker = UIDatePicker()
    
    
    @IBOutlet weak var searchTextField: SearchUITextField!{
        didSet{
            searchTextField.searchFunc=search
            searchTextField.clearFunc=dismissPlacesSearch
            searchTextField.addTarget(self, action: #selector(search), for: UIControlEvents.allEditingEvents)
        }
    }
    
    // init places menu
    private lazy var placesDropDownMenu=PlacesDropDownMenu(withView:searchView)
    
    // init carrier menu
    private lazy var carrierDropDownMenu=DropDownMenu(withView:carrierDropListView, whenPressOnButton:dropDownBtn,andFoldingOrientation:FoldingOptions.up)
 
    @IBOutlet weak var dropDownBtn: UIButton!
    
    @IBOutlet weak var searchView: UIView!
    
    @IBOutlet weak var map: GMSMapView!{
        didSet{
            map.settings.zoomGestures=false
            map.delegate=self
        }
    }
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    @IBOutlet weak var carrierDropListView: UIView!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    private var addressTitle:String = ""{
        willSet{
            if newValue != "" {
                addressLabel.text=newValue
            }
        }
    }
    @IBOutlet weak var carrierView: UIView!
    
    // create order
    @IBAction func didPressOrderNow(_ sender: RoundedButton) {
        presenter.createOrder()
    }
    
    // render calender to select date
    @IBAction func didTapOnCalendar(_ sender: RoundedButton) {
        showDatePicker()
    }
    
    // select carrier
    @IBAction func didTapOnSelectCarrier(_ sender: UIButton) {
        carrierDropDownMenu.items=presenter.getCarriers()
        carrierDropDownMenu.didSelectedButton()
    }
    
    // set current Location
    @IBAction func didTapCurrentLocation(_ sender: Any) {
        presenter.getCurrentLocation()
    }
    
    // mark: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter=SourceViewPresenter(withController: self)
    
        presenter.getCurrentLocation()
        presenter.placeMarkerFunc=placeMarker
        presenter.clearTextFunc={
             () in
            self.searchTextField.text="" }
        presenter.selectCarrierFunc={
            (image) in
            self.carrierView.subviews.forEach { $0.removeFromSuperview() }
            let imageView:UIImageView=UIImageView()
            imageView.frame = CGRect(x:20, y:5, width: self.carrierView.frame.width-20, height: self.carrierView.frame.height-10)
            imageView.contentMode = UIViewContentMode.scaleAspectFit
            imageView.image=image
            self.carrierView.addSubview(imageView)

        }
        carrierDropDownMenu.didSelectedItemIndex=presenter.didSelectCarrier
        placesDropDownMenu.didSelectedItemIndex=presenter.didSelectplace
    }
    
    
}


// mark : google map delagate
extension SourceViewController:GMSMapViewDelegate
{
    
    // mark: put place marker on location
    
    private func placeMarker(onLocation location:CLLocation,withTitle title:String,andImage image:UIImage? = nil) ->Void {
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
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        self.dismissDatePicker()
        self.dismissPlacesSearch()
    }
}

// mark : places auto complete extention
extension SourceViewController {
    @objc public func search(){
        guard let searchString=searchTextField.text else {
            return
        }
        if searchString != ""
        {
            presenter.searchForPlace(withName:searchString,andRenderFunction: renderPlaces)
        }
     }
    public func renderPlaces(placesArray arr:[PlaceDPItem]){
        placesDropDownMenu.items=arr
    }
    public func dismissPlacesSearch()
    {
        placesDropDownMenu.dismissMenu()
    }
}


// mark : date picker
extension SourceViewController
{
    // show date picker
    func showDatePicker(){
        
        // Posiiton date picket within a view
        datePicker.frame = CGRect(x: 0, y: UIScreen.main.bounds.maxY-200, width: self.view.frame.width, height: 200)
        datePicker.backgroundColor = UIColor.white
        
        datePicker.setDate(Date(), unit:.year, deltaMinimum:0, deltaMaximum:1, animated:true)
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
                            self.datePicker.frame = CGRect(x: 0, y: self.view.frame.maxY, width: self.view.frame.size.width, height: 0)
                }, completion: { [unowned self] finished in
                    self.datePicker.removeFromSuperview()
                    self.view.layoutIfNeeded()
            })
        }
    }
    
}

