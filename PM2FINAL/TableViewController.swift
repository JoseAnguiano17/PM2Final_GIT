//
//  TableViewController.swift
//  PM2FINAL
//
//  Created by user201443 on 6/14/21.
//

import UIKit

class TableViewController: UITableViewController {
    
    public static var CONTEXTO : TableViewController?
    @IBOutlet var MytableView: UITableView!
    var WS = ProdWS()
    var items : [Product] = []
    override func viewDidLoad() {
        ReloadView()
        TableViewController.CONTEXTO = self;
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func AddItem(_ Producto: Product) -> Void{
        self.items.append(Producto)
    }
    func ReloadView() -> Void
    {
        items = []
        let queue = DispatchGroup()
        queue.enter();
        WS.ObtenerProductos(id:"",{(json) in
            let x = json as? [[String:String]]
            for item in x!{
                let id = Int(item["id"] ?? "0")!
                let title = item["title"]
                let desc = item["description"]
                let sku = item["sku"]
                let price = Double(item["price"] ?? "0")!
                let src = item["src"]
                self.AddItem(Product(Id: id, Title: title!, Descripcion: desc!, Sku: sku!, Price: price, Src: src!))
            }
            queue.leave()
        })
        queue.notify(queue: .main){
            super.viewDidLoad()
            self.tableView.estimatedRowHeight = 250
            self.tableView.reloadData()
            print("Items: \(self.items.count)")
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "prod_cell", for: indexPath) as! TableViewCell
        let ID = self.items[indexPath.row].Id;
        cell.editButton.tag = ID
        cell.deleteButton.tag = ID
        cell.nombreProducto.text = "$\(self.items[indexPath.row].Price) - "+self.items[indexPath.row].Title
        cell.descProducto.text = self.items[indexPath.row].Descripcion
        cell.editButton.addTarget(self, action: #selector(editarProducto(sender:)), for: .touchUpInside)
        cell.deleteButton.addTarget(self, action: #selector(eliminarProducto(sender:)), for: .touchUpInside)
        cell.imgProducto.load(URL(string: "\(self.items[indexPath.row].Src)")!)
        return cell
    }
    
    @objc
    func editarProducto(sender:UIButton){
        showAlert(sender.tag,"Editar")
    }
    @objc
    func eliminarProducto(sender:UIButton){
        print(sender.tag)
        showAlert(sender.tag,"Eliminar")
    }
    
    
    func showAlert(_ id:Int , _ op:String ) {
        let alert = UIAlertController(title: "\(op) producto", message: "Desea \(op) el producto?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Si", style: .default, handler: { (_) in
            if(op=="Editar"){
                self.showEditInputs(id)
            } else {
                self.WS.EliminarProducto(id: "\(id)",{(output) in
                    self.ReloadView()
                })
            }
        }))
        alert.addAction(UIAlertAction(title: "No", style: .destructive, handler: { (_) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showEditInputs(_ id: Int){
        let queue = DispatchGroup()
        var title = ""
        var desc = ""
        var sku = ""
        var price = ""
        
        queue.enter()
        WS.ObtenerProductos(id: "\(id)", { json in
            let x = json as? [String:String]
            title = x!["title"]!
            desc = x!["description"]!
            sku = x!["sku"]!
            price = x!["price"]!
            queue.leave()
        })
        
        queue.notify(queue: .main){
            // Create alert controller
            let alertController = UIAlertController(title: "Editar", message: "Modifique los datos del producto", preferredStyle: .alert)
            
            // add textfield at index 0
            alertController.addTextField(configurationHandler: {(_ textField: UITextField) -> Void in
                textField.placeholder = "Titulo"
                textField.text = title
            })
            
            // add textfield at index 1
            alertController.addTextField(configurationHandler: {(_ textField: UITextField) -> Void in
                textField.placeholder = "Descripcion"
                textField.text = desc
            })
            
            // add textfield at index 2
            alertController.addTextField(configurationHandler: {(_ textField: UITextField) -> Void in
                textField.placeholder = "SKU"
                textField.text = sku
            })
            
            // add textfield at index 3
            alertController.addTextField(configurationHandler: {(_ textField: UITextField) -> Void in
                textField.keyboardType = UIKeyboardType.decimalPad
                textField.placeholder = "Precio"
                textField.text = price
            })
            
            // Alert action confirm
            let confirmAction = UIAlertAction(title: "OK", style: .default, handler: {(_ action: UIAlertAction) -> Void in
                let title = alertController.textFields![0].text!
                let desc = alertController.textFields![1].text!
                let sku = alertController.textFields![2].text!
                let price = Double("\(alertController.textFields![3].text!)")
                self.WS.EditarProducto(id: "\(id)", prod: Product(Id: id, Title: title, Descripcion: desc, Sku: sku, Price: price ?? 0, Src: ""), { output in
                    self.ReloadView()
                })
            })
            alertController.addAction(confirmAction)
            
            // Alert action cancel
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {(_ action: UIAlertAction) -> Void in
                print("Canelled")
            })
            alertController.addAction(cancelAction)
            
            // Present alert controller
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
}
