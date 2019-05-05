//
//  RecordingVC.swift
//  Pitch-Perfect
//
//  Created by Abdualziz Aljuaid on 26/03/2019.
//  Copyright © 2019 Abdualziz Aljuaid. All rights reserved.
//

import UIKit
import AVFoundation

class RecordingVC: UIViewController{

    
    
    //MARK:- IBOutlet
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var startRecordingButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    
    
    //MARK:- Properties 
    var audioRecorder: AVAudioRecorder!
    let segueIdentifier = "gotoPlayingVC"
    
    
    
    
    //MARK:- Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    
    
    
    //MARK:- Setup view
    func setupView(){
        startRecordingButton.imageView!.contentMode = .scaleAspectFit
        stopRecordingButton.imageView!.contentMode = .scaleAspectFit
        stopRecordingButton.isEnabled = false
    }
    
    //MARK:- Start recording
    @IBAction func startRecording(_ sender: UIButton) {
        updateUI(isEnapled: false, shownLabel: "Tap to stop recording")
        setupDirPath()
        setupSession()
    }

    
    
    
    //MARK:- Stop recording
    @IBAction func stopRecordingButtonPressed(_ sender: UIButton) {
        updateUI(isEnapled: true, shownLabel: "Tap to Record")
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    
    
    
    //MARK:- Update UI
    func updateUI(isEnapled: Bool, shownLabel: String){
        recordingLabel.text = shownLabel
        startRecordingButton.isEnabled = isEnapled
        stopRecordingButton.isEnabled = !isEnapled
    }
    

    
    //MARK:- Setup DirPath
    func setupDirPath(){
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let recordName = "recordedVoice.wav"
        let pathArray = [dirPath, recordName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        setupAudioRecorder(filePath: filePath!)
    }
    
    
    //MARK:- Setup Session
    func setupSession(){
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSession.Category.playback, mode: AVAudioSession.Mode.default, options: [])
        try! session.setActive(true)
    }
    
    
    //MARK:- Setup Audio recorder
    func setupAudioRecorder(filePath: URL){
        try! audioRecorder = AVAudioRecorder(url: filePath, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    
    //MARK:- Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier {
            let playSoundVC = segue.destination as! PlayingVC
            let recordedAudioURL = sender as! URL
            playSoundVC.recordedAudioURL = recordedAudioURL
        }
    }
}





//MARK:- AVAudioRecorderDelegate
extension RecordingVC: AVAudioRecorderDelegate {
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegue(withIdentifier: segueIdentifier, sender: audioRecorder.url)
        } else {
            print("recording was not successful")
        }
    }
}
