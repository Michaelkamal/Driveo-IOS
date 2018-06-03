//
//  PlacesDropDownMenu.swift
//  Map
//
//  Created by Admin on 6/1/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation

import UIKit


public class PlacesDropDownMenu : NSObject {
    
    fileprivate var view:UIView!
 
    @IBInspectable public var visibleItemCount: Int = 5
    
    @IBInspectable public var menuTextColor: UIColor = .black {
        didSet {
            if let table = tableView {
                table.reloadData()
            }
        }
    }
    
    @IBInspectable public var menuBackgroundColor: UIColor = .white {
        didSet {
            if let table = tableView {
                table.backgroundColor = menuBackgroundColor
            }
        }
    }
    
    @IBInspectable public var selectedMenuTextColor: UIColor = .orange {
        didSet {
            if let table = tableView {
                table.reloadData()
            }
        }
    }
    
    @IBInspectable public var selectedMenuBackgroundColor: UIColor = .white {
        didSet {
            if let table = tableView {
                table.reloadData()
            }
        }
    }
    
    @IBInspectable public var menuTextFont: UIFont = UIFont.systemFont(ofSize: 14) {
        didSet {
            if let table = tableView {
                table.reloadData()
            }
        }
    }
    
    public var items = [PlaceDPItem]() {
        didSet {
            if let table = tableView {
                table.reloadData()
            }
            if isFold {isFold = !isFold}
        }
    }
    public func dismissMenu(){
          onSuccess()
    }
    public var selectedIndex = -1 {
        didSet {
            didSelectedItemIndex?(items[selectedIndex],onSuccess)
        }
    }
    
    private func onSuccess(){
        if !isFold {isFold = !isFold}
    }
    
    fileprivate var isFold = true {
        didSet {
            if isFold {
                fold()
            } else {
                unFold()
            }
        }
    }
    
    fileprivate var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            tableView.rowHeight = view.bounds.size.height
            tableView.separatorInset = UIEdgeInsets.zero
        }
    }
    
    fileprivate var backgroundView: UIView! {
        didSet {
            let tap = UITapGestureRecognizer(target: self, action: #selector(didTap(_:)))
            backgroundView.addGestureRecognizer(tap)
        }
    }
    public var didSelectedItemIndex: ((PlaceDPItem,()->Void) -> (Void))?
    
    public init(withView view: UIView) {
        super.init()
        self.view=view
        self.view.layer.shadowColor = UIColor.black.cgColor
        self.view.layer.shadowOpacity = 1
        self.view.layer.shadowOffset = CGSize.zero
        self.view.layer.shadowRadius = 10
        self.view.layer.shouldRasterize=true
        self.view.layer.cornerRadius = 10
        self.view.layer.masksToBounds = true
    }
    
    @objc private func didTap(_ sender: UITapGestureRecognizer) {
        isFold = true
    }
}

extension PlacesDropDownMenu {
    
    private var originTableFrame: CGRect {
        // TODO: resize according to cell size
        return CGRect(x: view.frame.origin.x+2.5, y: view.frame.origin.y+view.frame.height, width: view.frame.size.width-5, height: 0)
    }
    
    private var tableFrame: CGRect {
        if isFold {
            return originTableFrame
        } else {
            var frame = originTableFrame
            frame.size.height = itemHeight
            return frame
        }
    }
    
    private var itemHeight: CGFloat {
        if items.count > visibleItemCount {
            tableView.isScrollEnabled = true
            return CGFloat(visibleItemCount) * view.bounds.size.height
        } else {
            tableView.isScrollEnabled = false
            return CGFloat(items.count) * view.bounds.size.height
        }
    }
    
    private var superSuperView: UIView {
        var v: UIView = view
        while (v.superview != nil) {
            v = v.superview!
        }
        return v
    }
    
    private var duration: TimeInterval {
        return 0.25
    }
    
    fileprivate func fold() {
        UIView.animate(withDuration: duration, delay: 0.0,
                       options: [UIViewAnimationOptions.curveEaseOut],
                       animations:{ [unowned self] in
                        self.tableView.frame = self.tableFrame
            }, completion: { [unowned self] finished in
                self.backgroundView.removeFromSuperview()
                self.tableView.removeFromSuperview()
                self.view.layoutIfNeeded()
        })
        
    }
    
    fileprivate func unFold() {
        backgroundView = UIView(frame: superSuperView.bounds)
        superSuperView.addSubview(backgroundView)
        tableView = UITableView(frame: originTableFrame, style: .plain)
        tableView.register(UINib(nibName: "DropDownPlacesItem", bundle: nil), forCellReuseIdentifier: dropDownCellIdentifier)
        tableView.backgroundColor = .clear
        superSuperView.addSubview(tableView)
        tableView.reloadData()
        UIView.animate(withDuration: duration, delay: 0.0, options: [.curveEaseIn],
                       animations: {
                        self.tableView.frame = self.tableFrame
        }, completion: nil)
    }
}

fileprivate let dropDownCellIdentifier = "DropDownPlacesItem"

extension PlacesDropDownMenu: UITableViewDataSource, UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: dropDownCellIdentifier) as! DropDownPlacesItem
        cell.reload(item: items[indexPath.row])
        reload(cell: cell, indexPath: indexPath)
        
        cell.contentView.layer.cornerRadius = 10;
        cell.contentView.layer.masksToBounds = true;
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        isFold = true
        
        selectedIndex = indexPath.row
    }
    
    private func reload(cell: DropDownPlacesItem, indexPath: IndexPath) {
        cell.textLabel?.font = menuTextFont
        
        if indexPath.row == selectedIndex {
            cell.backgroundColor = selectedMenuBackgroundColor
            cell.textLabel?.textColor = selectedMenuTextColor
        } else  {
            cell.backgroundColor = menuBackgroundColor
            cell.textLabel?.textColor = menuTextColor
        }
    }
}




