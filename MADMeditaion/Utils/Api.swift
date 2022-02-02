import Foundation
import SwiftUI

class Api: ObservableObject{
    func getMiniCards(completion: @escaping (GetMiniCardModel) -> ()){
        guard let url = URL(string: "http://mskko2021.mad.hakta.pro/api/feelings") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            let data = try! JSONDecoder().decode(GetMiniCardModel.self, from: data!)
            DispatchQueue.main.async {
                completion(data)
            }
        }.resume()
    }
}
    
