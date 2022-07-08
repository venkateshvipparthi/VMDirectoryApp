//
//  RoomsViewModel.swift
//  StaffsDirectory
//
//  Created by Admin on 08/07/2022.
//

import Foundation

protocol RoomsViewModelType {
    var roomsCount: Int {get}
    func fetchRooms(baseUrl: String, path: String)
    func getRoomFor(index: Int)-> Room?
}

class RoomsViewModel: RoomsViewModelType {

    private var rooms:[RoomsResponce] = []
    var roomsCount:Int {
        return rooms.count
    }
    
    private let networkManager: Networkble
    private weak var delegate: RoomsViewControllerType?
    
    init(networkManager: Networkble = NetworkManager(), delegate:RoomsViewControllerType) {
        self.networkManager = networkManager
        self.delegate = delegate
    }
    
   
    func fetchRooms(baseUrl: String, path: String) {

        networkManager.get(baseUrl, path: path, type: RoomsResponce.self) {[weak self] result in
            
            switch result {
            case .success(let rooms) :
                self?.rooms = rooms
                self?.delegate?.refreshUI()
            case .failure(_) :
                self?.rooms = []
                self?.delegate?.showError()
            }
        }
    }
    
    func getRoomFor(index: Int) -> Room? {
        guard index < roomsCount && index >= 0 else {
            return nil
        }
        let roomModel = rooms[index]
        
        return Room(createdAt: roomModel.createdAt, occupiedMessage: roomModel.isOccupied ? "Occupied" : "Not Occupied", maxOccupancy: roomModel.maxOccupancy, id: roomModel.id)
    }
}
