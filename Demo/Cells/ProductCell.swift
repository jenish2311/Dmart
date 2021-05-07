//
//  ProductCell.swift
//  Demo
//
//  Created by Jenish S on 07/05/21.
//

import UIKit

class ProductCell : UITableViewCell {
    @IBOutlet weak var imageProduct: UIImageView!
    @IBOutlet weak var btnAddList: UIButton! {
        didSet{
            btnAddList.setTitle("ADD TO LIST", for: .normal)
            btnAddList.tintColor = UIColor.systemGreen
        }
    }
    @IBOutlet weak var lblTitle: UILabel! {
        didSet {
            lblTitle.textColor = .black
            lblTitle.numberOfLines = 0
        }
    }
    @IBOutlet weak var lblMRP: UILabel! {
        didSet {
            lblMRP.textColor = .gray
        }
    }
    @IBOutlet weak var lblOurPrice: UILabel! {
        didSet {
            lblOurPrice.textColor = UIColor.systemGreen
        }
    }
    @IBOutlet weak var lblDiscount: UILabel! {
        didSet{
            lblDiscount.textColor = .red
        }
    }
    @IBOutlet weak var btnAddToCart: UIButton! {
        didSet{
            btnAddToCart.setTitle("  ADD TO CART  ", for: .normal)
            btnAddToCart.backgroundColor = UIColor.systemGreen
            btnAddToCart.tintColor = .white
        }
    }
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setValue(obj : M_GridItem) {
        self.lblTitle.text = obj.name
        self.imageProduct.kf.setImage(with: URL(string: obj.image ?? ""))
        if let qty = obj.option?.first {
            self.lblMRP.isHidden = false
            let discount = (qty.mrp ?? 0) - (qty.payablePrice ?? 0)
            if discount != 0 && qty.payablePrice != 0{
                self.lblDiscount.isHidden = false
                self.lblDiscount.text = "Save \(Helper.shared.currency) \(discount)"
            }else{
                self.lblDiscount.isHidden = true
                ///Discount lable is hide when discount value is zero.
            }
            ///Hide Dmart price id payablePrice and MRP same or payable price should be zero
            self.lblOurPrice.isHidden = (qty.payablePrice == 0 || qty.payablePrice == qty.mrp)
            self.lblOurPrice.text = "DMart \(Helper.shared.currency) \(qty.payablePrice ?? 0)"
            
            self.lblMRP.isHidden = qty.mrp == 0 /// it is hide if MRP is zero.
            self.lblMRP.attributedText = nil
            if qty.payablePrice != qty.mrp && qty.payablePrice != 0 {
                /// Stricke throw only display when paybale price and  MRP are not same and payable is not zero.
                self.lblMRP.attributedText = "MRP \(Helper.shared.currency) \(qty.mrp ?? 0)".strikeThrough()
            }else{
                self.lblMRP.text = "MRP \(Helper.shared.currency) \(qty.mrp ?? 0)"
            }
        }else{
            self.lblMRP.isHidden = true
            self.lblDiscount.isHidden = true
            self.lblOurPrice.isHidden = true
        }
    }
}
