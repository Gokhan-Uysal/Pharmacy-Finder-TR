//
//  PharmacyDataSource.swift
//  PharmacyFinder
//
//  Created by Gökhan Uysal on 22.11.2022.
//

import Foundation

class PharmacyDataSource{
    
    var cityList: [City] = []
    var regionList: [Region] = []
    var pharmacyList: [Pharmacy] = []
    
    var pharmacyDelegate: PharmacyDelegate?
    
    private let baseURL = "https://koc.api.staging.tarentum.io"
    
    func fetchCityData(){
        let seassion = URLSession.shared
        if
            let url: URL = URL(string: "\(baseURL)/city")
        {
            var request: URLRequest = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            let callback = seassion.dataTask(with: request){
                cityData , response , error in
                if (error != nil){
                    return
                }
                if
                    let data = cityData
                {
                    do{
                        let decoder = JSONDecoder()
                        self.cityList = try decoder.decode([City].self, from: data)
                        DispatchQueue.main.async {
                            self.pharmacyDelegate?.cityDataLoaded()
                        }
                        print(self.cityList)
                    }
                    catch{
                        print("Error in decoding data")
                    }
                }
            }
            callback.resume()
        }
    }
    
    func fetchRegionWithId(id: Int){
        let seassion = URLSession.shared
        if
            let url: URL = URL(string: "\(baseURL)/city/\(id)/region")
        {
            var request: URLRequest = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            let callback = seassion.dataTask(with: request){
                regionData , response , error in
                if (error != nil){
                    return
                }
                if
                    let data = regionData
                {
                    do{
                        let decoder = JSONDecoder()
                        self.regionList = try decoder.decode([Region].self, from: data)
                        DispatchQueue.main.async {
                            self.pharmacyDelegate?.regionDataLoaded()
                        }
                        print(self.regionList)
                    }
                    catch{
                        print("Error in decoding data")
                    }
                }
            }
            callback.resume()
        }
    }
    
    func fetchPharmaciesWithId(id: String){
        let seassion = URLSession.shared
        if
            let url: URL = URL(string: "\(baseURL)/region/\(id)/pharmacy")
        {
            var request: URLRequest = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            let callback = seassion.dataTask(with: request){
                pharmacyData , response , error in
                if (error != nil){
                    return
                }
                if
                    let data = pharmacyData
                {
                    do{
                        let decoder = JSONDecoder()
                        self.pharmacyList = try decoder.decode([Pharmacy].self, from: data)
                        DispatchQueue.main.async {
                            self.pharmacyDelegate?.pharmacyDataLoaded()
                        }
                        print(self.pharmacyList)
                    }
                    catch{
                        print("Error in decoding data")
                    }
                }
            }
            callback.resume()
        }
    }
    
    func fetchPharmacyWithId(id: String){
        let seassion = URLSession.shared
        if
            let url: URL = URL(string: "\(baseURL)/pharmacy/\(id)")
        {
            var request: URLRequest = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            let callback = seassion.dataTask(with: request){
                pharmacyData , response , error in
                if (error != nil){
                    return
                }
                if
                    let data = pharmacyData
                {
                    do{
                        let decoder = JSONDecoder()
                        let pharmacyDetail = try decoder.decode(PharmacyDetail.self, from: data)
                        DispatchQueue.main.async {
                            self.pharmacyDelegate?.pharmacyDetailedDataLoaded(pharmacyData: pharmacyDetail)
                        }
                        print(self.pharmacyList)
                    }
                    catch{
                        print("Error in decoding data")
                    }
                }
            }
            callback.resume()
        }
    }
    
    func getCityWithId(for id:Int) -> City?{
        if id <= cityList.count{
            return cityList[id]
        }
        return nil
    }
    func getRegionWithId(for id:Int) -> Region?{
        if id <= regionList.count{
            return regionList[id]
        }
        return nil
    }
    
    func getPharmacyWithId(for id:Int) -> Pharmacy?{
        if id <= pharmacyList.count{
            return pharmacyList[id]
        }
        return nil
    }
    
    func getCityCount() -> Int{
        return cityList.count
    }
    
    func getRegionCount() -> Int{
        return regionList.count
    }
    
    func getPharmacyCount() -> Int{
        return pharmacyList.count
    }
}
