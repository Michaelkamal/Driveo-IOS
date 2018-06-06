//
//  DropDownMenu.swift
//  Map
//
//  Created by Admin on 5/30/18.
//  Copyright © 2018 Admin. All rights reserved.
//


import UIKit


public enum FoldingOptions{
    case up
    case down
}
public class DropDownMenu : NSObject {
    
    fileprivate var view:UIView!
    
    fileprivate var button:UIButton!

    fileprivate var foldingOrientaion:FoldingOptions!
    
    
    @IBInspectable public var visibleItemCount: Int = 3
    
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
    
    public var items = [Provider]() {
        didSet {
            if let table = tableView {
                table.reloadData()
            }
        }
    }
    
    public var selectedIndex = -1 {
        didSet {
            didSelectedItemIndex?(items[selectedIndex])
        }
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
    
    public var didSelectedItemIndex: ((Provider) -> (Void))?
    
    public init(withView view: UIView,whenPressOnButton button:UIButton,andFoldingOrientation foldingOrientaion:FoldingOptions) {
        super.init()
        self.view=view
        self.view.layer.shadowColor = UIColor.black.cgColor
        self.view.layer.shadowOpacity = 1
        self.view.layer.shadowOffset = CGSize.zero
        self.view.layer.shadowRadius = 10
        self.view.layer.shouldRasterize=true
        self.view.layer.cornerRadius = 10;
        self.view.layer.masksToBounds = true;
        self.button=button
        self.foldingOrientaion=foldingOrientaion
    }
   
    public func didSelectedButton() {
        isFold = !isFold
    }
    
    @objc private func didTap(_ sender: UITapGestureRecognizer) {
        isFold = true
    }
}

extension DropDownMenu {
    
    private var originTableFrame: CGRect {
        // TODO: resize according to cell size
        return CGRect(x: view.frame.origin.x+2.5, y: view.frame.origin.y, width: view.frame.size.width-5, height: 0)
    }
    
    private var tableFrame: CGRect {
        if isFold {
            return originTableFrame
        } else {
            var frame = originTableFrame
            if(foldingOrientaion==FoldingOptions.down){
                frame.origin.y+=view.bounds.height
            }
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
                        if self.foldingOrientaion == FoldingOptions.up {
                            self.button.transform = CGAffineTransform(rotationAngle: 0.0000001)
                        }
                        if(self.foldingOrientaion==FoldingOptions.up)
                        {
                        self.tableView.center.y += self.tableView.bounds.height
                        self.tableView.layoutIfNeeded()
                        }
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
        tableView.backgroundColor=UIColor.clear
        tableView.register(UINib(nibName: "DropDownCarrierItem", bundle: nil), forCellReuseIdentifier: dropDownCellIdentifier)
        tableView.backgroundColor = .clear
        superSuperView.addSubview(tableView)
        tableView.reloadData()
        UIView.animate(withDuration: duration, delay: 0.0, options: [.curveEaseIn],
                       animations: {
                        self.tableView.frame = self.tableFrame
                        if self.foldingOrientaion == FoldingOptions.up {
                            self.button.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
                        }
                        if(self.foldingOrientaion==FoldingOptions.up)
                        {
                        self.tableView.center.y -= self.tableView.bounds.height
                        }
                        self.tableView.layoutIfNeeded()
        }, completion: nil)
    }
}

fileprivate let dropDownCellIdentifier = "DropDownCarrierItem"

extension DropDownMenu: UITableViewDataSource, UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: dropDownCellIdentifier) as! DropDownCarrierItem
        cell.reload(item: items[indexPath.row])
        reload(cell: cell, indexPath: indexPath)
        
        cell.contentView.layer.borderWidth = 2.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.cornerRadius = 10.0
        cell.contentView.clipsToBounds = true
        cell.contentView.layer.masksToBounds = true;
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        isFold = true
        
        selectedIndex = indexPath.row
    }
    
    private func reload(cell: DropDownCarrierItem, indexPath: IndexPath) {
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




