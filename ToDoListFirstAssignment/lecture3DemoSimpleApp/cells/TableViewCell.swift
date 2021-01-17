//
//  TableViewCell.swift
//  lecture3DemoSimpleApp
//
//  Created by admin on 06.01.2021.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var edit: UIButton!
    @IBOutlet weak var removeButton: UIButton!
    @IBOutlet weak var subTitleLabel: UILabel!
//    var delegate: SecondViewControllerDelegate?
//
//    var id = 0
//
//    var editCallback: ((_ id: Int) -> Void)?
//    var removeCallback: ((_ id: Int) -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    @IBAction func editAction(_ sender: Any) {
////        delegate?.editItem(id)
//        editCallback?(id)
//    }
//    
//    @IBAction func removeAction(_ sender: Any) {
////        delegate?.removeItem(id)
//        removeCallback?(id)
//
//    }
    
}
