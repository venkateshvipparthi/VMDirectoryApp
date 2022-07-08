//
//  RoomsTableViewCell.swift
//  StaffsDirectory
//
//  Created by Admin on 08/07/2022.
//

import UIKit

class RoomsTableViewCell: UITableViewCell {

    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var occupiedLabel: UILabel!
    @IBOutlet weak var maxOccupancyLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    

    
    // MARK: Cell life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
    }
    
    override var accessibilityElements: [Any]? {
        set {}
        get {
            return [
                self.idLabel as Any,
                self.occupiedLabel as Any,
                self.maxOccupancyLabel as Any,
                self.createdAtLabel as Any]
        }
    }
    
    override func prepareForReuse() {
        idLabel.text = ""
        occupiedLabel.text = ""
        maxOccupancyLabel.text = ""
        createdAtLabel.text = ""
    }
    
    func setData(room: Room) {
        idLabel.text = room.id
        occupiedLabel.text = room.occupiedMessage
        maxOccupancyLabel.text = "\(room.maxOccupancy)"
        createdAtLabel.text = room.createdAt
        
        self.applyAccessibility()
    }
    
    private func applyAccessibility() {
        idLabel.isAccessibilityElement = true
        idLabel.accessibilityHint = "the id of the employee"
        idLabel.accessibilityValue = "employee id"
       
        occupiedLabel.isAccessibilityElement = true
        occupiedLabel.accessibilityHint = "room occupancy status"
        occupiedLabel.accessibilityValue = "occupied"
        
        maxOccupancyLabel.isAccessibilityElement = true
        maxOccupancyLabel.accessibilityHint = "maximum occuapancy status of the room"
        maxOccupancyLabel.accessibilityValue = "max occupancy"
       
        createdAtLabel.isAccessibilityElement = true
        createdAtLabel.accessibilityHint = "created on"
        createdAtLabel.accessibilityValue = "created on"
    }
}
