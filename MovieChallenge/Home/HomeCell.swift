//
//  HomeCell.swift
//  MovieChallenge
//
//  Created by Matthew Corry on 6/4/2023.
//

import UIKit
import Combine

class HomeCell: UITableViewCell {
    var homeVC: Home?
    var data: movieViewModel! {
        didSet {
            countryLabel.text = data.title
            releaseDateLabel.text = data.release_date
            data.isFavourite == false ? setFavImage(string: "heart") : setFavImage(string: "heart.fill")
            
            if let imageData = data.poster_image {
                    posterImage.loadImageUsingCacheWithUrlString("\(Search.imageUrl)w185\(imageData)")
            }
            
        }
    }
    @Published private (set) var favUIImage: UIImage = UIImage(systemName: "heart")!
    var cancellables = Set<AnyCancellable>()
    func setFavImage(string: String)  { favUIImage = UIImage(systemName: string)! }
    @objc func bind() { $favUIImage.sink { self.favouriteImage.setImage($0, for: .normal) }.store(in: &cancellables) }
       
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        posterImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        posterImage.widthAnchor.constraint(equalToConstant: 150).isActive = true
        posterImage.heightAnchor.constraint(equalToConstant: 200).isActive = true

        countryLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        countryLabel.leftAnchor.constraint(equalTo: posterImage.rightAnchor, constant: 10).isActive = true
        countryLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        countryLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true

        releaseDateLabel.topAnchor.constraint(equalTo: countryLabel.bottomAnchor, constant: 10).isActive = true
        releaseDateLabel.leftAnchor.constraint(equalTo: countryLabel.leftAnchor, constant: 0).isActive = true
        releaseDateLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        releaseDateLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
       
        favouriteImage.topAnchor.constraint(equalTo: releaseDateLabel.bottomAnchor, constant: 20).isActive = true
        favouriteImage.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        favouriteImage.widthAnchor.constraint(equalToConstant: 40).isActive = true
        favouriteImage.heightAnchor.constraint(equalToConstant: 40).isActive = true
        bind()
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        self.contentView.isUserInteractionEnabled = true
        addSubview(countryLabel)
        addSubview(releaseDateLabel)
        addSubview(posterImage)
        addSubview(favouriteImage)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    let posterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.image = UIImage(systemName: "film")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleToFill
        imageView.layer.zPosition = 2
        return imageView
    }()
    var countryLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.layer.zPosition = 2
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.bold)
        label.textColor = UIColor.black
        label.backgroundColor = UIColor.clear
        label.sizeToFit()
        label.clipsToBounds = true
        label.numberOfLines = 0
        return label
    }()
    var releaseDateLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.layer.zPosition = 2
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.bold)
        label.textColor = UIColor.black
        label.backgroundColor = UIColor.clear
        label.clipsToBounds = true
        return label
    }()
    lazy var favouriteImage: UIButton = {
        let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.backgroundColor = UIColor.clear
            button.setImage(UIImage(systemName: "heart"), for: .normal)
            button.layer.zPosition = 2
            button.clipsToBounds = true
            button.tintColor = .systemRed
            button.alpha = 1.0
            button.contentMode = .scaleToFill
            button.isEnabled = true
            button.addTarget(self, action: #selector(favourites), for: .touchUpInside)
        return button
    }()
    @objc func favourites() {
        var bool = data.isFavourite; bool.toggle();
        homeVC?.updateFavourites(cell: self, bool: bool)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
// small mod
