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

    @IBOutlet fileprivate var collectionView: UICollectionView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        prepareForPlayNotes()
        setupCollectionView()
        
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
        collectionView.selectItem(at: IndexPath.init(row: currentIndex, section: 0), animated: true, scrollPosition: .bottom)

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
    
    func setupCollectionView()
    {
        collectionView.register(UINib.init(nibName: NoteCollectionViewCell.cellID, bundle: nil), forCellWithReuseIdentifier: NoteCollectionViewCell.cellID)
    }
}

extension SongPlayerViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return song.notes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NoteCollectionViewCell.cellID, for: indexPath) as! NoteCollectionViewCell
        
        cell.labelNote.text = song.notes[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        currentIndex = indexPath.row
        collectionView.scrollToItem(at: indexPath, at: .bottom, animated: true)
        
        let fileName = song.notes[currentIndex].songNoteFileName()
        SoundManager.shared.play(fileName)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let width = collectionView.bounds.size.width/4
        
        return CGSize.init(width: width, height: width)
    }
}
