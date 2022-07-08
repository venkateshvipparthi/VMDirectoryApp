//
//  PeoplesViewController.swift
//  StaffsDirectory
//
//  Created by Admin on 08/07/2022.
//

import UIKit

protocol PeoplesViewable: AnyObject {
    func refreshUI()
    func showError()
}

class PeoplesViewController: UIViewController {
   
     private var collectionView: UICollectionView = {
         
         let layout = UICollectionViewFlowLayout()
         layout.scrollDirection = .vertical 
         layout.minimumLineSpacing = 5
         layout.minimumInteritemSpacing = 5
         let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(PeopleCollectionViewCell.self, forCellWithReuseIdentifier:"cell")
        

        return collectionView
    }()
    
     private var acitivtyIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    
    let peopleViewModel:PeopleViewModelType
    let coordinator: PeoplesCoordinatoryType
    
    init(peopleViewModel:PeopleViewModelType,coordinator: PeoplesCoordinatoryType ) {
        self.peopleViewModel = peopleViewModel
        self.coordinator = coordinator
        
        super.init(nibName:nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        peopleViewModel.delegate = self
        collectionView.dataSource = self
        collectionView.delegate = self
        setupUI()
         
        acitivtyIndicator.startAnimating()
        peopleViewModel.fetchPeoples(baseUrl: EndPoint.baseUrl, path: Path.people)
        
        
    }
    
    private func setupUI() {
        self.view.addSubview(collectionView)
        self.view.addSubview(acitivtyIndicator)
        self.view.backgroundColor = .white
        setupConstraints()
        
        self.navigationItem.title = "People"
    }
    
    private func setupConstraints() {
        collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0.0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0.0).isActive = true
        collectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0.0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0.0).isActive = true
        
        acitivtyIndicator.widthAnchor.constraint(equalToConstant: 50.0).isActive = true
        acitivtyIndicator.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        
        acitivtyIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        acitivtyIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true

    }
}
extension PeoplesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
                if let staff = peopleViewModel.getPeopleDetailFor(index: indexPath.row) {
                    coordinator.navigatToPeopleDetails(people: staff)
                }
    }
}

extension PeoplesViewController: PeoplesViewable {
    func refreshUI() {
        DispatchQueue.main.async {
            self.collectionView.isHidden = false
            self.acitivtyIndicator.stopAnimating()
            self.collectionView.reloadData()
        }
    }
    
    func showError() {
        DispatchQueue.main.async {
            self.acitivtyIndicator.stopAnimating()
            self.collectionView.reloadData()
        }
    }
}

extension PeoplesViewController: UICollectionViewDataSource {

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return peopleViewModel.peoplesCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell =  collectionView.dequeueReusableCell(withReuseIdentifier:"cell", for: indexPath) as? PeopleCollectionViewCell else {
            return UICollectionViewCell()
        }

        if let people = peopleViewModel.getPeopleDetailFor(index: indexPath.row) {
            cell.setData(staff: people)
        }

        return cell
    }
}

extension PeoplesViewController: UICollectionViewDelegateFlowLayout {
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1.0, left: 1.0, bottom: 1.0, right: 1.0)//here your custom value for spacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let lay = collectionViewLayout as! UICollectionViewFlowLayout
        let widthPerItem = collectionView.frame.width / 2 - lay.minimumInteritemSpacing
        
        return CGSize(width:widthPerItem, height:100)
    }
}
