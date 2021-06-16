import Foundation

class ProdWS{
    
    func AgregarProducto(prod:Product,
                         _ completionBlock: @escaping (Any) -> Void) -> Void {
        let parameters: [String: Any] = [
            "title": prod.Title,
            "description": prod.Descripcion,
            "sku": prod.Sku,
            "price": prod.Price,
            "src": prod.Src
        ]
        POST(_URL: "https://pm2-atm.000webhostapp.com/PHP/Add.php", parameters: parameters, completionBlock)
    }
    
    func EliminarProducto(id:String,
                          _ completionBlock: @escaping (Any) -> Void) -> Void{
        let parameters: [String: Any] = [
            "id": id
        ]
        POST(_URL: "https://pm2-atm.000webhostapp.com/PHP/Delete.php", parameters: parameters, completionBlock)
    }
    
    func EditarProducto(id:String,prod:Product,
                        _ completionBlock: @escaping (Any) -> Void) -> Void{
        let parameters: [String: Any] = [
            "id": id,
            "title": prod.Title,
            "description": prod.Descripcion,
            "sku": prod.Sku,
            "price": prod.Price,
            "src": prod.Src
        ]
        POST(_URL: "https://pm2-atm.000webhostapp.com/PHP/Edit.php", parameters: parameters, completionBlock)
    }
    
    func ObtenerProductos(id:String, _ completionBlock: @escaping (Any) -> Void) -> Void {
        let parameters: [String: Any] = [
            "id": id
        ]
        POST(_URL: "https://pm2-atm.000webhostapp.com/PHP/List.php", parameters: parameters, completionBlock)
    }
    
    func ObtenerProductos(_ completionBlock: @escaping (Any) -> Void) -> Void {
        ObtenerProductos(id:"",completionBlock)
    }
}
