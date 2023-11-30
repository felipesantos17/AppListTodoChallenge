//
//  ManagerTaskTableViewController.swift
//  AppToDoList
//
//  Created by Felipe Santos on 26/11/23.
//

import UIKit
import FSCalendar

class ManagerTaskTableViewController: UITableViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var dateCalender: FSCalendar!
    @IBOutlet weak var timeButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    // MARK: - Var/Let
    private var taskHelper: TaskDefaultHelper?
    private var taskList: [Task] = []
    private var selectedTime: String = ""
    private var selectedDate: String = ""
    public var selectedEditTask: Task?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        dateCalender.delegate = self
        configDeleteButton()
        configTaskHelper()
        loadTaskList()
        configView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? TimePickerViewController {
            controller.delegate = self
        }
    }

    // MARK: - Actions
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func openSelectorTimer(_ sender: Any) {
        performSegue(withIdentifier: "SegueTimerPicker", sender: nil)
    }
    
    @IBAction func deleteTask(_ sender: Any) {
        guard let deleteTask = taskList.first(where: { $0.id == selectedEditTask?.id }) else { return }
        taskHelper?.deletaeTask(deleteTask)
        dismiss(animated: true)
    }
    
    @IBAction func saveTask(_ sender: Any) {
        createNewTask()
    }
    
    private func configTaskHelper() {
        self.taskHelper = TaskDefaultHelper()
    }
    
    private func configDeleteButton() {
        deleteButton.isHidden = true
    }
    
    private func configView() {
        guard let selectedEditTask else { return }
        titleTextField.text = selectedEditTask.title
        timeButton.setTitle(selectedEditTask.time, for: .normal)
        selectedDate = selectedEditTask.date
        selectedTime = selectedEditTask.time
        deleteButton.isHidden = false
    }
    
    private func loadTaskList() {
        guard let taskHelper else { return }
        taskList = taskHelper.getListTask()
    }
    
    private func createNewTask() {
        guard let taskHelper else { return }
        if let selectedEditTask {
            selectedEditTask.date = selectedDate
            selectedEditTask.time = selectedTime
            selectedEditTask.title = titleTextField.text ?? ""
            taskHelper.updateTask(selectedEditTask)
        } else {
            let task: Task = .init(
                id: UUID(),
                title: titleTextField.text ?? "",
                time: selectedTime,
                date: selectedDate
            )
            taskList.append(task)
            taskHelper.saveListTask(taskList)
        }
        dismiss(animated: true)
    }
}

extension ManagerTaskTableViewController: FSCalendarDelegate, FSCalendarDelegateAppearance {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
         selectedDate = date.convertDateToString(date: date, dateFormatter: "dd/MM/yyyy")
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        let dateAux = Date().convertDateToString(date: date, dateFormatter: "dd/MM/yyyy")
        if selectedEditTask != nil {
            if selectedDate == dateAux {
                return .green
            }
        }
        return nil
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        let dateAux = Date().convertDateToString(date: date, dateFormatter: "dd/MM/yyyy")
        if selectedEditTask != nil {
            if selectedDate == dateAux {
                return .black
            }
        }
        return nil
    }
}

extension ManagerTaskTableViewController: TimePickerProtocol {
    func sendTime(_ time: String) {
        timeButton.setTitle(time, for: .normal)
        selectedTime = time
    }
}

// MARK: - Table view data source
extension ManagerTaskTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
}
