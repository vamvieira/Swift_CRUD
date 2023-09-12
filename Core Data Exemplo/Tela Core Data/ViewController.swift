//
//  ViewController.swift
//  Tela Core Data
//
//  Created by Usuário Convidado on 05/09/23.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var txtNome: UITextField!
    @IBOutlet weak var txtTelefone: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtNome.delegate = self
        txtTelefone.delegate = self
        txtEmail.delegate = self
    }
    
    func save(nome:String, tele:String, emai:String){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entidade = NSEntityDescription.entity(forEntityName: "Pessoa", in: managedContext)!
        
        let pessoa = NSManagedObject(entity: entidade, insertInto: managedContext)
        
        pessoa.setValue(nome, forKeyPath: "nome")
        pessoa.setValue(tele, forKeyPath: "telefone")
        pessoa.setValue(emai, forKeyPath: "email")
        
        do{
            try managedContext.save()
        }catch let error as NSError{
            print("Nao foi possivel salva \(error) , \(error.localizedDescription)")
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtNome{
            txtTelefone.becomeFirstResponder()
            return true
        }else if textField == txtTelefone{
            txtEmail.becomeFirstResponder()
            return true
        }else if textField == txtEmail{
            salvar(textField)
            return true
        }else{
            return false
        }
    }
    
    @IBAction func salvar(_ sender: Any) {
        txtEmail.resignFirstResponder()
        txtNome.resignFirstResponder()
        txtTelefone.resignFirstResponder()
        if txtNome.text!.isEmpty || txtEmail.text!.isEmpty || txtTelefone.text!.isEmpty{
            let alerta = UIAlertController(
                title: "Erro",
                message: "Preencha todos os campos",
                preferredStyle: UIAlertController.Style.alert)
            
            alerta.addAction(UIAlertAction(
                title: "Ok",
                style: UIAlertAction.Style.cancel))
            
            present(alerta, animated: true)
            return
        }
        
        self.save(nome: txtNome.text!, tele: txtTelefone.text!, emai: txtEmail.text!)
        self.navigationController?.popViewController(animated: true)
        /*
         var msg:String
         msg = "Ok, dados gravados para "
         msg += txtNome.text! + " "
         msg += txtTelefone.text!
         
         let alerta2 = UIAlertController(
         title: "Aviso",
         message: msg,
         preferredStyle: UIAlertController.Style.alert)
         
         alerta2.addAction(UIAlertAction(
         title: "Ok",
         style: UIAlertAction.Style.cancel))
         
         present(alerta2, animated: true)
         }
         */
        
        /*
         override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
         txtEmail.resignFirstResponder()
         txtNome.resignFirstResponder()
         txtTelefone.resignFirstResponder()
         }
         */
        
    }
    
}

