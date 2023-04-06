//
//  FavouritesCell.swift
//  MovieChallenge
//
//  Created by Matthew Corry on 6/4/2023.
//

import UIKit
import Combine

class FavouritesCell: UITableViewCell {
    var VC: Favourites?
    var data: movieViewModel! {
        didSet {
            countryLabel.text = data.title
            releaseDateLabel.text = data.release_date
            data.isFavourite == false ? setFavImage(image: UIImage(systemName: "heart")!) : setFavImage(image: UIImage(systemName: "heart.fill")!)
            if let imageData = data.poster_image { posterImage.loadImageUsingCacheWithUrlString("\(Search.imageUrl)w185\(imageData)")  }
        }
    }
    @Published private (set) var favUIImage: UIImage = UIImage(systemName: "heart")!
    var cancellables = Set<AnyCancellable>()
    func setFavImage(image: UIImage)  { favUIImage = image }
    @objc func bind() { $favUIImage.sink { self.favouritImage.setImage($0, for: .normal) }.store(in: &cancellables) }
       
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
       
        favouritImage.topAnchor.constraint(equalTo: releaseDateLabel.bottomAnchor, constant: 20).isActive = true
        favouritImage.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        favouritImage.widthAnchor.constraint(equalToConstant: 40).isActive = true
        favouritImage.heightAnchor.constraint(equalToConstant: 40).isActive = true
        bind()
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        self.contentView.isUserInteractionEnabled = true
        addSubview(countryLabel)
        addSubview(releaseDateLabel)
        addSubview(posterImage)
        addSubview(favouritImage)
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
    lazy var favouritImage: UIButton = {
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
            button.addTarget(self, action: #selector(remove), for: .touchUpInside)
        return button
    }()
    @objc func remove() {
        var bool = data.isFavourite; bool.toggle();
        VC?.removeFromFavourites(cell: self, bool: bool)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
