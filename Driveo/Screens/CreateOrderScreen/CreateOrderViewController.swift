//
//  CreateOrder.swift
//  Driveo
//
//  Created by Admin on 6/3/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import UIKit

class CreateOrderViewController: UIViewController {
    
    private lazy var userOrder:Order = Order.sharedInstance()
    
    private var progressBarView: (backGround:UIView,progressBar:CircularProgress)?
    
    private var orderSubmitted:Bool=false{
        didSet{
            if(!orderSubmitted){
                self.removeProgressBar()
            }
        }
    }
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var orderStatus: UILabel!
    
    @IBOutlet weak var contentViewHeightConstraint: NSLayoutConstraint!
    
    private var presenter: CreateOrderPresenter!
    
    var cellHeight:CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter =  CreateOrderPresenter(withController: self)
        if self.navigationController!.viewControllers.count>1{
            self.navigationController!.viewControllers=[self]
        }
        cellHeight=contentView.frame.height/5
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        orderStatus.text=userOrder.orderCurrentStep.rawValue
        contentView.subviews.forEach { (view) in
            view.removeFromSuperview()
        }
        let contentViewMaxY = contentView.frame.maxY
        contentViewHeightConstraint.constant = contentView.superview!.frame.height
        addSuccessfullOrderSteps(withSuperViewMaxY: contentViewMaxY, andCellHeight: cellHeight)
        addNextOrderStep(withSuperViewMaxY: contentViewMaxY, andCellHeight: cellHeight)
        addNextButton(withSuperViewMaxY: contentViewMaxY, andCellHeight: cellHeight)
    }
    
    func presentScreen(screen:ScreenController){
        let destinationStoryboard = UIStoryboard(name: screen.storyBoardName(), bundle: nil)
        var vc : UIViewController
        if(screen == ScreenController.sourceScreen){
            vc = destinationStoryboard.instantiateViewController(withIdentifier: "PickLoacationViewController")
        }else{
         vc = destinationStoryboard.instantiateViewController(withIdentifier: screen.rawValue)
        }
        switch userOrder.completeStatus{
        // set Drop off location
        case 1:
            let vc = vc as! PickLoacationViewController
            vc.isSource=false
        default:
            break
        }
        vc.modalTransitionStyle = .flipHorizontal
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    // add next order step of order to the scroll view
    func addNextOrderStep(withSuperViewMaxY contentViewMaxY:CGFloat,andCellHeight cellHeight:CGFloat){
        if (userOrder.completeStatus<4){
        if let orderStep = Bundle.main.loadNibNamed("OrderItem", owner: self, options: nil)?.first as? CreateOrderView {
                
                switch userOrder.completeStatus{
                // set Pick Up location
                case 0:
                    orderStep.title.text="Pick up Location"
                    orderStep.subtitle.text=userOrder.source?.address
                    orderStep.editFunc={
                        () in
                        self.presentScreen(screen: ScreenController.sourceScreen)
                    }
                // set Drop off location
                case 1:
                    orderStep.title.text="Drop Off Location"
                    orderStep.subtitle.text=userOrder.destination?.address
                    orderStep.editFunc={
                        () in
                        self.presentScreen(screen: ScreenController.destinationScreen)
                    }
                case 2:
                    orderStep.title.text="Order details"
                    orderStep.subtitle.text=userOrder.details?.title
                    orderStep.editFunc={
                        () in
                        self.presentScreen(screen: ScreenController.createRequestScreen)
                    }
                case 3:
                    orderStep.title.text="Payment method"
                    orderStep.subtitle.text=userOrder.paymentMethod?.name
                    orderStep.editFunc={
                        () in
                        self.presentScreen(screen: ScreenController.paymentScreen)
                    }
                default:
                    break
                }
                orderStep.registerEditFunction()
                if contentView.subviews.count<1
                {
                    orderStep.frame=CGRect(x: contentView.frame.minX+49, y: contentView.frame.minY, width: contentView.frame.width-98, height: cellHeight)
                }
                else
                {
                    orderStep.frame=CGRect(x: contentView.frame.minX+49, y: contentView.subviews.last!.frame.maxY, width: contentView.frame.width-98, height: cellHeight)
                }
                orderStep.distinationLine.removeFromSuperview()
                orderStep.statusImage.image=#imageLiteral(resourceName: "ic_destination_b")
                contentView.addSubview(orderStep)
            }
        }
    }
    
    // add successfull steps so far to the scroll view
    func addSuccessfullOrderSteps(withSuperViewMaxY contentViewMaxY:CGFloat,andCellHeight cellHeight:CGFloat){
            for i in stride(from: 0, to:userOrder.completeStatus, by: 1)
            {
                if let orderStep = Bundle.main.loadNibNamed("OrderItem", owner: self, options: nil)?.first as? CreateOrderView {
                    
                    switch i{
                    case 0:
                        orderStep.title.text="Pickup location"
                        orderStep.subtitle.text=userOrder.source?.address
                        orderStep.editFunc={
                            () in
                            self.presentScreen(screen: ScreenController.sourceScreen)
                        }
                    case 1:
                        orderStep.title.text="Drop off location"
                        orderStep.subtitle.text=userOrder.destination?.address
                        orderStep.editFunc={
                            () in
                            self.presentScreen(screen: ScreenController.destinationScreen)}
                    case 2:
                        orderStep.title.text="Order details"
                        orderStep.subtitle.text=userOrder.details?.title
                        orderStep.editFunc={
                            () in
                            self.presentScreen(screen: ScreenController.createRequestScreen)
                        }
                    case 3:
                            orderStep.title.text="Payment method"
                            orderStep.subtitle.text=userOrder.paymentMethod?.name
                            orderStep.editFunc={
                                () in
                                self.presentScreen(screen: ScreenController.paymentScreen)
                        }
                            orderStep.distinationLine.removeFromSuperview()
                    default:
                        break
                    }
                    orderStep.registerEditFunction()
                    if contentView.subviews.count<1
                    {
                        orderStep.frame=CGRect(x: contentView.frame.minX+49, y: contentView.frame.minY, width: contentView.frame.width-98, height: cellHeight)
                    }
                    else
                    {
                        orderStep.frame=CGRect(x: contentView.frame.minX+49, y: contentView.subviews.last!.frame.maxY, width: contentView.frame.width-98, height: cellHeight)
                    }
                    
                    orderStep.statusImage.image=#imageLiteral(resourceName: "ic_destination_a")
                    contentView.addSubview(orderStep)
                }
            }
        }
    
    
    // add next button at the end of scroll view
    func addNextButton(withSuperViewMaxY contentViewMaxY:CGFloat,andCellHeight cellHeight:CGFloat){
        if let nextButton = Bundle.main.loadNibNamed("NextButton", owner: self, options: nil)?.first as? NextButtonView {
            if contentView.subviews.count>1,(contentView.subviews.last!.bounds.maxY>contentViewMaxY ||
                contentViewMaxY-contentView.subviews.last!.frame.maxY < cellHeight)
            {
                nextButton.frame=CGRect(x: contentView.frame.minX, y: contentView.subviews.last!.frame.maxY, width: contentView.frame.width, height: 80)
                contentView.addSubview(nextButton)
                contentViewHeightConstraint.constant = nextButton.frame.maxY-contentView.frame.minY
                contentView.setNeedsLayout()
                contentView.superview!.setNeedsDisplay()
                nextButton.updateConstraints()
    
            }
            else
            {
                nextButton.frame=CGRect(x: contentView.frame.minX, y: contentViewMaxY-80, width: contentView.frame.width, height: 80)
                contentView.addSubview(nextButton)
                contentView.setNeedsLayout()
                contentView.setNeedsDisplay()
                nextButton.updateConstraints()
            }
            if self.userOrder.completeStatus > 3
            {
                nextButton.nextButton.setTitle("Order Now", for: .normal)
            }
            nextButton.nextFunc={ () in
                switch self.userOrder.completeStatus
                {
                case 0:
                    self.presentScreen(screen: ScreenController.sourceScreen)
                case 1:
                    self.presentScreen(screen: ScreenController.destinationScreen)
                case 2:
                    self.presentScreen(screen: ScreenController.createRequestScreen)
                case 3:
                    self.presentScreen(screen: ScreenController.paymentScreen)
                default:
                    if(!self.isSubmitted){
                        self.isSubmitted=true
                        self.presenter.sumbitOrder(self.userOrder)
                    }
                    break
                }
            }
            nextButton.registerNextFunction()
        }
    }
    @IBAction func didTapOnThreeBars(_ sender: UIButton) {
        let screen = ScreenController.navigationDrawerScreen;
        let destinationStoryboard = UIStoryboard(name: screen.storyBoardName(), bundle: nil)
        let vc = destinationStoryboard.instantiateViewController(withIdentifier: screen.rawValue.trimmingCharacters(in: CharacterSet.whitespaces))
        pushFromLeft(vc)
    }
    
}

