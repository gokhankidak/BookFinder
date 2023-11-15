//
//  BookSearchVC.swift
//  BookFinder
//
//  Created by Gökhan Kıdak on 13.11.2023.
//

import SwiftUI
import SnapKit

final class BookSearchVC : UIViewController,ResultTableViewOutput{
    
    private let bookFinderLabel = UILabel()
    private let searchTextField = UITextField()
    private let resultTableViewPlaceHolder = UITableView()
    
    private let resultTableView = ResultTableView()
    
    private let dataService : DataServiceProtocol = DataService()
    var delegate : ResultTableViewProtocol?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        searchTextField.delegate = self
        resultTableViewPlaceHolder.delegate = resultTableView
        resultTableViewPlaceHolder.dataSource = resultTableView
        resultTableView.delegate = self
    }
    
    func configUI()
    {
        view.addSubview(bookFinderLabel)
        makeLabel()
        view.addSubview(searchTextField)
        makeSearchBox()
        view.addSubview(resultTableViewPlaceHolder)
        makeResultTableView()
    }
    
    fileprivate func makeLabel() {
        bookFinderLabel.text = "Book Finder"
        bookFinderLabel.textColor = .orange
        bookFinderLabel.font = UIFont(name: "Chalkduster", size: 100)
        bookFinderLabel.textAlignment = .center
        bookFinderLabel.adjustsFontSizeToFitWidth = true
        bookFinderLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-40)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(40)
            make.height.equalTo(100)
        }
    }
    
    fileprivate func makeSearchBox() {
        searchTextField.placeholder = "Type author, book name, subject etc..."
        searchTextField.borderStyle = .roundedRect
        
        searchTextField.snp.makeConstraints { make in
            make.top.equalTo(bookFinderLabel.snp.bottom).offset(10)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-40)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(40)
            make.height.equalTo(50)
        }
    }
    
    fileprivate func makeResultTableView() {
        resultTableViewPlaceHolder.backgroundColor = .white
        resultTableViewPlaceHolder.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).offset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-10)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(10)
        }
        resultTableViewPlaceHolder.register(BookCell.self, forCellReuseIdentifier: "bookCell")
        resultTableViewPlaceHolder.rowHeight = 150
        resultTableViewPlaceHolder.isHidden = true
    }
    
    //MARK: Result table
    func onSelected(_ info : VolumeInfo) {
        //TODO
    }
    
    func fetchItems(search : String)
    {
        dataService.fectAllDatas(onSuccess: onSuccess, onFail: onFail, search: search)
    }
    
    func onFail(error : String){
        print("error : \(error)")
    }
    
    func onSuccess(items : [BookItem]){
        resultTableView.update(items: items)
        print("update table view")
        resultTableViewPlaceHolder.reloadData()
    }
}

extension BookSearchVC : UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        resultTableViewPlaceHolder.isHidden = false
        fetchItems(search: textField.text ?? "")
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
