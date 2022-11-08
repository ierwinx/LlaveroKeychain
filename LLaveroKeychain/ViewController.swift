import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let resp = KeychainHelper.save(Data("erwinleon".utf8), service: "usuario")
        createAlert(strMessage: resp ? "Exito al guardar" : "Error al guardar")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let usuario = KeychainHelper.read(service: "usuario") else {
            createAlert(strMessage: "Error al leer")
            return
        }
        let strUser = String(data: usuario, encoding: .utf8) ?? ""
        createAlert(strMessage: "Exito al leer \(strUser)")
    }
    
    private func createAlert(strMessage: String) {
        let alerta = UIAlertController(title: "Keychain", message: strMessage, preferredStyle: .alert)
        alerta.addAction(UIAlertAction(title: "Aceptar", style: .default))
        self.present(alerta, animated: true)
    }

    @IBAction func guardarAction(_ sender: Any) {
        let token = "485745-458475-3834J34-FURYF4FR8"
        let data = Data(token.utf8)
        let resp = KeychainHelper.save(data, service: "accessToken")
        createAlert(strMessage: resp ? "Exito al guardar" : "Error al guardar")
    }
    
    @IBAction func leerAction(_ sender: Any) {
        guard let data = KeychainHelper.read(service: "accessToken") else {
            createAlert(strMessage: "Error al leer")
            return
        }
        let token = String(data: data, encoding: .utf8) ?? ""
        createAlert(strMessage: "Exito al leer \(token)")
    }
    
    @IBAction func actualizaAction(_ sender: Any) {
        let newtoken = "485745-458475-3834J34-FURYF4FR7"
        let data = Data(newtoken.utf8)
        let resp = KeychainHelper.update(data, service: "accessToken")
        createAlert(strMessage: resp ? "Exito al actualizar" : "Error al actualizar")
    }
    
    @IBAction func eliminaAction(_ sender: Any) {
        let resp = KeychainHelper.delete(service: "accessToken")
        createAlert(strMessage: resp ? "Exito al eliminar" : "Error al eliminar")
    }
    
}