extension CreateOrderViewController:CreateOrderViewProtocol{
    var isSubmitted: Bool {
        get {
            return orderSubmitted
        }
        set {
            orderSubmitted = newValue
        }
    }
    func displayProgressBar() {
        if progressBarView == nil {
            progressBarView=UIViewController.displayCircularProgressBar(onView: self.view, withMaxValue: 1)
        }
    }
    
    func updateProgressBar(withValue value: Double) {
        if let progressBarTuble=progressBarView{
            progressBarTuble.progressBar.increaseProgress(toValue: value)
        }
    }
    
    func removeProgressBar() {
        
        if let progressBarTuble=progressBarView{
            UIViewController.removeSpinner(spinner: progressBarTuble.backGround)
            progressBarView=nil
        }
    }
    
    func showAlert(withTitle title :String , andMessage msg:String){
       let alert = UIViewController.getCustomAlertController(ofErrorType: msg, withTitle: title)
        var dismissAlertAction : UIAlertAction!
        if title == "success"{
        dismissAlertAction = UIAlertAction(title: "OK", style: .default,handler: {
            (alertAction) in
            self.presentToNextScreen()
        })}else{
            dismissAlertAction = UIAlertAction(title: "OK", style: .default,handler:nil)
        }
        alert.addAction(dismissAlertAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlert(ofError error: ErrorType) {
        if (orderSubmitted){
            orderSubmitted=false
        }
            let alert = UIViewController.getAlertController(ofErrorType: error, withTitle: "Error")
            guard let visibleViewController = self.navigationController?.visibleViewController else{
                present(alert, animated: true, completion: nil)
                return
            }
            if !visibleViewController.isKind(of: UIAlertController.self)  {
                present(alert, animated: true, completion: nil)
            }
    }
    
    func presentToNextScreen() {
        self.removeProgressBar()
        let screen = ScreenController.sourceScreen
        let sourceScreenStoryboard = UIStoryboard(name: screen.storyBoardName(), bundle: nil)
        let home = sourceScreenStoryboard.instantiateViewController(withIdentifier: screen.rawValue)
        home.modalTransitionStyle = .flipHorizontal
        self.present(home, animated: true) {
            UIApplication.shared.keyWindow?.rootViewController = home
        }
    }
    
    
}
