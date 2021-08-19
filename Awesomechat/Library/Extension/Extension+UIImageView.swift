//
//  Extension+UIImageView.swift
//  Awesomechat
//
//  Created by admin on 8/13/21.
//

import Foundation
import UIKit

extension UIImageView {
    func loadImageWidthUrlString(completion: @escaping (Data) -> Void, url: String) {
        guard let urlString = URL(string: url) else {
            return
        }
        let task = URLSession.shared.dataTask(with: urlString, completionHandler: { (data, reponse, error) in
            guard error == nil else {
                return
            }
            guard let dataResuld = data else {
                return
            }
            
            DispatchQueue.main.async {
                completion(dataResuld)
            }  
        })
        task.resume()
    }
}
