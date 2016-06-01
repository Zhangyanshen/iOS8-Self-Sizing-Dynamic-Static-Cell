//
//  YSTableViewCell.swift
//  手写约束玩玩
//
//  Created by 张延深 on 16/5/26.
//  Copyright © 2016年 宜信. All rights reserved.
//

import UIKit
//import SnapKit

class YSTableViewCell: UITableViewCell {
    
    // MARK: - private property
    
    private var didSetupConstraints: Bool = false
    private var viewDic: [String: AnyObject] = [:]
    
    private var titleLbl: UILabel = {
        let titleLbl = UILabel()
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        titleLbl.backgroundColor = UIColor.yellowColor()
        return titleLbl
    }()
    
    private var icon: UIImageView = {
        let icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    private var contentLbl: UILabel = {
        let contentLbl = UILabel()
        contentLbl.translatesAutoresizingMaskIntoConstraints = false
        contentLbl.numberOfLines = 0
        contentLbl.backgroundColor = UIColor.greenColor()
        return contentLbl
    }()
    
    private var deleteBtn: UIButton = {
        let deleteBtn = UIButton(type: UIButtonType.System)
        deleteBtn.backgroundColor = UIColor.redColor()
        deleteBtn.translatesAutoresizingMaskIntoConstraints = false
        deleteBtn.setTitle("Delete", forState: UIControlState.Normal)
        return deleteBtn
    }()
    
    // 约束
    private var contentLblBottomConstraint: NSLayoutConstraint?
    private var deleteBtnBottomConstraint: NSLayoutConstraint?
    
    // MARK: - public property
    
    var model: YSModel? {
        didSet {
            titleLbl.text = model?.title
            contentLbl.text = model?.content
            if model?.icon != "" {
                icon.hidden = false
                icon.image = UIImage(named: (model?.icon)!)
            } else {
                icon.hidden = true
            }
            if model?.showDeleteBtn == true {
                deleteBtn.hidden = false
            } else {
                deleteBtn.hidden = true
            }
            // 更新字体
            self.updateFont()
            // 更新约束
            self.setNeedsUpdateConstraints()
            self.updateConstraintsIfNeeded()
        }
    }
    
    // MARK: - init methods
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // 添加view
        self.addAllView()
        // 初始化viewDic
        self.viewDic = ["titleLbl": titleLbl, "icon": icon, "contentLbl": contentLbl, "deleteBtn": deleteBtn]
        
        // 用VFL添加约束
//        self.addAllConstraintsWithVFL()
        // 不用VFL添加约束
//        self.addAllConstraints()
        // 使用SnapKit添加约束
//        self.addAllConstraintsWithSnapKit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - override methods
    
    override func updateConstraints() {
        
        if didSetupConstraints == false {
            self.addAllConstraints()
//            self.addAllConstraintsWithVFL()
//            self.addAllConstraintsWithSnapKit()
            didSetupConstraints = true
        }
        
        if model?.showDeleteBtn == true { // 显示删除按钮
            self.contentView.removeConstraint(contentLblBottomConstraint!)
            self.contentView.addConstraint(deleteBtnBottomConstraint!)
        } else { // 隐藏删除按钮
            self.contentView.removeConstraint(deleteBtnBottomConstraint!)
            self.contentView.addConstraint(contentLblBottomConstraint!)
        }
        
        super.updateConstraints()
        
    }
    
    // MARK: - private methods
    
    private func addAllView() {
        
        self.contentView.addSubview(titleLbl)
        self.contentView.addSubview(icon)
        self.contentView.addSubview(contentLbl)
        self.contentView.addSubview(deleteBtn)
    }
    
    // 使用SnapKit添加约束
//    private func addAllConstraintsWithSnapKit() {
//        // titleLbl
//        titleLbl.snp_makeConstraints { (make) in
//            make.top.equalTo(self.contentView.snp_top)
//            make.left.equalTo(self.contentView.snp_left).offset(15.0)
//            make.width.lessThanOrEqualTo(200.0)
//        }
//        // icon
//        icon.snp_makeConstraints { (make) in
//            make.left.equalTo(titleLbl.snp_right).offset(10.0)
//            make.centerY.equalTo(titleLbl.snp_centerY)
//        }
//        // contentLbl
//        contentLbl.snp_makeConstraints { (make) in
//            make.top.equalTo(titleLbl.snp_bottom)
//            make.left.equalTo(titleLbl.snp_left)
//            make.right.equalTo(self.contentView.snp_right).offset(-8.0)
//            make.bottom.equalTo(deleteBtn.snp_top)
//        }
//        // deleteBtn
//        deleteBtn.snp_makeConstraints { (make) in
//            make.right.equalTo(contentLbl)
//            make.bottom.equalTo(self.contentView)
//        }
//    }
    
    // 使用VFL添加约束
    private func addAllConstraintsWithVFL() {
        
        let constraints1 = NSLayoutConstraint.constraintsWithVisualFormat("H:|-15-[titleLbl(<=200)]-10-[icon]", options: NSLayoutFormatOptions.AlignAllCenterY, metrics: nil, views: viewDic)
        let constraints2 = NSLayoutConstraint.constraintsWithVisualFormat("V:|[titleLbl][contentLbl]", options: NSLayoutFormatOptions.AlignAllLeft, metrics: nil, views: viewDic)
        
        let constraints3 = NSLayoutConstraint.constraintsWithVisualFormat("H:[deleteBtn]-8-|", options: NSLayoutFormatOptions.AlignAllBottom, metrics: nil, views: viewDic)
        let constraints4 = NSLayoutConstraint.constraintsWithVisualFormat("V:[contentLbl][deleteBtn]|", options: NSLayoutFormatOptions.AlignAllRight, metrics: nil, views: viewDic)
        
        self.contentView.addConstraints(constraints1)
        self.contentView.addConstraints(constraints2)
        
        self.contentView.addConstraints(constraints3)
        self.contentView.addConstraints(constraints4)
    }
    
    // 不使用VFL添加约束
    private func addAllConstraints() {
        // titleLbl
        let titleLblConstraint1 = NSLayoutConstraint(item: titleLbl, attribute: .Top, relatedBy: .Equal, toItem: self.contentView, attribute: .Top, multiplier: 1.0, constant: 0.0)
        let titleLblConstraint2 = NSLayoutConstraint(item: titleLbl, attribute: .Left, relatedBy: .Equal, toItem: self.contentView, attribute: .Left, multiplier: 1.0, constant: 15.0)
        let titleLblConstraint3 = NSLayoutConstraint(item: titleLbl, attribute: .Width, relatedBy: .LessThanOrEqual, toItem: nil, attribute: .NotAnAttribute, multiplier: 0.0, constant: 200.0)
        // icon
        let iconConstraint1 = NSLayoutConstraint(item: icon, attribute: .Left, relatedBy: .Equal, toItem: titleLbl, attribute: .Right, multiplier: 1.0, constant: 10.0)
        let iconConstraint2 = NSLayoutConstraint(item: icon, attribute: .CenterY, relatedBy: .Equal, toItem: titleLbl, attribute: .CenterY, multiplier: 1.0, constant: 0.0)
        // contentLbl
        let contentLblConstraint1 = NSLayoutConstraint(item: contentLbl, attribute: .Top, relatedBy: .Equal, toItem: titleLbl, attribute: .Bottom, multiplier: 1.0, constant: 0.0)
        let contentLblConstraint2 = NSLayoutConstraint(item: contentLbl, attribute: .Left, relatedBy: .Equal, toItem: titleLbl, attribute: .Left, multiplier: 1.0, constant: 0.0)
        let contentLblConstraint3 = NSLayoutConstraint(item: contentLbl, attribute: .Right, relatedBy: .Equal, toItem: self.contentView, attribute: .Right, multiplier: 1.0, constant: -8.0)
        let contentLblConstraint4 = NSLayoutConstraint(item: contentLbl, attribute: .Bottom, relatedBy: .Equal, toItem: deleteBtn, attribute: .Top, multiplier: 1.0, constant: 0.0)
        let contentLblConstraint5 = NSLayoutConstraint(item: contentLbl, attribute: .Bottom, relatedBy: .Equal, toItem: self.contentView, attribute: .Bottom, multiplier: 1.0, constant: 0.0)
        contentLblBottomConstraint = contentLblConstraint5
        // deleteBtn
        let deleteBtnConstraint1 = NSLayoutConstraint(item: deleteBtn, attribute: .Right, relatedBy: .Equal, toItem: contentLbl, attribute: .Right, multiplier: 1.0, constant: 0.0)
        let deleteBtnConstraint2 = NSLayoutConstraint(item: deleteBtn, attribute: .Bottom, relatedBy: .Equal, toItem: self.contentView, attribute: .Bottom, multiplier: 1.0, constant: 0.0)
        deleteBtnBottomConstraint = deleteBtnConstraint2
        
        self.contentView.addConstraint(titleLblConstraint1)
        self.contentView.addConstraint(titleLblConstraint2)
        titleLbl.addConstraint(titleLblConstraint3)
        
        self.contentView.addConstraint(iconConstraint1)
        self.contentView.addConstraint(iconConstraint2)
        
        self.contentView.addConstraint(contentLblConstraint1)
        self.contentView.addConstraint(contentLblConstraint2)
        self.contentView.addConstraint(contentLblConstraint3)
        self.contentView.addConstraint(contentLblConstraint4)
        
        self.contentView.addConstraint(deleteBtnConstraint1)
        self.contentView.addConstraint(deleteBtnConstraint2)
    }
    
    // 更新字体
    func updateFont() {
        
        titleLbl.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        contentLbl.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
    }

}
