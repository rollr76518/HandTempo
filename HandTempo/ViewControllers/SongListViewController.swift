//
//  SongListViewController.swift
//  HandTempo
//
//  Created by Ryan on 2017/9/23.
//  Copyright © 2017年 Hanyu. All rights reserved.
//

import UIKit

class SongListViewController: UIViewController
{

    @IBOutlet var tableView: UITableView!
    
    var littleStar: Song!
    var londonBridge: Song!
    var songs: [Song]
    {
        get
        {
            return DataManager.shared.customSongs + [littleStar, londonBridge]
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        littleStar = Song.init(name: "小星星", notes:  "31,31,35,35,36,36,35,00,34,34,33,33,32,32,31,00,35,35,34,34,33,33,32,00,35,35,34,34,33,33,32,00,31,31,35,35,36,36,35,00,34,34,33,33,32,32,31,00".separatedToNotes())
        londonBridge = Song.init(name: "倫敦鐵橋", notes: "35,36,35,34,33,34,35,00,32,33,34,00,33,34,35,00,35,36,35,34,33,34,35,00,32,00,35,00,33,31,00,00,00".separatedToNotes())
    }
    
    // MARK: - IBActions
    @IBAction func buttonAddSongDidPress(_ sender: UIBarButtonItem)
    {
        let alert = UIAlertController.init(title: "Add song", message: "", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Song name: 小蜜蜂"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "notes: 35,33,33,00,34,32,32,00"
        }
        let okButton = UIAlertAction.init(title: "OK", style: .default) { (action) in
            if let songName = alert.textFields![0].text, let notes = alert.textFields![1].text {
                let song = Song.init(name: songName, notes: notes.separatedToNotes())
                DataManager.shared.save(toUserDefault: song)
                self.tableView.reloadData()
            }
        }
        let cancelButton = UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(okButton)
        alert.addAction(cancelButton)
        
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let vc = segue.destination as? SongPlayerViewController, let song = sender as? Song
        {
            vc.song = song
        }
    }
}

extension SongListViewController: UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
        cell.textLabel?.text = songs[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        let song = songs[indexPath.row]
        performSegue(withIdentifier: "segueID", sender: song)
    }
}
