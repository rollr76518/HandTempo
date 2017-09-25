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
    
    var songs: [Song]
    {
        get
        {
            return DataManager.shared.customSongs
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
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
                let indexPath = IndexPath(row: 0, section: 0)
                self.tableView.insertRows(at: [indexPath], with: .automatic)
            }
        }
        let cancelButton = UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(okButton)
        alert.addAction(cancelButton)
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func buttonEditDidPressed(_ sender: UIBarButtonItem)
    {
        tableView.setEditing(!tableView.isEditing, animated: true)
        let newButton = UIBarButtonItem(barButtonSystemItem: tableView.isEditing ? .done:.edit, target: self, action: #selector(buttonEditDidPressed(_:)))
        navigationItem.setLeftBarButton(newButton, animated: true)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: CellID.tableViewCellID, for: indexPath)
        cell.textLabel?.text = songs[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        let song = songs[indexPath.row]
        performSegue(withIdentifier: "segueID", sender: song)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        switch editingStyle {
        case .delete:
            DataManager.shared.delete(fromUserDefault: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            break
        case .insert:break
        case .none:break
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle
    {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath)
    {
        let song = songs[sourceIndexPath.row]
        DataManager.shared.delete(fromUserDefault: sourceIndexPath.row)
        DataManager.shared.save(toUserDefault: song, at: destinationIndexPath.row)
    }
}
