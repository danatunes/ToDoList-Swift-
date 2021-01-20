//
//  SecondViewController.swift
//  lecture3DemoSimpleApp
//
//  Created by admin on 06.01.2021.
//

import UIKit


class SecondViewController: UIViewController , UIGestureRecognizerDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    var arr = [ToDoItem]()
    let cellId = "TableViewCell"
    @IBOutlet var mySwitch : UISwitch!
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
            longPressGesture.minimumPressDuration = 1
            self.tableView.addGestureRecognizer(longPressGesture)
        
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
           let newDate  = alertController.textFields![1].text
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
        let action = UIContextualAction(style: .normal, title: "EDIT") {(action , view ,completion) in
               
            let alertController = UIAlertController(title: "Edit current item", message: nil, preferredStyle: .alert)
               
               alertController.addTextField { (textField) in
                   textField.placeholder = "New item name"
               }
               
               alertController.addTextField { (textField) in
                   textField.placeholder = "New date"
               }
              
                let alertAction1 = UIAlertAction(title: "Cancel", style: .default) { (alert) in
               
               }
               
               let alertAction2 = UIAlertAction(title: "Edit", style: .cancel) { (alert) in
                  
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
            
            let alert = UIAlertController(title: "DELETE?", message: "Data can not be returned after deletion", preferredStyle: .actionSheet)

            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {action in
                self.arr.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            }))
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))

            self.present(alert, animated: true)
            
        }
       // action.image = Trashcan
        action.backgroundColor = .red
        return action
    }
    
    @objc func handleLongPress(longPressGesture: UILongPressGestureRecognizer) {
        let p = longPressGesture.location(in: self.tableView)
        let indexPath = self.tableView.indexPathForRow(at: p)
        if indexPath == nil {
            print("Long press on table view, not row.")
        } else if longPressGesture.state == UIGestureRecognizer.State.began {
                // перенаправление на эдит контр
                let vc = self.storyboard?.instantiateViewController(identifier: "edit_vc") as! EditViewController
            //получаем клоужер
               vc.complitionHandler = { title , date  in
                let newThingList = ToDoItem(title: title, deadLine : date)
                self.arr[indexPath!.row] = newThingList
                self.tableView.reloadData()
            }
           // vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
                              
        }
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
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
   
//    @IBAction func switchDidChange(_ sender : UISwitch){
//        if sender.isOn{
//            view.backgroundColor = .red
//        }else{
//            view.backgroundColor = .white
//        }
//    }
//
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        arr.swapAt(sourceIndexPath.row, destinationIndexPath.row)
    }
    
    @IBAction func tapSort(){
        if tableView.isEditing{
            tableView.isEditing = false
        }else {
            tableView.isEditing = true 
        }
    }
    

}
