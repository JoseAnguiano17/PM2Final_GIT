//
//  EditController.swift
//  PM2FINAL
//
//  Created by user201443 on 6/14/21.
//

import UIKit

class EditController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    public static var context : EditController?
    @IBOutlet weak var _Title: UITextField!
    @IBOutlet weak var _Description: UITextView!
    @IBOutlet weak var _Sku: UITextField!
    @IBOutlet weak var _Price: UITextField!
    @IBOutlet weak var imagePreview: UIImageView!
    let WS = ProdWS()
    override func viewDidLoad() {
        super.viewDidLoad()
        EditController.context=self
        TableViewController.CONTEXTO?.updateTheme(self)
        self.hideKeyboardWhenTappedAround() 
    }
    
    
    func changeColor(_ option: Int){
        if option == 1 {
            self.view.backgroundColor = UIColor.white
        }else{
            self.view.backgroundColor = UIColor.darkGray
        }
    }
    
    @IBAction func AgregarProducto(_ sender: Any) {
        let miProd = Product(Id:0,Title: _Title.text!, Descripcion: _Description.text, Sku: _Sku.text!, Price: Double(_Price.text!) ?? 0, Src: image64.text!)
        switch validarCaptura() {
        case 1:
            _Title.becomeFirstResponder()
            showAlert("Error", "Verifique su captura",error: true)
        case 2:
            _Description.becomeFirstResponder()
            showAlert("Error", "Verifique su captura",error: true)
        case 3:
            _Sku.becomeFirstResponder()
            showAlert("Error", "Verifique su captura",error: true)
        case 4:
            _Price.becomeFirstResponder()
            showAlert("Error", "Verifique su captura",error: true)
        default: 
            WS.AgregarProducto(prod: miProd, { (output) in
                print(output)
                TableViewController.CONTEXTO?.ReloadView()
            })
            showAlert("Exito", "Agregado" ,error: false)
        }
    }
    
    public func showAlert(_ titleMessage: String,_ msg: String,error: Bool){
        
        let alert = UIAlertController(title: titleMessage, message: msg, preferredStyle: .alert)
        if error {
            alert.addAction(UIAlertAction(title: "Ok", style: .destructive, handler: { (_) in
                
            }))
        }else{
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (_) in
                
            }))
            
            self.present(alert, animated: true) {
                self._Title.text = ""
                self._Description.text = ""
                self._Sku.text = ""
                self._Price.text = ""
            }
            return
            
        }
        
        self.present(alert, animated: true, completion: nil)
        return
        
    }
    
    func validarCaptura()->Int{
        if _Title.text == ""{
            return 1
        }else if  _Description.text == ""{
            return  2
        }else if  _Sku.text == ""{
            return 3
        }else if _Price.text == ""{
            return 4
        }else{
            return 0
        }
    }
    
    @IBAction func AgregarImagen(_ sender: Any) {
        let galery = UIImagePickerController()
        galery.delegate = self
        galery.sourceType = UIImagePickerController.SourceType.photoLibrary
        galery.allowsEditing = true
        self.present(galery, animated: true, completion: nil)
    }
    
    @IBOutlet weak var image64: UILabel!
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }

        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)

        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
            let base64 = image.jpegData(compressionQuality: 0.5)?.base64EncodedString() ?? ""
            image64.text = base64;
            imagePreview.image = image

        }

        dismiss(animated: true)
    }

    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
