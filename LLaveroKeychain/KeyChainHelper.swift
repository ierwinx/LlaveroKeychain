import Security
import Foundation

class KeychainHelper {

    private static let account = "com.bugsoft.Llaveros"
    
    static func save(_ data: Data, service: String) -> Bool {
        let query = [
            kSecValueData: data,
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: KeychainHelper.account,
        ] as CFDictionary
        
        let status = SecItemAdd(query, nil)
        if status == errSecSuccess {
            print("Exito al guardar")
            return true
        } else if status == errSecDuplicateItem {
            print("Ya existe el registro")
            return true
        } else {
            print("Error: \(status)")
            return false
        }
    }
    
    static func update(_ data: Data, service: String) -> Bool {
        let query = [
            kSecAttrService: service,
            kSecAttrAccount: KeychainHelper.account,
            kSecClass: kSecClassGenericPassword,
        ] as CFDictionary
        let attributesToUpdate = [kSecValueData: data] as CFDictionary
    
        let status = SecItemUpdate(query, attributesToUpdate)
        print(status == errSecSuccess ? "Exito al actualizar" : "Error: \(status)")
        return status == errSecSuccess
    }
    
    static func read(service: String) -> Data? {
        let query = [
            kSecAttrService: service,
            kSecAttrAccount: KeychainHelper.account,
            kSecClass: kSecClassGenericPassword,
            kSecReturnData: true
        ] as CFDictionary
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query, &result)
        print(status == errSecSuccess ? "Exito al leer" : "Error: \(status)")
        return result as? Data
    }
    
    static func delete(service: String) -> Bool {
        let query = [
            kSecAttrService: service,
            kSecAttrAccount: KeychainHelper.account,
            kSecClass: kSecClassGenericPassword,
        ] as CFDictionary
        
        let status = SecItemDelete(query)
        print(status == errSecSuccess ? "Exito al eliminar" : "Error: \(status)")
        return status == errSecSuccess
    }
    
}
