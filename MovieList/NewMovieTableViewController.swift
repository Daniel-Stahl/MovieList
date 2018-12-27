//
//  NewMovieTableViewController.swift
//  MovieList
//
//  Created by Daniel Stahl on 12/26/18.
//  Copyright © 2018 Daniel Stahl. All rights reserved.
//

import UIKit

class NewMovieTableViewController: UITableViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var actorsTextField: UITextField!
    @IBOutlet weak var yearTextField: UITextField!
    @IBOutlet weak var lengthTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var movie: Movie?
    var actorArray: [String]? = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let movie = movie {
            navigationItem.title = "Edit Movie"
            titleTextField.text = movie.title
            descriptionTextView.text = movie.description
            let actors = movie.actors?.joined(separator: ", ")
            actorsTextField.text = actors
            yearTextField.text = String(movie.year ?? 0)
            lengthTextField.text = String(movie.length ?? 0)
            
            actorArray = movie.actors
        }
        
        updateSaveButtonState()
    }
    
    func updateSaveButtonState() {
        let text = titleTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }

    @IBAction func textEditingChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "saveUnwind" else { return }
        
        if let strings = actorsTextField.text {
            let actors = strings.components(separatedBy: ", ")
            actorArray = actors
        }
        
        guard let yearNum = yearTextField.text,
            let lengthNum = lengthTextField.text else { return }
        
        let title = titleTextField.text!
        let description = descriptionTextView.text
        let actors = actorArray
        let year = Int(yearNum)
        let length = Int(lengthNum)
        
        movie = Movie(title: title, description: description, actors: actors, year: year, length: length)
    }

}
