//
//  SecondVC.swift
//  Demo
//
//  Created by Jenish S on 07/05/21.
//

import UIKit
import Kingfisher

enum TypeOfList : Int {
    case banner = 1,  productOnly, productWithPrice
}

class SecondVC: UIViewController {
    @IBOutlet weak var tblDetails: UITableView! {
        didSet {
            tblDetails.estimatedRowHeight = 100
            tblDetails.rowHeight = UITableView.automaticDimension
            tblDetails.register(UINib(nibName: String(describing: ImageCell.self), bundle: nil), forCellReuseIdentifier: String(describing: ImageCell.self))
        }
    }
    internal var arrayOFData : [M_List] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadJson()
        // Do any additional setup after loading the view.
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
extension SecondVC {
   private func loadJson() {
        if let path = Bundle.main.path(forResource: "test", ofType: "json") {
            do {
                  let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                    let objects = parsingManager<M_DetailsData>().parse(from: data)
                if objects?.status == "200" {
                    self.arrayOFData = objects?.result?.list ?? []
                    self.tblDetails.reloadData()
                }
              } catch {
                   // handle error
              }
        }
    }
}
extension SecondVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.arrayOFData.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let data = self.arrayOFData[section]
        switch data.type {
        case .banner:
            return 1
        case .productOnly:
            return data.gridItem?.count != 0 ? 1 : 0
        default:
            return data.gridItem?.count ?? 0
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = self.arrayOFData[indexPath.section]
        switch data.type {
        case .banner:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ImageCell.self), for: indexPath) as? ImageCell else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            if let url = URL(string: data.bannerImage ?? "") {
                KingfisherManager.shared.retrieveImage(with: ImageResource(downloadURL: url), options: nil, progressBlock: nil) { result in
                        switch result {
                        case .success(let value):
                            //print("Image: \(value.image). Got from: \(value.cacheType)")
                            tableView.beginUpdates()
                            cell.setCustomImage(image: value.image)
                            tableView.endUpdates()
                        case .failure(let error):
                            print("Error: \(error)")
                        }
                    }
            }
            return cell
        case .productWithPrice:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ProductCell.self), for: indexPath) as? ProductCell else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            if let object = data.gridItem?[indexPath.row] {
                cell.setValue(obj: object)
            }
            return cell
        case .productOnly:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ProductCategoryCell.self) , for: indexPath) as? ProductCategoryCell else {
                return UITableViewCell()
            }
            cell.loadData(data: data.gridItem ?? [], numberOFItem: data.gridLength ?? 2)
            return cell
        }
    }
}

/*extension SecondVC : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.arrayOFData.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let data = self.arrayOFData[section]
        if data.type == .banner {
            return 1
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let data = self.arrayOFData[indexPath.section]
        switch data.type {
        case .banner:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ImageCollectionCell.self), for: indexPath) as? ImageCollectionCell else {
                return UICollectionViewCell()
            }
            
            
            if let url = URL(string: data.bannerImage ?? "") {
                KingfisherManager.shared.retrieveImage(with: ImageResource(downloadURL: url), options: nil, progressBlock: nil) { result in
                        switch result {
                        case .success(let value):
                            //print("Image: \(value.image). Got from: \(value.cacheType)")
                            cell.setCustomImage(image: value.image)
                        case .failure(let error):
                            print("Error: \(error)")
                        }
                    }
            }
            return cell
        default:
            return UICollectionViewCell()
        }
        
    }
    
    
}*/
