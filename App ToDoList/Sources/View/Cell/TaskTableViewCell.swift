//
//  TaskTableViewCell.swift
//  AppToDoList
//
//  Created by Felipe Santos on 26/11/23.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dateTaskString: UILabel!
    @IBOutlet weak var timeTaskString: UILabel!
    @IBOutlet weak var titleTaskString: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    public func setValuesTask(_ newTask: Task) {
        dateTaskString.text = newTask.date
        timeTaskString.text = newTask.time
        titleTaskString.text = newTask.title
    }
}
