//
//  TimePickerViewController.swift
//  App ToDoList
//
//  Created by Felipe Santos on 26/11/23.
//

import UIKit

protocol TimePickerProtocol: AnyObject {
    func sendTime(_ time: String)
}

class TimePickerViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var timeDatePicker: UIDatePicker!
    
    // MARK: - Var/Let
    weak var delegate: TimePickerProtocol?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - Actions
    @IBAction func close(_ sender: UIButton) {
        if sender == okButton {
            dismiss(animated: true) { [weak self] in
                guard let datePicker = self?.timeDatePicker.date else { return }
                let dateString: String = datePicker.convertDateToString(date: datePicker, dateFormatter: "HH:mm")
                self?.delegate?.sendTime(dateString)
            }
        } else {
            dismiss(animated: true)
        }
    }

}
