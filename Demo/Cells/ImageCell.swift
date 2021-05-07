//
//  ImageCell.swift
//  Demo
//
//  Created by Jenish S on 07/05/21.
//

import UIKit

class ImageCell: UITableViewCell {
    @IBOutlet weak var imgBanner: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    internal var aspectConstraint : NSLayoutConstraint? {
        didSet {
            if oldValue != nil {
                imgBanner.removeConstraint(oldValue!)
            }
            if aspectConstraint != nil {
                imgBanner.addConstraint(aspectConstraint!)
            }
        }
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        aspectConstraint = nil
    }
    func setCustomImage(image : UIImage) {
        let aspect = image.size.width / image.size.height /// Acording to image height and width we are creating ratio of image and apply it to multiplyer.
        let constraint = NSLayoutConstraint(item: imgBanner ?? UIImageView(), attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: imgBanner, attribute: NSLayoutConstraint.Attribute.height, multiplier: aspect, constant: 0.0)
        constraint.priority = UILayoutPriority(rawValue: 999)
        aspectConstraint = constraint
        imgBanner.image = image
    }
}
