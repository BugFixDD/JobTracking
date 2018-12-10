//
//  ETJobInfoCell.swift
//  九江职业技术学院就业跟踪
//
//  Created by  罗仕宇 on 2018/6/14.
//  Copyright © 2018年 BF. All rights reserved.
//

import UIKit

class ETJobInfoCell: UITableViewCell {

    var viewModel: ETJobInfo? {
        didSet{
            jobName.text = viewModel?.job_name
            jobWage.text = viewModel?.job_wage
            time.text = viewModel?.publish_date
            enterpriseName.text = viewModel?.enterprise_name
        }
    }
    
    
    @IBOutlet weak var jobName: UILabel!
    @IBOutlet weak var jobWage: UILabel!
    @IBOutlet weak var enterpriseName: UILabel!
    @IBOutlet weak var time: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
