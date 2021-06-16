import Foundation

extension ProdWS {
    func POST(_URL:String,parameters:[String:Any],_ completionBlock: @escaping (Any) -> Void) -> Void{
        let Url = String(format: _URL)
        guard let serviceUrl = URL(string: Url) else { return }
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        request.timeoutInterval = 20
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    //print(json)
                    completionBlock(json)
                } catch {}
            }
        }.resume()
    }
}
