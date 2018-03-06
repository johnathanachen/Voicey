//
//  AudioHandler.swift
//  voicey-ios
//
//  Created by Johnathan Chen on 3/4/18.
//  Copyright © 2018 Eliel Gordon. All rights reserved.
//

import Foundation
import AVFoundation

class AudioHandler {
    
    // 1. Setup audio recorder
    var recorder: AVAudioRecorder?
    
    // 2. Specify mp3 format for recording audio and medium quality
    let recorderSetting: [String: Any] = [
        AVFormatIDKey: kAudioFormatMPEGLayer3,
        AVEncoderAudioQualityKey: AVAudioQuality.medium
    ]
    
    // 3. Recording output path
    let audioOutputBasePath = try! FileManager.default.url(
        for: .documentDirectory,
        in: .userDomainMask,
        appropriateFor: nil,
        create: false
    )
    
    // 4. Extension for mp3 file
    let fileExtension = ".mp3"
    
    func prepareRecorder() {
        // 4. Create a unique id for our audio file and add mp3 extension
        let fileName = UUID().uuidString
        
        let outputFileURL = audioOutputBasePath
            .appendingPathComponent(fileName)
            .appendingPathExtension(fileExtension)
        
        guard let recorder = try? AVAudioRecorder(
            url: outputFileURL,
            settings: recorderSetting
            ) else {return}
        
        self.recorder = recorder
        
        recorder.delegate = self
        recorder.prepareToRecord()
    }
    
    func startRecording() {
        recorder.record()
    }
    
    func stopRecording() {
        recorder.stop()
    }

    
}

extension AudioHandler: AVAudioRecorderDelegate {
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        
    }
}



