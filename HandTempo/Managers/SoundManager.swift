//
//  SoundManager.swift
//  HandTempo
//
//  Created by Ryan on 2017/9/23.
//  Copyright © 2017年 Hanyu. All rights reserved.
//

import Foundation
import AVFoundation

class SoundManager
{
    static let shared = SoundManager()

    fileprivate let audioEngine = AVAudioEngine.init()
    fileprivate let outputFormat = AVAudioFormat.init(commonFormat: .pcmFormatFloat32, sampleRate: 44100, channels: 2, interleaved: false)
    fileprivate let playerNode = AVAudioPlayerNode.init()
    fileprivate let mixerNode = AVAudioMixerNode.init()
    
    fileprivate init()
    {
        let session = AVAudioSession.sharedInstance()
        try? session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        try? session.overrideOutputAudioPort(.speaker)
        
        audioEngine.attach(mixerNode)
        audioEngine.attach(playerNode)
        
        audioEngine.connect(mixerNode, to: audioEngine.outputNode, format: outputFormat)
        audioEngine.connect(playerNode, to: mixerNode, format: outputFormat)
        
        audioEngine.prepare()
        try? audioEngine.start()
    }
    
    open func play(_ fileName: String)
    {
        stopAllPlayingNode()
        
        if let url = Bundle.main.url(forAuxiliaryExecutable: fileName) {
            let file = try? AVAudioFile.init(forReading: url)
            playerNode.scheduleFile(file!, at: nil, completionHandler: nil)
            playerNode.play()
        }
        else {
            print("\(fileName) doesn't exist")
        }
    }
    
    open func stopAllPlayingNode()
    {
        playerNode.stop()
    }
}
