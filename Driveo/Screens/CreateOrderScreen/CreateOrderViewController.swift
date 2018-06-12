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
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var orderStatus: UILabel!
    
    @IBOutlet weak var contentViewHeightConstraint: NSLayoutConstraint!
    
    
    var cellHeight:CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.viewControllers=[self]
        cellHeight=contentView.frame.height/5
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        orderStatus.text=userOrder.orderStatus.rawValue
        contentView.subviews.forEach { (view) in
            view.removeFromSuperview()
        }
        let contentViewMaxY=contentView.frame.maxY
        addSuccessfullOrderSteps(withSuperViewMaxY: contentViewMaxY, andCellHeight: cellHeight)
        addNextOrderStep(withSuperViewMaxY: contentViewMaxY, andCellHeight: cellHeight)
        addNextButton(withSuperViewMaxY: contentViewMaxY, andCellHeight: cellHeight)
    }
    
    func presentScreen(screen:ScreenController){
        let destinationStoryboard = UIStoryboard(name: screen.storyBoardName(), bundle: nil)
        let vc = destinationStoryboard.instantiateViewController(withIdentifier: screen.rawValue.trimmingCharacters(in: CharacterSet.whitespaces))
        switch userOrder.completeStatus{
        // set Drop off location
        case 1:
            let vc = vc as! PickLoacationViewController
            vc.isSource=false
        default:
            break
        }
        vc.modalTransitionStyle = .flipHorizontal
        self.present(vc, animated: true,completion: nil)
        
    }
    
    // add next order step of order to the scroll view
    func addNextOrderStep(withSuperViewMaxY contentViewMaxY:CGFloat,andCellHeight cellHeight:CGFloat){
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
            if contentView.subviews.count>1,(contentView.subviews.last!.frame.maxY>contentViewMaxY ||
                contentViewMaxY-contentView.subviews.last!.frame.maxY<cellHeight)
            {
                nextButton.frame=CGRect(x: contentView.frame.minX, y: contentView.subviews.last!.frame.maxY, width: contentView.frame.width, height: cellHeight)
                contentView.addSubview(nextButton)
                contentViewHeightConstraint.constant += nextButton.frame.maxY-contentViewMaxY+0.5*cellHeight
                contentView.updateConstraints()
            }
            else
            {
                nextButton.frame=CGRect(x: contentView.frame.minX, y: contentViewMaxY-0.5*cellHeight, width: contentView.frame.width, height: cellHeight)
                contentView.addSubview(nextButton)
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
        presentFromLeft(vc)
    }
    
}

