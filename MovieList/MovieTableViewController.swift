//
//  MovieTableViewController.swift
//  MovieList
//
//  Created by Daniel Stahl on 12/26/18.
//  Copyright © 2018 Daniel Stahl. All rights reserved.
//

import UIKit

class MovieTableViewController: UITableViewController {

    var movies = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = editButtonItem
        
        if let savedMovies = Movie.loadMovies() {
            movies = savedMovies
        } else {
            movies = Movie.loadSampleMovies()
        }
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as? MovieTableViewCell else { fatalError("Could not dequeue a cell") }
        
        let movie = movies[indexPath.row]
        cell.titleLabel.text = movie.title
        let actors = movie.actors?.joined(separator: ", ")
        cell.actorsLabel.text = actors
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            movies.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            Movie.saveMovies(movies)
        }
    }
    
    @IBAction func unwindToMovieList(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveUnwind" else { return }
        let sourceViewController = segue.source as! NewMovieTableViewController
        
        if let movie = sourceViewController.movie {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                movies[selectedIndexPath.row] = movie
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            } else {
                let newIndexPath = IndexPath(row: movies.count, section: 0)
                movies.append(movie)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
        Movie.saveMovies(movies)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails" {
            let newMovieTableViewController = segue.destination as! NewMovieTableViewController
            let indexPath = tableView.indexPathForSelectedRow!
            let selectedMovie = movies[indexPath.row]
            newMovieTableViewController.movie = selectedMovie
        }
    }

}
