//
//  SecondViewController.swift
//  lecture3DemoSimpleApp
//
//  Created by admin on 06.01.2021.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var arr = [ToDoItem]()
    let cellId = "TableViewCell"
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Main page"
        self.configureTableView()
    }

    
    func configureTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
        tableView.tableFooterView = UIView()
        
    }
    
    @IBAction func add(_ sender: UIBarButtonItem) {
        
        let alertController = UIAlertController(title: "Create new item", message: nil, preferredStyle: .alert)
       
       alertController.addTextField { (textField) in
           textField.placeholder = "New item name"
       }
       
       alertController.addTextField { (textField) in
           textField.placeholder = "New date"
       }
      
       let alertAction1 = UIAlertAction(title: "Cancel", style: .destructive) { (alert) in
       
       }
       
        let alertAction2 = UIAlertAction(title: "Create", style: .cancel) { (alert) in
           // добавить новую запись
          
           let newTitle = alertController.textFields![0].text
           let newDate  =  alertController.textFields![1].text
           let newThingList = ToDoItem(title: newTitle, deadLine : newDate)
           self.arr.append(newThingList)
           self.tableView.reloadData()
       }
       
       alertController.addAction(alertAction1)
       alertController.addAction(alertAction2)
       present(alertController, animated: true, completion: nil)
   
    }
    
}

extension SecondViewController  {
   
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editing = editItem(at : indexPath)
        let deleting = removeItem(at : indexPath)
        return UISwipeActionsConfiguration(actions: [deleting, editing])
    }
    
    func editItem( at indexPath: IndexPath) ->
       
        UIContextualAction{
        let action = UIContextualAction(style: .normal, title: "Edit") {(action , view ,completion) in
               
            let alertController = UIAlertController(title: "Edit current item", message: nil, preferredStyle: .alert)
               
               alertController.addTextField { (textField) in
                   textField.placeholder = "New item name"
               }
               
               alertController.addTextField { (textField) in
                   textField.placeholder = "New date"
               }
              
                let alertAction1 = UIAlertAction(title: "Cancel", style: .default) { (alert) in
               
               }
               
               let alertAction2 = UIAlertAction(title: "Edit", style: .default) { (alert) in
                  
                let newTitle = alertController.textFields![0].text
                let newDate  =  alertController.textFields![1].text
                let newThingList = ToDoItem(title: newTitle, deadLine : newDate)
                   self.arr[indexPath.row] = newThingList
                   self.tableView.reloadData()
               }
               alertController.addAction(alertAction1)
               alertController.addAction(alertAction2)
                self.present(alertController, animated: true, completion: nil)
                
            }
        action.backgroundColor = .systemYellow
            return action
    }
    
    func removeItem(at indexPath : IndexPath) -> UIContextualAction{
        let action = UIContextualAction(style: .destructive, title: "DELETE") {(action , view ,completion) in
            self.arr.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
       // action.image = Trashcan
        action.backgroundColor = .red
        return action
    }
}

extension SecondViewController: UITableViewDelegate, UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TableViewCell
        let item = arr[indexPath.row]

        cell.titleLabel.text = item.title
        cell.subTitleLabel.text = item.deadLine
    
        return cell
    }
    
    
}
