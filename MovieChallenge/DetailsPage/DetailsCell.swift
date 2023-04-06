//
//  DetailsCell.swift
//  MovieChallenge
//
//  Created by Matthew Corry on 6/4/2023.
//

import UIKit

class DetailsCell: UITableViewCell {
    
    var homeVC: Home?
    var data: movieViewModel! {
        didSet {
            movieLabel.text = data.title
            releaseDateLabel.text = data.release_date
            overViewDetailsLabel.text = data.overview
            voteLabel.text = data.vote_average
            voteCountLabel.text = data.vote_count
            if let imageData = data.poster_image { posterImage.loadImageUsingCacheWithUrlString("\(Search.imageUrl)w185\(imageData)") }
            if let backgroundImage = data.backdrop_image { backdropImage.loadImageUsingCacheWithUrlString("\(Search.imageUrl)w500\(backgroundImage)")  }
        }
    }
    
    override func layoutSubviews() {
        backdropImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        backdropImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        backdropImage.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        backdropImage.heightAnchor.constraint(equalToConstant: 220).isActive = true
        
        posterImage.topAnchor.constraint(equalTo: backdropImage.bottomAnchor, constant: -30).isActive = true
        posterImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        posterImage.widthAnchor.constraint(equalToConstant: 120).isActive = true
        posterImage.heightAnchor.constraint(equalToConstant: 180).isActive = true
        
        movieLabel.topAnchor.constraint(equalTo: backdropImage.bottomAnchor, constant: 20).isActive = true
        movieLabel.leftAnchor.constraint(equalTo: posterImage.rightAnchor, constant: 20).isActive = true
        movieLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        movieLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        releaseDateLabel.topAnchor.constraint(equalTo: movieLabel.bottomAnchor, constant: 20).isActive = true
        releaseDateLabel.leftAnchor.constraint(equalTo: movieLabel.leftAnchor, constant: 0).isActive = true
        releaseDateLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        releaseDateLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        borderLabel.topAnchor.constraint(equalTo: posterImage.bottomAnchor, constant: 20).isActive = true
        borderLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        borderLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        borderLabel.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        overViewTitleLabel.topAnchor.constraint(equalTo: borderLabel.bottomAnchor, constant: 20).isActive = true
        overViewTitleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        overViewTitleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        overViewTitleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
       
        overViewDetailsLabel.topAnchor.constraint(equalTo: overViewTitleLabel.bottomAnchor, constant: 20).isActive = true
        overViewDetailsLabel.leftAnchor.constraint(equalTo: overViewTitleLabel.leftAnchor, constant: 0).isActive = true
        overViewDetailsLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true

        voteLabel.topAnchor.constraint(equalTo: releaseDateLabel.bottomAnchor, constant: 20).isActive = true
        voteLabel.leftAnchor.constraint(equalTo: movieLabel.leftAnchor, constant: 0).isActive = true
        voteLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        starImage.centerYAnchor.constraint(equalTo: voteLabel.centerYAnchor, constant: 0).isActive = true
        starImage.leftAnchor.constraint(equalTo: voteLabel.rightAnchor, constant: 5).isActive = true
        starImage.widthAnchor.constraint(equalToConstant: 20).isActive = true
        starImage.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        voteCountLabel.centerYAnchor.constraint(equalTo: voteLabel.centerYAnchor, constant: 0).isActive = true
        voteCountLabel.leftAnchor.constraint(equalTo: voteLabel.rightAnchor, constant: 30).isActive = true
        voteCountLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        self.contentView.isUserInteractionEnabled = true
        addSubview(backdropImage)
        addSubview(movieLabel)
        addSubview(releaseDateLabel)
        addSubview(posterImage)
        addSubview(borderLabel)
        addSubview(overViewTitleLabel)
        addSubview(overViewDetailsLabel)
        addSubview(voteLabel)
        addSubview(starImage)
        addSubview(voteCountLabel)
    
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    let backdropImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleToFill
        imageView.layer.zPosition = 1
        return imageView
    }()
    let posterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleToFill
        imageView.layer.zPosition = 2
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 7.5
        return imageView
    }()
    var movieLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.layer.zPosition = 2
        label.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.bold)
        label.textColor = UIColor.black
        label.backgroundColor = UIColor.clear
        label.sizeToFit()
        label.clipsToBounds = true
        label.numberOfLines = 2
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
    var borderLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.zPosition = 2
        label.backgroundColor = UIColor.lightGray
        label.clipsToBounds = true
        return label
    }()
    var overViewTitleLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.text = "Overview"
        label.layer.zPosition = 2
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.bold)
        label.textColor = UIColor.black
        label.backgroundColor = UIColor.clear
        label.clipsToBounds = true
        return label
    }()
    var overViewDetailsLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.layer.zPosition = 2
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.bold)
        label.textColor = UIColor.myGray
        label.backgroundColor = UIColor.clear
        label.numberOfLines = 0
        label.clipsToBounds = true
        return label
    }()
    var voteLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.layer.zPosition = 2
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.bold)
        label.textColor = UIColor.black
        label.backgroundColor = UIColor.clear
        label.clipsToBounds = true
        return label
    }()
    var starImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.tintColor = .black
        imageView.image = UIImage(systemName: "star.fill")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleToFill
        imageView.layer.zPosition = 2
        return imageView
    }()
    lazy var voteCountLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.layer.zPosition = 2
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        label.textColor = UIColor.black
        label.backgroundColor = UIColor.clear
        return label
    }()
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
