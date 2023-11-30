//
//  ListTasksViewController.swift
//  AppToDoList
//
//  Created by Felipe Santos on 26/11/23.
//

import UIKit

class ListTasksViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var listTaskTableView: UITableView!
    @IBOutlet weak var newTaskButton: UIButton!
    
    // MARK: - Var/Let
    private var taskHelper: TaskDefaultHelper?
    private var taskList: [Task] = []
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        registerNib()
        configTaskHelper()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadListTasks()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? ManagerTaskTableViewController {
            guard let task = sender as? Task else { return }
            viewController.selectedEditTask = task
        }
    }
    
    // MARK: - Actions
    @IBAction func createNewTask(_ sender: Any) {
        callCreateNewTask(task: nil)
    }
    
    // MARK: - Private Functions
    private func configTableView() {
        listTaskTableView.delegate = self
        listTaskTableView.dataSource = self
        listTaskTableView.showsVerticalScrollIndicator = false
        listTaskTableView.showsHorizontalScrollIndicator = false
    }
    
    private func registerNib() {
        listTaskTableView.register(UINib(nibName: "EmptyTasksCell", bundle: nil), forCellReuseIdentifier: "EmptyTasksCell")
    }
    
    private func configTaskHelper() {
        self.taskHelper = TaskDefaultHelper()
    }
    
    private func loadListTasks() {
        guard let loadTaskList = taskHelper?.getListTask() else { return }
        taskList = loadTaskList
        listTaskTableView.reloadData()
    }
    
    private func callCreateNewTask(task: Task?) {
        performSegue(withIdentifier: "CreateNewTaskSegue", sender: task)
    }
}

// MARK: - UITableViewDelegate
extension ListTasksViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if taskList.isEmpty {
            callCreateNewTask(task: nil)
        } else {
            callCreateNewTask(task: taskList[indexPath.row])
        }
    }
}

// MARK: - UITableViewDataSource
extension ListTasksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if taskList.isEmpty {
            return 1
        } else {
            return taskList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if taskList.isEmpty {
            guard let cell: EmptyTasksCell = tableView.dequeueReusableCell(withIdentifier: "EmptyTasksCell", for: indexPath) as? EmptyTasksCell
            else { return UITableViewCell() }
            return cell
        } else {
            guard let cell: TaskTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cellTask", for: indexPath) as? TaskTableViewCell
            else { return UITableViewCell() }
            let task: Task = taskList[indexPath.row]
            cell.setValuesTask(task)
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return taskList.isEmpty ? 150 : 90
    }
}
