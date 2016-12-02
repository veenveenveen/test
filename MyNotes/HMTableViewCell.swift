//
//  HMTableViewCell.swift
//  test
//
//  Created by 黄启明 on 2016/12/1.
//  Copyright © 2016年 huatengIOT. All rights reserved.
//

import UIKit

class HMTableViewCell: UITableViewCell {
    
    //字体大小
    private let titleLabelFontSize: CGFloat = 16
    private let timeLabelFontSize: CGFloat = 14
    
    //控件的上下间隙
    private let margin: CGFloat = 7.0
    //上下两控件间的间隙
    private let centerMargin: CGFloat = 2.0
    //控件距离左边的距离
    private let leftOffset: CGFloat = 17.0
    
    private var titleLabel: UILabel!
    private var timeLabel: UILabel!
    
    var note: Note? {
        //使用属性观察器
        didSet{
            if note != nil {
                titleLabel.text = note!.title
                timeLabel.text = note!.creatTime
            }
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
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //扩展指示器
        accessoryType = .disclosureIndicator
        setupCellUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        //扩展指示器
//        accessoryType = .disclosureIndicator
//        setupCellUI()
    }
    
    //也可通过此方法设值
    func setValueWith(note: Note) {
        titleLabel.text = note.title
        timeLabel.text = note.creatTime
    }
    
    private func setupCellUI() {
//        let height = (contentView.frame.size.height-(margin*2+centerMargin))*0.5
        let height = (cellHeight-(margin*2+centerMargin))*0.5
        let width = contentView.frame.size.width-leftOffset

        titleLabel = UILabel(frame: CGRect(x: leftOffset, y: margin, width: width, height: height))
        titleLabel.backgroundColor = UIColor.clear
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont.systemFont(ofSize: titleLabelFontSize, weight: UIFontWeightBold)
        contentView.addSubview(titleLabel)

        timeLabel = UILabel(frame: CGRect(x: leftOffset, y: margin+height+centerMargin, width: width, height: height))
        timeLabel.backgroundColor = UIColor.clear
        timeLabel.textColor = UIColor.gray
        timeLabel.font = UIFont.systemFont(ofSize: timeLabelFontSize, weight: UIFontWeightLight)
        contentView.addSubview(timeLabel)
    }
}
