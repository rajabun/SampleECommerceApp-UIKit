//
//  HomeViewController.swift
//  SampleECommerceApp-UIKit
//
//  Created by Muhammad Rajab Priharsanto on 26/06/21.
//

import UIKit
import SDWebImage

enum HomeSection: Int {
    case categories = 0
    case productList = 1
}

class HomeViewController: UIViewController {

    @IBOutlet weak var homeCollectionView: UICollectionView!
    var searchController: UISearchController!
    
    let viewModel = HomeViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupComponent()
        fetchData()
        // Do any additional setup after loading the view.
    }
    
    private func setupComponent() {
        homeCollectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        homeCollectionView.register(UINib(nibName: "CategoriesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Categories")
        homeCollectionView.register(UINib(nibName: "ProductListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProductList")
    }

    func fetchData()
    {
        viewModel.getData
        { [weak self] result in
            switch result
            {
            case .failure(let error):
                print(error)
            case .success(let homeData):
                DispatchQueue.main.async
                {
                    self?.viewModel.listOfCategories = homeData.first?.data.category ?? []
                    self?.viewModel.listOfProductPromo = homeData.first?.data.productPromo ?? []
                    print("Total Categories List =", self?.viewModel.listOfCategories.count ?? 0)
                    print("Total Product Promo List =", self?.viewModel.listOfProductPromo.count ?? 0)
                    self?.homeCollectionView.delegate = self
                    self?.homeCollectionView.dataSource = self
                    self?.homeCollectionView.reloadData()
                }
            }
        }
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let height = collectionView.bounds.height
        guard let section = HomeSection(rawValue: indexPath.section) else {
            return .zero
        }
        
        switch section {
        case .categories:
            return CGSize(width: width, height: height/4)
        case .productList:
            return CGSize(width: width, height: height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let section = HomeSection(rawValue: section) else {
            return .zero
        }
        
        switch section {
        case .categories:
            return viewModel.listOfProductPromo.count
        case .productList:
            return viewModel.listOfProductPromo.count
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
//        guard let section = HomeSection(rawValue: indexPath.section) else {
//            return UICollectionViewCell()
//        }
        
//        switch section {
//        case .categories:
//            let cell = homeCollectionView.dequeueReusableCell(withReuseIdentifier: "Categories", for: indexPath) as! CategoriesCollectionViewCell
//            let imageUrl = URL(string: viewModel.listOfCategories[indexPath.row].imageUrl)
//            cell.categoriesImageView.sd_setImage(with: imageUrl, completed: nil)
//            cell.categoriesTitle.text = viewModel.listOfCategories[indexPath.row].name
//            return cell
//        case .productList:
            let cell = homeCollectionView.dequeueReusableCell(withReuseIdentifier: "ProductList", for: indexPath) as! ProductListCollectionViewCell
            let imageUrl = URL(string: viewModel.listOfProductPromo[indexPath.row].imageUrl)
            cell.productListImage.sd_setImage(with: imageUrl, completed: nil)
            cell.productListTitle.text = viewModel.listOfProductPromo[indexPath.row].title
            let loved = viewModel.listOfProductPromo[indexPath.row].loved
            if loved > 0 {
                cell.productListButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            } else {
                cell.productListButton.setImage(UIImage(systemName: "heart"), for: .normal)
            }
            return cell
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "GoToProductDetail", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPath: NSIndexPath = sender as! NSIndexPath
        let destinationVC = segue.destination as! DetailProductPageViewController
        destinationVC.viewModel.productArray = viewModel.listOfProductPromo[indexPath.row]
        
    }

    @IBAction func unwind( _ seg: UIStoryboardSegue) {
        
    }
}

extension HomeViewController: UISearchResultsUpdating {
    func setupSearch() {
        viewModel.filteredProduct = viewModel.listOfProductPromo

        // Initializing with searchResultsController set to nil means that
        // searchController will use this view controller to display the search results
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self

        // If we are using this same view controller to present the results
        // dimming it out wouldn't make sense. Should probably only set
        // this to yes if using another controller to display the search results.
        searchController.dimsBackgroundDuringPresentation = false

        searchController.searchBar.sizeToFit()

        // Sets this view controller as presenting view controller for the search interface
        definesPresentationContext = true
    }
    
    func updateSearchResults(for searchController: UISearchController) {
//        if let searchText = searchController.searchBar.text {
//            viewModel.filteredProduct = searchText.isEmpty ? viewModel.filteredProduct : viewModel.filteredProduct?.filter({(dataString: String) -> Bool in
//                return dataString.rangeOfString(searchText, options: .CaseInsensitiveSearch) != nil
//            })
//
//            homeCollectionView.reloadData()
//        }
    }
}
