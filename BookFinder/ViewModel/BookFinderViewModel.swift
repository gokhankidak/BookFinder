//
//  BookFinderViewModel.swift
//  BookFinder
//
//  Created by Gökhan Kıdak on 16.11.2023.
//

import Foundation

protocol BookFinderViewModelProtocol{
    
    var bookItems : [BookItem] { get set }
    var dataService : DataServiceProtocol{get}

    func fetchItem(search : String,response: @escaping ([BookItem]) -> Void) -> Void
}

class BookFinderViewModel : BookFinderViewModelProtocol {
    
    lazy var bookItems: [BookItem] = []
    var dataService: DataServiceProtocol = BookFinderDataService()
    
    func fetchItem(search : String,response : @escaping ([BookItem]) -> Void){
        dataService.fectAllItems(search: search, onFail: onFail,onSuccess:{
            [weak self] bookItems in
            self?.onSuccess(bookItems: bookItems)
            response(bookItems)
        })
    }
    
    func onSuccess(bookItems : [BookItem]){
        self.bookItems = bookItems
    }
    
    func onFail(error : String){
        print(error)
    }
}
