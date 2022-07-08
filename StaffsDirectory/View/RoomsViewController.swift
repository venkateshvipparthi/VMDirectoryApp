//
//  RoomsViewController.swift
//  StaffsDirectory
//
//  Created by Admin on 08/07/2022.
//

import UIKit

protocol RoomsViewControllerType: AnyObject {
    func refreshUI()
    func showError()
}

class RoomsViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    var roomsViewModel:RoomsViewModelType!

    override func viewDidLoad() {
        super.viewDidLoad()
        roomsViewModel = RoomsViewModel(delegate: self)
        activityIndicator.startAnimating()

        roomsViewModel.fetchRooms(baseUrl: EndPoint.baseUrl, path: Path.rooms)
    }
}

extension RoomsViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return roomsViewModel.roomsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? RoomsTableViewCell else {
            return UITableViewCell()
        }
        
        if let room = roomsViewModel.getRoomFor(index: indexPath.row) {
            cell.setData(room: room)
        }
        
        return cell
    }
}

extension RoomsViewController: RoomsViewControllerType {
    func refreshUI() {
        DispatchQueue.main.async{
            self.tableView.isHidden = false
            self.tableView.reloadData()
            self.activityIndicator.stopAnimating()

        }
    }
    func showError() {
        DispatchQueue.main.async{
            self.tableView.reloadData()
            self.activityIndicator.stopAnimating()
        }
    }
}
