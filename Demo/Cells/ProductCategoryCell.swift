//
//  ProductCategoryCell.swift
//  Demo
//
//  Created by Jenish S on 07/05/21.
//

import UIKit
import Kingfisher
class ProductCategoryCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionViewLayout?.estimatedItemSize = .zero//CGSize(width: 1, height: 1)
            selectionStyle = .none
            collectionView.backgroundColor = .separator
        }
    }
    var collectionViewLayout: UICollectionViewFlowLayout? {
            return collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        }
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    private var minimumSpacing = 1
    private var edgeInsetPadding = 2
    private var numberOfItemsInRow = 0
    private var items : [M_GridItem] = []

    // MARK: -
        // MARK: UIView functions
        override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
            collectionView.layoutIfNeeded()

            let topConstraintConstant = contentView.constraint(byIdentifier: "topAnchor")?.constant ?? 0
            let bottomConstraintConstant = contentView.constraint(byIdentifier: "bottomAnchor")?.constant ?? 0
            let trailingConstraintConstant = contentView.constraint(byIdentifier: "trailingAnchor")?.constant ?? 0
            let leadingConstraintConstant = contentView.constraint(byIdentifier: "leadingAnchor")?.constant ?? 0

            collectionView.frame = CGRect(x: 0, y: 0, width: targetSize.width - trailingConstraintConstant - leadingConstraintConstant, height: 1)

            let size = collectionView.collectionViewLayout.collectionViewContentSize
            let newSize = CGSize(width: size.width, height: size.height + topConstraintConstant + bottomConstraintConstant)
            return newSize
        }
    func loadData(data : [M_GridItem], numberOFItem : Int) {
        self.items = data
        self.numberOfItemsInRow = numberOFItem
        self.collectionView.reloadData()
        collectionView.layoutIfNeeded()
    }
}

extension ProductCategoryCell : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let obj = self.items[indexPath.item]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ImageCollectionCell.self), for: indexPath) as? ImageCollectionCell else {
            return UICollectionViewCell()
        }
        cell.backgroundColor = .white
        cell.lblCategory.text = obj.name
        cell.imgBanner.kf.setImage(with: URL(string: obj.image ?? ""))
        return cell
    }
    
    
}
extension ProductCategoryCell: UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width   / CGFloat(numberOfItemsInRow)) - CGFloat(minimumSpacing)
            //let width = (Int(UIScreen.main.bounds.size.width) - (numberOfItemsInRow - 1) * minimumSpacing - edgeInsetPadding) / numberOfItemsInRow
            return CGSize(width: width, height: width + 30)
        }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(minimumSpacing)
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return CGFloat(minimumSpacing)
        }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//            let inset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
//        edgeInsetPadding = Int(inset.left + inset.right)
//            return inset
//        }
}
