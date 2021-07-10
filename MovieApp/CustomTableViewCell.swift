//
//  CustomTableViewCell.swift
//  MovieApp
//
//  Created by Bhupender Rawat on 10/07/21.
//

import UIKit

protocol CustomTableViewCellDelegator {
    func callSegueFromCell(indexPath: IndexPath)
}

class CustomTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var imagePreview: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var bookButton: UIButton!
    
    var delegate: CustomTableViewCellDelegator?
    var indexPath: IndexPath?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    @IBAction func bookButtonClicked(_ sender: Any) {
        delegate?.callSegueFromCell(indexPath: indexPath!)
    }
}
