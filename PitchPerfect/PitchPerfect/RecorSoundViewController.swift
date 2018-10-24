//
//  RecordSoundViewController.swift
//  PitchPerfect
//
//  Created by  AminSaleh on 08/02/1440 AH.
//  Copyright © 1440 AminTech. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundViewController: UIViewController ,AVAudioRecorderDelegate {
    
    var audioRecorder: AVAudioRecorder!
    
    @IBOutlet weak var stopbutten: UIButton!
    @IBOutlet weak var recordinglabel: UILabel!
    @IBOutlet weak var recordbutten: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopbutten.isEnabled = false
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    @IBAction func recordaudio(_ sender: Any) {
        recordinglabel.text = "Record in Progress..."
        stopbutten.isEnabled = true
        recordbutten.isEnabled = false
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        print(filePath!)
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.spokenAudio, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    @IBAction func stoprecord(_ sender: Any) {
        recordbutten.isEnabled = true
        stopbutten.isEnabled = false
        recordinglabel.text = "Press to Record..."
        
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag{
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        } else {
            print("error recording")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording" {
            let playSoundVC = segue.destination as! PlaySoundViewController
            let recordAudioURL = sender as! URL
            playSoundVC.recordedAudioURL = recordAudioURL
        }
    }
    
}








