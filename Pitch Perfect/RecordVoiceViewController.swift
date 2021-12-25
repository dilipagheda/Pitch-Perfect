//
//  RecordVoiceViewController.swift
//  Pitch Perfect
//
//  Created by Dilip Agheda on 24/12/21.
//

import UIKit
import AVFoundation

class RecordVoiceViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var stopButton: UIButton!
    
    @IBOutlet weak var recordButton: UIButton!
    
    @IBOutlet weak var helperLabel: UILabel!
    
    var audioRecorder: AVAudioRecorder!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        stopButton.isEnabled = false
    }

    @IBAction func onStopButtonTapHandler(_ sender: UIButton) {
        
        helperLabel.text = "Tap above to record your voice!"
        stopButton.isEnabled = false
        recordButton.isEnabled = true
        
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
        
    }
    
    @IBAction func onRecordButtonTapHandler(_ sender: UIButton) {
        
        helperLabel.text = "Recording now..."
        stopButton.isEnabled = true
        recordButton.isEnabled = false
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
                let recordingName = "recordedVoice.wav"
                let pathArray = [dirPath, recordingName]
                let filePath = URL(string: pathArray.joined(separator: "/"))

        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)

        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {

        if flag {
            performSegue(withIdentifier: "showPlayVoiceScreen", sender: audioRecorder.url)
        }else{
            print("error occured while recording")
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "showPlayVoiceScreen")
        {
            let playVoiceViewController = segue.destination as! PlayVoiceViewController
            let recordedAudioURL = sender as! URL
            playVoiceViewController.recordedAudioURL = recordedAudioURL
        }
    }
     
}

