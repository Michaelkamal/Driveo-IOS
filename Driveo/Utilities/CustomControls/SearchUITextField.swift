//
//  SearchUITextView.swift
//  Map
//
//  Created by Admin on 5/31/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class SearchUITextField: UITextField {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let iconWidth = 19;
        let iconHeight = 19;
        
        leftView=UIView()
        let searchButton = UIButton(type: .custom)
        searchButton.setImage(#imageLiteral(resourceName: "ic_search"), for: UIControlState.normal)
        searchButton.backgroundColor = UIColor.clear
        leftView!.frame=CGRect(x:0, y:0, width: iconWidth+16, height: iconHeight)
        searchButton.frame = CGRect(x: 0, y: 0, width: iconWidth, height: iconHeight)
        searchButton.addTarget( self, action:#selector(didTapOnSearchButton), for: UIControlEvents.touchUpInside)
        leftView!.addSubview(searchButton)
        leftViewMode = UITextFieldViewMode.always
        
        
        rightView=UIView()
        let clearButton = UIButton(type: .custom)
        clearButton.setImage(#imageLiteral(resourceName: "ic_close_search"), for: UIControlState.normal)
        clearButton.backgroundColor = UIColor.clear
        clearButton.contentEdgeInsets=UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 5)
        clearButton.addTarget( self, action:#selector(didTapOnClearButton), for: UIControlEvents.touchUpInside)
        rightView!.frame=CGRect(x:0, y:0, width: iconWidth, height: iconHeight)
        clearButton.frame = CGRect(x: 6, y: 0, width: iconWidth, height: iconHeight)
        rightView!.addSubview(clearButton)
        rightViewMode = UITextFieldViewMode.always
        layer.borderWidth = 2.0
        layer.borderColor = UIColor.clear.cgColor
        layer.cornerRadius = 10.0
        clipsToBounds = true
    }
    public var clearFunc : (()->Void)?
    @objc func didTapOnClearButton()
    {
        if let inputText=text{
            if inputText  != "" {
                text=""
            }
        }
        clearFunc?()
    }
    
    public var searchFunc : (()->Void)?
    
    @objc func didTapOnSearchButton()
    {
        becomeFirstResponder()
        searchFunc?()
    }
}
