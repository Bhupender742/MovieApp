//
//  MovieViewController.swift
//  MovieApp
//
//  Created by Bhupender Rawat on 07/07/21.
//

import UIKit

class MovieViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    var previewMovie: movie?
    
    let baseURL: String = "https://image.tmdb.org/t/p/w92"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let posterURL = previewMovie?.poster_path ?? " "
        let imageURL = URL(string: (baseURL + posterURL))
        
        imageView.downloaded(from: imageURL!)
        
        nameLabel.text = previewMovie?.original_title
        overviewLabel.text = previewMovie?.overview
    }

}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
