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
    
    fileprivate let manager = CMMotionManager.init()
    
    fileprivate var shouldDowning: Bool!
    fileprivate var currentIndex: Int!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        prepareForPlayNotes()
        
        manager.startAccelerometerUpdates(to: OperationQueue.main) { (data, error) in
            
            if let data = data {
                if data.acceleration.z > 0.0 {
                    if self.shouldDowning == false {
                        self.shouldDowning = true
                        self.playNote()
                    }
                }
                
                if data.acceleration.z < -1.5 {
                    if self.shouldDowning == true {
                        self.shouldDowning = false
                        self.playNote()
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
    
    func playNote()
    {
        if currentIndex >= song.notes.count - 1 {
            prepareForPlayNotes()
            return
        }
        
        let fileName = song.notes[currentIndex].songNoteFileName()
        SoundManager.shared.play(fileName)
        
        self.currentIndex = self.currentIndex + 1
    }
    
    func prepareForPlayNotes()
    {
        currentIndex = 0
        shouldDowning = true
    }
}
