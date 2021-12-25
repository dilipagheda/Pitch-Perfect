//
//  PlayVoiceViewController.swift
//  Pitch Perfect
//
//  Created by Dilip Agheda on 25/12/21.
//

import Foundation
import UIKit
import AVFoundation

class PlayVoiceViewController: UIViewController {

    var recordedAudioURL: URL!
    
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!

    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
   
    @IBOutlet weak var stopButton: UIButton!
    
    enum ButtonType: Int {
        case slow = 0, fast, chipmunk, vader, echo, reverb
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupAudio()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureUI(.notPlaying)
    }
    
    @IBAction func onPlaySoundHandler(_ sender: UIButton) {
        
        switch(ButtonType(rawValue: sender.tag)) {
        case .chipmunk:
            playSound(pitch:1000)
            break;
        case .echo:
            playSound(echo:true)
            break;
        case .fast:
            playSound(rate: 1.5)
            break;
        case .reverb:
            playSound(reverb: true)
            break;
        case .slow:
            playSound(rate: 0.5)
            break;
        case .vader:
            playSound(pitch: -1000)
            break;
        case .none:
            break;
        }
        
        configureUI(.playing)
    }
    
    @IBAction func onStopAudio(_ sender: UIButton) {
        stopAudio()
    }
}
