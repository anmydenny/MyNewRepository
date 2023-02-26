//
//  HomeViewModel.swift
//  Ecomerse
//
//  Created by anmy on 24/02/23.
//

import Foundation
import Alamofire

protocol PassHomeData {
   func passData(categoryList: [HomeDataValues],bannerArray: [HomeDataValues],productsList: [HomeDataValues])
}

class HomeViewModel: NSObject {
    
    var homeList: HomeModel?
    var passHomeDataDelegate: PassHomeData?
    var categoryList: [HomeDataValues] = []
    var bannerArray: [HomeDataValues] = []
    var productsList: [HomeDataValues] = []
    
    func fetchData(){
        WebHandler.sharedInstance.parseData(method: .get, api: "69ad3ec2-f663-453c-868b-513402e515f0", params: nil, encoding: JSONEncoding.default) { responseData, error in
            do{
                if let data = responseData{
                    let result = try JSONDecoder().decode(HomeModel.self, from: data)
                    self.homeList = result
                    for categories in 0..<(self.homeList?.homeData?.count ?? 0) {
                        if self.homeList?.homeData?[categories].type == "category"{
                            self.categoryList = self.homeList?.homeData?[categories].values ?? []
                        }
                        if self.homeList?.homeData?[categories].type == "banners"{
                            self.bannerArray = self.homeList?.homeData?[categories].values ?? []
                        }
                        if self.homeList?.homeData?[categories].type == "products"{
                            self.productsList = self.homeList?.homeData?[categories].values ?? []
                        }
                    }
                    self.passHomeDataDelegate?.passData(categoryList: self.categoryList, bannerArray: self.bannerArray, productsList: self.productsList)
                }
            }catch{
                
            }
        }
    }
}
