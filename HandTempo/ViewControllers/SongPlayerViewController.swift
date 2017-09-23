//
//  SongPlayerViewController.swift
//  HandTempo
//
//  Created by Ryan on 2017/9/23.
//  Copyright © 2017年 Hanyu. All rights reserved.
//

import UIKit
import CoreMotion

class SongPlayerViewController: UIViewController
{
    open var song: Song!
    
    internal let manager = CMMotionManager.init()
    
    internal var isDowning = true

    internal var currentIndex = 0
    {
        didSet
        {
            if currentIndex >= song.notes.count {
                currentIndex = 1
            }
            
            let fileName = "FmPiano_".appending(song.notes[currentIndex - 1]).appending(".mp3")
            SoundManager.shared.play(fileName)
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        manager.startAccelerometerUpdates(to: OperationQueue.main) { (data, error) in
            
            if let data = data {
                if data.acceleration.z > 0.0 {
                    if self.isDowning == false {
                        self.isDowning = true
                        self.currentIndex = self.currentIndex + 1
                    }
                }
                
                if data.acceleration.z < -1.5 {
                    if self.isDowning == true {
                        self.isDowning = false
                        self.currentIndex = self.currentIndex + 1
                    }
                }
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool)
    {
        super.viewDidDisappear(animated)
        manager.stopAccelerometerUpdates()
    }
}
