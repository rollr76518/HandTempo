//
//  DataManager.swift
//  HandTempo
//
//  Created by Ryan on 2017/9/23.
//  Copyright © 2017年 Hanyu. All rights reserved.
//

import Foundation

struct Song: Codable
{
    var name: String
    var notes: [String]
}

class DataManager
{
    static let shared = DataManager()

    var customSongs: [Song]
    {
        get
        {
            if let data = UserDefaults.standard.value(forKey: UserDefaults.Keys.Songs) as? Data,
                let songs = try? PropertyListDecoder.init().decode([Song].self, from: data) {
                return songs
            }
            return [Song]()
        }
    }
    
    func save(toUserDefault song: Song)
    {
        var songs = customSongs
        songs.insert(song, at: 0)
        let data = try? PropertyListEncoder.init().encode(songs)
        UserDefaults.standard.set(data, forKey: UserDefaults.Keys.Songs)
    }
}

extension UserDefaults
{
    enum Keys
    {
        static  let Songs = "CHYsongs"
    }
}

extension String
{
    func separatedToNotes() -> [String]
    {
        return String(self.characters.filter { !" \n\t\r.".characters.contains($0) }).components(separatedBy: ",").map({return $0})
    }
}
