//
//  RoomsViewModelTests.swift
//  StaffsDirectoryTests
//
//  Created by Admin on 08/07/2022.
//

import XCTest
@testable import VMDirectoryAPP

class RoomsViewModelTests: XCTestCase {

    var roomViewModel: RoomsViewModel!
    
    override func setUpWithError() throws {
        let roomViewController = RoomsViewController()
        let mockNetworkMaanger = MockNetworkManager()

        
        roomViewModel = RoomsViewModel(networkManager: mockNetworkMaanger, delegate: roomViewController)
    }
    override func tearDownWithError() throws {
        roomViewModel = nil
    }

    func testFetchRooms_success() {
        roomViewModel.fetchRooms(baseUrl: "", path: "rooms_success_response")
         
        XCTAssertEqual(roomViewModel.roomsCount , 65)
    }
    
    func testFetchStaff_failure() {
        
        roomViewModel.fetchRooms(baseUrl: "", path: "failure_response")

        XCTAssertEqual(roomViewModel.roomsCount , 0)
    }

    func testGetStaff() {
        
        var room = roomViewModel.getRoomFor(index: 2)
        
        XCTAssertNil(room)
        
        room = roomViewModel.getRoomFor(index: -1)
        
        XCTAssertNil(room)
        
        roomViewModel.fetchRooms(baseUrl: "", path: "rooms_success_response")

        room = roomViewModel.getRoomFor(index: 0)
       
        XCTAssertNotNil(room)
        
        XCTAssertEqual(room!.occupiedMessage, "Not Occupied")
    }
}
