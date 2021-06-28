//
//  DetailProductPageViewController.swift
//  SampleECommerceApp-UIKit
//
//  Created by Muhammad Rajab Priharsanto on 28/06/21.
//

import UIKit
import SDWebImage

class DetailProductPageViewController: UIViewController {
    
    @IBOutlet weak var detailProductImage: UIImageView!
    @IBOutlet weak var detailProductTitle: UILabel!
    @IBOutlet weak var detailProductDescription: UILabel!
    @IBOutlet weak var detailProductPrice: UILabel!
    @IBOutlet weak var lovedButton: UIButton!
    
    let viewModel = DetailProductPageViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let imageUrl = URL(string: viewModel.productArray?.imageUrl ?? "") else {return}
        detailProductImage.sd_setImage(with: imageUrl, completed: nil)
        detailProductTitle.text = viewModel.productArray?.title
        detailProductDescription.text = viewModel.productArray?.description
        detailProductPrice.text = viewModel.productArray?.price
        guard let loved = viewModel.productArray?.loved else { return }
        if loved > 0 {
            lovedButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            lovedButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }

    func alertForShareButton() {
        let alert = UIAlertController(title: "Share this message to friend?", message: "", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))

        self.present(alert, animated: true)
    }
    
    func alertForLoveButton() {
        let alert = UIAlertController(title: "Liked this product", message: "", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    @IBAction func shareButton(_ sender: Any) {
        alertForShareButton()
    }
    @IBAction func lovedButton(_ sender: Any) {
        alertForLoveButton()
    }
    
    @IBAction func buyButton(_ sender: Any) {
//        let defaults = UserDefaults.standard.set(viewModel.productArray, forKey: "productArray")
    }
}
