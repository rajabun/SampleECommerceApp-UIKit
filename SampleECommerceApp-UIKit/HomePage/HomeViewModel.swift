//
//  HomeViewModel.swift
//  SampleECommerceApp-UIKit
//
//  Created by Muhammad Rajab Priharsanto on 26/06/21.
//

import Foundation

class HomeViewModel {
    let request = HomeRequest()
    var listOfCategories = [CategoryModel]()
    var listOfProductPromo = [ProductPromoModel]()
    var filteredProduct: [ProductPromoModel]?
    
    func getData (completion: @escaping(Result<[HomeModel], APIError>) -> Void)
    {
        let dataTask = URLSession.shared.dataTask(with: request.resourceURL)
        {data,_,_ in
            guard let jsonData = data
            else
            {
                completion(.failure(.noDataAvailable))
                return
            }
            do
            {
                let decoder = JSONDecoder()
                let homeResponse = try decoder.decode([HomeModel].self, from: jsonData)
                DispatchQueue.main.async
                {
                    completion(.success(homeResponse))
                    print("completion berhasil")
                }
                
            }
            catch
            {
                completion(.failure(.canNotProcessData))
                print(error)
            }
        }
        dataTask.resume()
       print("getdata berhasil")
    }
}
