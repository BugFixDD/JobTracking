//
//  ETJobInfoSearchCell.swift
//  九江职业技术学院就业跟踪
//
//  Created by  罗仕宇 on 2018/6/22.
//  Copyright © 2018年 BF. All rights reserved.
//

import UIKit

class ETJobInfoSearchCell: UITableViewCell {
    
    var ViewModel: ETJobInfo? {
        didSet{
            job_Name?.attributedText = attrStr(title: (ViewModel?.job_name)!, searchtxt: searchText!)
        }
    }
    
    func attrStr(title: String, searchtxt: String) -> NSAttributedString {
        let attrString = NSMutableAttributedString(string: title)
        
        let range = (title as NSString).range(of: searchtxt)
        
        attrString.addAttributes([NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 20),
                                  NSAttributedStringKey.foregroundColor: UIColor.orange],
                                 range:range)
        
        let attr: NSAttributedString = attrString
        
        return attr
    }
    
    @IBOutlet weak var job_Name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
