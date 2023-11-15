//
//  Service.swift
//  BookFinder
//
//  Created by Gökhan Kıdak on 14.11.2023.
//

import Alamofire

enum Path : String{
    case base = "https://www.googleapis.com/books/v1/volumes"
    case requestPrefix = "?q="
    
}

protocol DataServiceProtocol{
    
    func fectAllDatas(onSuccess: @escaping ([BookItem]) -> Void,onFail : @escaping (String) -> Void,search : String)
}

struct DataService : DataServiceProtocol{
    func fectAllDatas(onSuccess: @escaping ([BookItem]) -> Void,onFail : @escaping (String) -> Void,search : String){
        
        let url = "\(Path.base.rawValue)\(Path.requestPrefix.rawValue)\(search)"
        AF.request(url, method: .get).validate().responseDecodable(of: BookVolume.self){(response) in
            guard let item = response.value else{
                onFail(response.debugDescription)
                return
            }
            onSuccess(item.items)
        }
    }
}
