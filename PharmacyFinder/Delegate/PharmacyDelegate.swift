//
//  PharmacyDelegate.swift
//  PharmacyFinder
//
//  Created by Gökhan Uysal on 22.11.2022.
//

import Foundation

protocol PharmacyDelegate{
    func cityDataLoaded()
    func regionDataLoaded()
    func pharmacyDataLoaded()
    func pharmacyDetailedDataLoaded(pharmacyData: PharmacyDetail)
}

extension PharmacyDelegate{
    func cityDataLoaded(){}
    func regionDataLoaded(){}
    func pharmacyDataLoaded(){}
    func pharmacyDetailedDataLoaded(pharmacyData: PharmacyDetail){}
}
