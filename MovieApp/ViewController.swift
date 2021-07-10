//
//  ViewController.swift
//  MovieApp
//
//  Created by Bhupender Rawat on 25/06/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func unwindSegue(_ sender: UIStoryboardSegue) {
        
    }
        
    var sampleMovieList: SampleMovie?
    let baseURL: String = "https://image.tmdb.org/t/p/w92"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let jsonData = readLocalJSONFile(forName: "movies")
        
        if let data = jsonData {
            if let sampleMovieObj = parse(jsonData: data) {
                sampleMovieList = sampleMovieObj
                tableView.reloadData()
            }
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }


}

//MARK: - TableViewDelegator Methods

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        performSegue(withIdentifier: "showDetails", sender: self)
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
//        if segue.identifier == "showDetails" {
//            if let destination = segue.destination as? MovieViewController {
//                destination.previewMovie = sampleMovieList?.movies[(tableView.indexPathForSelectedRow?.row)!]
//            }
//        }
        
        if segue.identifier == "showMovieDetails" {
            if let destination = segue.destination as? MovieViewController {
                if let data = sender as? IndexPath {
                    destination.previewMovie = sampleMovieList?.movies[data.row]
                }
            }
        }
    }
    
}

//MARK: - TableViewDataSource Methods

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sampleMovieList?.movies.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customTableViewCell", for: indexPath) as? CustomTableViewCell
        
        cell?.delegate = self
        cell?.indexPath = indexPath
        
        cell?.nameLabel.text = sampleMovieList?.movies[indexPath.row].original_title
        cell?.overviewLabel.text = sampleMovieList?.movies[indexPath.row].overview
        
        let posterURL = sampleMovieList?.movies[indexPath.row].poster_path ?? " "
        
        if let imageURL = URL(string: (baseURL + posterURL)) {
            
            let task = URLSession.shared.dataTask(with: imageURL) {(data, response, error) in
                guard let data = data else {
                    return
                }
                
                let image = UIImage(data: data)
                
                DispatchQueue.main.async {
                    cell?.imagePreview.image = image
                }
            }
            task.resume()
        }
        return cell!
    }
}

//MARK: - CustomViewDelegator Methods

extension ViewController: CustomTableViewCellDelegator {
    func callSegueFromCell(indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showMovieDetails", sender: indexPath)
    }
}
