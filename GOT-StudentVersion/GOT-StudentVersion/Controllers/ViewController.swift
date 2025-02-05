//
//  ViewController.swift
//  GOT-StudentVersion
//
//  Created by C4Q  on 11/2/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    var Episodes = GOTEpisode.allEpisodes // constant
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBarOutlet: UISearchBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchBarOutlet.delegate = self
        
        
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "season 1"
        case 1: return "season 2"
        case 2: return "season 3"
        case 3: return "season 4"
        case 4: return "season 5"
        case 5: return "season 6"
        case 6: return "season 7"
        default: return "nothing"
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return GOTEpisode.season1.count
        case 1: return GOTEpisode.season2.count
        case 2: return GOTEpisode.season3.count
        case 3: return GOTEpisode.season4.count
        case 4: return GOTEpisode.season5.count
        case 5: return GOTEpisode.season6.count
        case 6: return GOTEpisode.season7.count
            
        default: return 0
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentEpisode = GOTEpisode.seasons[indexPath.section][indexPath.row]
        switch indexPath.section % 2 == 0 {
        case true:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "GOTCell", for: indexPath) as? EpisodesTableViewCell {
                cell.EpisodeName.text = currentEpisode.name
                cell.seasonEpisodeLabel.text = "\(currentEpisode.season)"
                cell.seasonEpisodeImage.image = currentEpisode.getImage()
                return cell
            }
            
        case false:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "otherSideCell", for: indexPath) as? otherEpisodeTableViewCell {
                cell.episodeLabel.text = currentEpisode.name
                cell.seasonLabel.text = "\(currentEpisode.season)"
                cell.othersideImage.image = currentEpisode.getImage()
                return cell
            }
            
        default: return UITableViewCell()
        }
        return UITableViewCell()
    }
   
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let segueIdentifer = segue.identifier else {fatalError("No indentifier in segue")}
        
        switch segueIdentifer {
            
        case "segToDescription":
            guard let destVC = segue.destination as? DetailedViewController else {
                fatalError("Unexpected segue VC")
            }
            guard let selectedIndexPath = tableView.indexPathForSelectedRow else {fatalError("No row selected")
            }
            let currentEpisodes = GOTEpisode.seasons[selectedIndexPath.section][selectedIndexPath.row]
            destVC.currentSeason = currentEpisodes
            
        default:
            fatalError("unexpected segue identifies")
            
        }
    }
}




