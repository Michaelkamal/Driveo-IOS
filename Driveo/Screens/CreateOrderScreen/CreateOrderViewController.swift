////
////  CreateOrder.swift
////  Driveo
////
////  Created by Admin on 6/3/18.
////  Copyright © 2018 ITI. All rights reserved.
////
//
//import UIKit
//
//class CreateOrderViewController: UIViewController {
//    
//    public var userOrder:Order?
//    
//    @IBOutlet weak var contentView: UIView!
//    
//    @IBOutlet weak var orderStatus: UILabel!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        if let userOrder = userOrder{
//            orderStatus.text=userOrder.orderStatus?.rawValue
//            for i in stride(from: 0, to:userOrder.completeStatus, by: 1)
//            {
//                if let orderStep = Bundle.main.loadNibNamed("OrderItem", owner: self, options: nil)?.first as? CreateOrderView {
//                    if i < userOrder.completeStatus-1
//                    {
//                        orderStep.statusImage.image=#imageLiteral(resourceName: "ic_destination_a")
//                    }
//                    else
//                    {
//                        orderStep.statusImage.image=#imageLiteral(resourceName: "ic_destination_b")
//                    }
//                    
//                    switch i{
//                    case 0:
//                        orderStep.title.text="Pickup location"
//                        orderStep.subtitle.text=userOrder.source.address
//                        orderStep.editFunc={
//                            () in
//                            self.presentScreen(screen: ScreenController.sourceScreen, withOrder: userOrder)
//                        }
//                    case 1:
//                        orderStep.title.text="Drop off location"
//                        orderStep.subtitle.text=userOrder.destination?.address
//                        orderStep.editFunc={
//                            () in
//                            self.presentScreen(screen: ScreenController.destinationScreen, withOrder: userOrder)}
//                    case 2:
//                        orderStep.title.text="Payment method"
//                        orderStep.subtitle.text=userOrder.destination?.address
//                        orderStep.editFunc={
//                            () in
//                            self.presentScreen(screen: ScreenController.destinationScreen, withOrder: userOrder)
//                        }
//                    default:
//                        break
//                    }
//                    orderStep.registerEditFunction()
//                    if contentView.subviews.count<1
//                    {
//                        orderStep.frame=CGRect(x: contentView.frame.minX, y: contentView.frame.minY, width: contentView.frame.width, height: contentView.frame.height/5)
//                    }
//                    else
//                    {
//                        orderStep.frame=CGRect(x: contentView.frame.minX, y: contentView.subviews.last!.frame.maxY, width: contentView.frame.width, height: contentView.frame.height/5)
//                    }
//                    
//                    contentView.addSubview(orderStep)
//                }
//            }
//        }
//    }
//    
//    func presentScreen(screen:ScreenController,withOrder order:Order){
//        let destinationStoryboard = UIStoryboard(name: screen.storyBoardName(), bundle: nil)
//        let vc = destinationStoryboard.instantiateViewController(withIdentifier: screen.rawValue.trimmingCharacters(in: CharacterSet.whitespaces))
//        switch screen {
//        case .sourceScreen, .destinationScreen:
//            let vc = vc as! PickLoacationViewController
//            vc.userOrder = order
//            vc.isEditingFromCreateOrder=true
//            if screen == .sourceScreen {vc.isSource=true}
//            
//        case .createOrderScreen:
//            break
//        case .paymentScreen:
//            break
//        }
//        vc.modalTransitionStyle = .flipHorizontal
//        self.present(vc, animated: true,completion: nil)
//        
//    }
//    
//    @IBAction func didTapOnCloseButton(_ sender: UIButton) {
//        self.dismiss(animated: true, completion: nil)
//    }
//    
//}
