//
//  PeopleCollectionViewCell.swift
//  VMDirectoryAPP
//
//  Created by Admin on 08/07/2022.
//

import UIKit

class PeopleCollectionViewCell: UICollectionViewCell {
 
    private var stackView: UIStackView?
    
    private lazy var imageView: UIImageView =  {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .red
        return imageView
    }()
    
    private lazy var namelbl: UILabel =  {
        let namelbl = UILabel()
        namelbl.backgroundColor = .red
        namelbl.textColor = .white
        namelbl.translatesAutoresizingMaskIntoConstraints = false
        namelbl.text = "test"
        
        return namelbl
    }()
    
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        addItemsToStackView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addItemsToStackView() {
        stackView = UIStackView(arrangedSubviews: [imageView, namelbl])
        stackView?.axis = .vertical
        stackView?.alignment = .fill
        stackView?.distribution = .fill
        stackView?.spacing = 2.0
        stackView?.translatesAutoresizingMaskIntoConstraints = false

        self.contentView.addSubview(stackView!)

    }
    private func setupConstraints() {
        stackView?.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 0.0).isActive = true
        stackView?.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 0.0).isActive = true
        stackView?.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 0.0).isActive = true
        stackView?.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 0.0).isActive = true
        

    }
    
    func setData(staff: People) {
        namelbl.text = staff.firstName + staff.lastName
        setupURLImage(imageURL: staff.avatar)
    }
    
    func setupURLImage(imageURL:String) {
        ImageDownloader.shared.getImage(url: imageURL) { [weak self] data in
            DispatchQueue.main.async {
                self?.imageView.image = UIImage(data: data)
            }
        }
    }
}
