//
//  HomeVC.swift
//  Ecomerse
//
//  Created by anmy on 24/02/23.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var categoryCV: UICollectionView!
    @IBOutlet weak var bannerCV: UICollectionView!
    @IBOutlet weak var productsCV: UICollectionView!
    
    var homeViewModel = HomeViewModel()
    var categoryList: [HomeDataValues] = []
    var bannerArray: [HomeDataValues] = []
    var productsList: [HomeDataValues] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeViewModel.fetchData()
        categoryCV.delegate = self
        categoryCV.dataSource = self
        bannerCV.delegate = self
        bannerCV.dataSource = self
        productsCV.delegate = self
        productsCV.dataSource = self
        homeViewModel.passHomeDataDelegate = self
    }
    
}

///MARK: Delegate method to pass data from view model

extension HomeVC: PassHomeData{
    func passData(categoryList: [HomeDataValues],bannerArray: [HomeDataValues],productsList: [HomeDataValues]) {
        self.categoryList = categoryList
        self.bannerArray = bannerArray
        self.productsList = productsList
        categoryCV.reloadData()
        bannerCV.reloadData()
        productsCV.reloadData()
    }
}

///MARK: UICollectionView Delegate and datasource methods
extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoryCV {
            return categoryList.count
        } else if collectionView == bannerCV {
            return bannerArray.count
        } else if collectionView == productsCV {
            return productsList.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == categoryCV{
            let categoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
            categoryCell.categoryLbl.text = categoryList[indexPath.item].name
            /// load image from url
            let url = URL(string: categoryList[indexPath.item].imageUrl ?? "")
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url!)
                DispatchQueue.main.async {
                    categoryCell.categoryImageView.image = UIImage(data: data!)
                }
            }
            return categoryCell
        } else if collectionView == bannerCV{
            let bannerCell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCollectionViewCell", for: indexPath) as! BannerCollectionViewCell
            bannerCell.bannerImgView.layer.cornerRadius = 5
            let url = URL(string: bannerArray[indexPath.item].bannerUrl ?? "")
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url!)
                DispatchQueue.main.async {
                    bannerCell.bannerImgView.image = UIImage(data: data!)
                }
            }
            return bannerCell
        } else if collectionView == productsCV {
            let productsCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductsCollectionViewCell", for: indexPath) as! ProductsCollectionViewCell
            productsCell.productsBgView.layer.cornerRadius = 5
            productsCell.productsBgView.layer.borderWidth = 1
            productsCell.productsBgView.layer.borderColor = UIColor.lightGray.cgColor
            productsCell.offLbl.text = " \(productsList[indexPath.item].offer ?? 0)% OFF"
            productsCell.productNameLbl.text = productsList[indexPath.item].name
            productsCell.productPriceLbl.text = productsList[indexPath.item].actualPrice
            productsCell.productPriceOffLbl.text = productsList[indexPath.item].offerPrice
            let url = URL(string: productsList[indexPath.item].productImage ?? "")
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url!)
                DispatchQueue.main.async {
                    productsCell.productsImgView.image = UIImage(data: data!)
                }
            }
            productsCell.addBtn.layer.cornerRadius = 5
            return productsCell
            
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        if collectionView == categoryCV {
            let cellSize:CGSize = CGSize(width: 130, height: self.categoryCV.frame.height)
            return cellSize
        } else if collectionView == bannerCV {
            let cellSize:CGSize = CGSize(width: self.bannerCV.frame.width - 40, height: self.bannerCV.frame.height)
            return cellSize
        } else if collectionView == productsCV {
            let cellSize:CGSize = CGSize(width: 190, height: self.productsCV.frame.height)
            return cellSize
        }
        return CGSize(width: 0, height: 0)

    }
    
}

