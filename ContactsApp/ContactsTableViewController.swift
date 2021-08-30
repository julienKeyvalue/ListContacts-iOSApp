//
//  ContactPage.swift
//  ContactsApp
//
//  Created by Julien on 24/08/21.
//

import UIKit
class ContactsTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    
    var contactList=[["Julien Joseph Thomas", "+91-9495718991", "abc@gmail.com"],["Bill Gates",      "+1-202-5358-9793", "abc@gmail.com"],
                     ["Tim Cook",        "+1-203-2384-6264", "abc@gmail.com"],
                     ["Richard Branson", "+1-204-3383-2795", "abc@gmail.com"],
                     ["Jeff Bezos",      "+1-205-0288-4197", "abc@gmail.com"],]
    
    
    func addtoList(data name: Array<String>) {
        self.contactList.append(name)
        print(self.contactList)
        
    }
    
    
    
    @IBOutlet weak var contactTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        contactTable.delegate=self
        contactTable.dataSource=self
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier:"contact") as! TableViewCell
        cell.name.text=contactList[indexPath.row][0]
        cell.phoneno.text=contactList[indexPath.row][1]
        cell.indexpath=indexPath
        
        cell.delegate=self
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }

    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        var nameField = UITextField()
        var numberField = UITextField()
        var emailField = UITextField()
        nameField.delegate=self
        
        func isValidEmail(_ email: String) -> Bool {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            
            let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailPred.evaluate(with: email)
        }
        func isPhoneNoValid(value: String) -> Bool {
            let PHONE_REGEX = "^\\d{10}$"
            let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
            let result = phoneTest.evaluate(with: value)
            return result
        }
        func isValidName(Input:String) -> Bool {
            let RegEx = "^\\w{6,18}$"
            let Test = NSPredicate(format:"SELF MATCHES %@", RegEx)
            return Test.evaluate(with: Input)
        }
        
        let alert=UIAlertController( title: "Add new Contact", message: " ", preferredStyle: .alert)
        let action=UIAlertAction(title: "Add", style: .default) { (action) in
            
            if(!isValidName(Input: nameField.text!)){
                let nameErrorAlert=UIAlertController(title: "Username is not Valid", message: "", preferredStyle: .alert)
                let back=UIAlertAction(title: "Back", style: .default) { action in
                    self.dismiss(animated: true) {
                        self.present(alert, animated: true, completion: nil)
                    }
                }
                nameErrorAlert.addAction(back)
                self.present(nameErrorAlert, animated: true, completion: nil)
            }
            
            if(!isPhoneNoValid(value:numberField.text!)){
                let phoneNumberErrorAlert=UIAlertController(title: "Phone Number is not valid ", message: "", preferredStyle: .alert)
                let back=UIAlertAction(title: "Back", style: .default) { action in
                    self.dismiss(animated: true) {
                        self.present(alert, animated: true, completion: nil)
                    }
                }
                phoneNumberErrorAlert.addAction(back)
                self.present(phoneNumberErrorAlert, animated: true, completion: nil)
            }
            if(!isValidEmail(emailField.text!)){
                let emailErrorAlert=UIAlertController(title: "Not a valid Email", message: "", preferredStyle: .alert)
                let back=UIAlertAction(title: "Back", style: .default) { action in
                    self.dismiss(animated: true) {
                        self.present(alert, animated: true, completion: nil)
                    }
                }
                emailErrorAlert.addAction(back)
                self.present(emailErrorAlert, animated: true, completion: nil)
                
            }
            if(isValidName(Input: nameField.text!) && isValidEmail(emailField.text!) && isPhoneNoValid(value: numberField.text!)){
                self.contactList.append([nameField.text!,numberField.text!,emailField.text!])
                self.contactTable.reloadData()
            }
            
            
           
        }
        let cancel=UIAlertAction(title: "Cancel", style: .default) { action in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addTextField { alertTextField in
            alertTextField.placeholder="Contact Name"
            nameField=alertTextField
        }
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder="Contact Number"
            numberField=alertTextField
        }
        alert.addTextField { alertTextField in
            alertTextField.placeholder="Contact Email"
            emailField=alertTextField
        }
        
        alert.addAction(action)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    
}


extension ContactsTableViewController: ContactDelegate{
    func contactingForDeleting(at index: IndexPath) {
        self.contactList.remove(at: index.row)
        self.contactTable.reloadData()
        
    }
    
    
    func contactingForEditing(at Index: IndexPath) {
        
        var nameField = UITextField()
        var numberField = UITextField()
        var emailField = UITextField()
        let alert=UIAlertController(title: "Edit Element", message: "", preferredStyle: .alert)
        
        let action=UIAlertAction(title: "Update", style: .default) { action in
            print(Index)
            self.contactList[Index.row][0]=nameField.text ?? " "
            self.contactList[Index.row][1]=numberField.text ?? " "
            self.contactList[Index.row][2]=emailField.text ?? " "
            
            self.contactTable.reloadData()
            
        }
        let cancel=UIAlertAction(title: "Cancel", style: .default) { action in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addTextField { alertTextField in
            alertTextField.placeholder=self.contactList[Index.row][0]
            nameField=alertTextField
        }
        alert.addTextField { alertTextField in
            alertTextField.placeholder=self.contactList[Index.row][1]
            numberField=alertTextField
        }
        alert.addTextField { alertTextField in
            alertTextField.placeholder=self.contactList[Index.row][2]
            emailField=alertTextField
        }
        
        alert.addAction(action)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
        
        
        
        
        
    }
    
}
