//
//  ETWeeknoteCell.swift
//  九江职业技术学院就业跟踪
//
//  Created by 树清吴 on 2018/6/15.
//  Copyright © 2018年 BF. All rights reserved.
//

import UIKit

/// 周记cell
class ETWeeknoteCell: UITableViewCell {

    /// 标题label
    @IBOutlet weak var titleLbl: UILabel!
    /// 内容label
    @IBOutlet weak var contentLbl: UILabel!
    /// 时间label
    @IBOutlet weak var timeLbl: UILabel!
    
    /// 周记模型
    var model: ETWeeknoteModel? {
        didSet {
            titleLbl.text = model?.title
            contentLbl.text = model?.content
            timeLbl.text = model?.createtime
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
