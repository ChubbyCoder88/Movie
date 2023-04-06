//
//  Home.swift
//  MovieChallenge
//
//  Created by Matthew Corry on 6/4/2023.
//

import UIKit
import Combine

class Home: UIViewController {
    
    let HomeCellID = "HomeCellID"
    @Published private (set) var data0 = [movieViewModel]()
    var data1 = [movieViewModel]()
    var tableView = tableCustom()
    let transform = Transform()
    var tableViewBottomAnchor: NSLayoutConstraint?
    var usersSubscriper: AnyCancellable?
    var store = Set<AnyCancellable>()
    var mainCor: MainCoordinator
    init(coordinator: MainCoordinator) {
        self.mainCor = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async { self.tableView.reloadData() }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.myBlue
        setUpView()
        setUpTableViewDetails()
        setUpTextFieldPublisher()
        bind()
        let rightButton = UIBarButtonItem(image: UIImage(systemName: "heart.fill"), style: .plain, target: self, action: #selector(favourites))
        rightButton.tintColor = .red
        navigationItem.rightBarButtonItem = rightButton
        
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(modifyData(_:)), name: Notification.Name("ModifyData"), object: nil)
    }
    @objc func bind() {
        $data0.sink { $0.count == 0 ? self.noResultsLabelIsHidden(b: false) : self.noResultsLabelIsHidden(b: true) }.store(in: &cancellables)
    }
    @objc func noResultsLabelIsHidden(b: Bool) { noResultsLabel.isHidden = b }
    @objc func favourites() { self.mainCor.goToFavourites() }

    // MARK: API CALL
    @objc func apiCall(text: String) {
        usersSubscriper = callAPIPublisher(text: text)
            .sink(receiveCompletion: { finished in
                switch finished {
                case .failure(let error):
                error.localizedDescription == "The Internet connection appears to be offline." ? Alert.show(title: "Internet is offline", message: "Please try later", vc: self) : print("")
                case .finished: print("finished")
                }
            }, receiveValue: { (data) in
                self.refactorData(data: data)
            })
    }
    func callAPIPublisher<T: Codable>(text: String) -> AnyPublisher<T, Error> {
        var url = URL(string: "\(Search.urlString)\(Search.apiKey)&query=\(text)")!
        return DataManagerGenerics().apiCallGeneric(url: url, text: text)
    }
 
    // MARK: REFACTOR DATA
    func refactorData(data: moviesStruct) {
                transform.refactorAndInsertIntoViewModel(data: data).sink { [weak self] finished in
                    switch finished {
                    case .failure(.message(let error)): self?.callFailureAlert()
                    case .finished:  print("finished")
                    }
                } receiveValue: { (data) in
                        self.data0 = data;
                        self.data1 = self.data0
                        DispatchQueue.main.async { self.tableView.reloadData() }
                }.store(in: &store)
    }
    func callFailureAlert() { Alert.show(title: "There was an issue", message: "Please try later", vc: self) }

    // MARK: FAVOURITES
    @objc func modifyData(_ notification: NSNotification) {
        if let title = notification.userInfo?["modify"] as? String {
                    if let firstMatch = data0.firstIndex(where: { $0.title == title } ) {
                        data0[firstMatch].isFavourite = false
                    }
            }
    }
    @objc func updateFavourites(cell: UITableViewCell, bool: Bool) {
        guard let index = tableView.indexPath(for: cell) else { return }
        let cell = tableView.cellForRow(at: index) as! HomeCell
        data0[index.row].isFavourite = bool
        let data = data0[index.row]
        bool == true ? appendData(data: data) : removeFavouriteFromArray(data: data)
        DispatchQueue.main.async { self.tableView.reloadData() }
    }
    func appendData(data: movieViewModel) {  favData0.append(data) }
    func removeFavouriteFromArray(data: movieViewModel) {
        if let firstMatch = favData0.firstIndex(where: { $0.title == data.title } ) { favData0.remove(at: firstMatch) }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) { view.endEditing(true) }

    // MARK: SEARCH
    var cancellables = Set<AnyCancellable>()
    func setUpTextFieldPublisher() {
        generalTextField.textPublisher.sink { value in
            self.textInput(text: value)
        }.store(in: &cancellables)
    }
    func textInput(text: String) {
        if text == "" { clearText(); return }
        var t = text.replacingOccurrences(of: " ", with: "+")
        DispatchQueue.main.async { self.apiCall(text: t) }
    }
    @objc func clearText() {
        self.generalTextField.text = ""
        DispatchQueue.main.async { self.data0 = []; self.tableView.reloadData() }
    }

    lazy var generalTextField: UITextField = {
         let field = UITextField()
         field.attributedPlaceholder = NSAttributedString(string: "Search", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
         field.backgroundColor = .clear
         field.autocapitalizationType = UITextAutocapitalizationType.none
         field.translatesAutoresizingMaskIntoConstraints = false
         field.layer.zPosition = 2
         field.textColor = UIColor.black
         field.font = UIFont(name: "Arial", size: 16)
         field.textAlignment = NSTextAlignment.left
         field.returnKeyType = .done
         field.keyboardType = .default
         field.keyboardAppearance = .light
         field.addTarget(self, action: #selector(doNothing), for: .editingDidEndOnExit)
         return field
       }()
       @objc func doNothing() {}
       lazy var SearchWhiteBackground: UILabel = {
           let label = UILabel()
           label.backgroundColor = .white
           label.translatesAutoresizingMaskIntoConstraints = false
           label.layer.zPosition = 1
           label.clipsToBounds = true
           label.layer.borderWidth = 1
           let color = UIColor.gray
           label.layer.borderColor = color.cgColor
           label.layer.cornerRadius = 5
           return label
       }()
       lazy var xForsearchImage: UIButton = {
           let button = UIButton(type: .custom)
           button.backgroundColor = .white
           button.setImage(UIImage(systemName: "clear"), for: .normal)
           button.tintColor = UIColor.black
           button.translatesAutoresizingMaskIntoConstraints = false
           button.addTarget(self, action: #selector(clearText), for: .touchUpInside)
           button.layer.masksToBounds = true
           button.contentMode = .scaleAspectFit
           button.layer.zPosition = 2
           return button
       }()
       let searchImage: UIImageView = {
           let imageView = UIImageView()
           imageView.backgroundColor = .white
           imageView.image = UIImage(systemName: "magnifyingglass")
           imageView.translatesAutoresizingMaskIntoConstraints = false
           imageView.layer.masksToBounds = true
           imageView.tintColor = UIColor.myBlue
           imageView.contentMode = .scaleAspectFit
           imageView.layer.zPosition = 2
           return imageView
       }()
    var noResultsLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "There are no \nresults to display"
        label.layer.zPosition = 2
        label.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.regular)
        label.textColor = UIColor.black
        label.backgroundColor = UIColor.clear
        label.sizeToFit()
        label.clipsToBounds = true
        label.numberOfLines = 0
        return label
    }()
}
 


