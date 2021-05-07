//
//  ViewController.swift
//  Demo
//
//  Created by Jenish S on 07/05/21.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {
    @IBOutlet weak var tblImages: UITableView! {
        didSet {
            tblImages.estimatedRowHeight = 100
            tblImages.rowHeight = UITableView.automaticDimension
            tblImages.register(UINib(nibName: String(describing: ImageCell.self), bundle: nil), forCellReuseIdentifier: String(describing: ImageCell.self))

        }
    }
    private let arrayOfImages : [String] = ["https://images-eu.ssl-images-amazon.com/images/G/31/IMG20/Furniture/EasyCare/November20/Quality-Verified-Banner_1242x450.jpg","https://images-eu.ssl-images-amazon.com/images/G/31/IMG19/Furniture/ClearanceSale/ClearanceStore_1242x450_2._SX1242_CB404678738_.png","https://images-eu.ssl-images-amazon.com/images/G/31/IMG20/Home/BAU/Homemain/XCM_Manual_1500x250_1209699_1077610_1209699_in_home_28_01_20_page_5d027374_166d_466f_9f22_5789bd5e69af_jpg._CB423636511_.jpg","https://images-eu.ssl-images-amazon.com/images/G/31/img18/Lawn_Garden/1500x300-2.jpg","https://images-eu.ssl-images-amazon.com/images/G/31/IMG20/Home/2021/Banners/1500x300_bedsheets.jpg","https://images-na.ssl-images-amazon.com/images/I/71ZtX%2BXF0SL._AC_SX522_.jpg","https://images-eu.ssl-images-amazon.com/images/G/31/img20/Smallappliances/COOP_20/Pigeon/Blendo_banners_final_1242x375.jpg","https://images-eu.ssl-images-amazon.com/images/G/31/IN-hq/2019/img/Kitchen/XCM_Manual_1164463_hotw_kitchenapp_1500x300_Kitchen_XCM_Manual_1164463_KITCHEN_app_1500x300_1555684706_jpg.jpg","https://images-eu.ssl-images-amazon.com/images/G/31/img20/Smallappliances/COOP_20/Havells/Silencio1500x300WLogog.jpg","https://images-eu.ssl-images-amazon.com/images/G/31/img20/AmazonBrands/Space/XCM_Manual_1289645_1491988_in_appliances_nov_1500x300_in-en_53dfff26-8ee5-434b-b6f7-b881ac7d291d.jpg","https://images-eu.ssl-images-amazon.com/images/G/31/img19/SmallAppliance/KITCHEN-VIRTUAL-BUNDLES-INGRESS_1500x300_1575618825.jpg","https://images-eu.ssl-images-amazon.com/images/G/31/img20/kitchen/PremiumTableware/1500x600.jpg","https://images-eu.ssl-images-amazon.com/images/G/31/img20/AmazonBrands/Space/XCM_Manual_1293627_1505941_in_kitchen_sbc_440x460_in-en_f3b4ebf8-834b-49fb-bab3-4e5cace2e4c8.jpg","https://images-eu.ssl-images-amazon.com/images/G/31/img21/kitchen/Amazon-category-banner-2.jpg"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfImages.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ImageCell.self), for: indexPath) as? ImageCell else {
            return UITableViewCell()
        }
        let data = arrayOfImages[indexPath.row]
        if let url = URL(string: data) {
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
    }
}
