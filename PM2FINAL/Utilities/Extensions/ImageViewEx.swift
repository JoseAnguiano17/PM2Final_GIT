//
//  ImageViewEx.swift
//  PM2FINAL
//
//  Created by user201443 on 6/15/21.
//

import Foundation
import UIKit

extension UIImageView {
    func load(_ url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
