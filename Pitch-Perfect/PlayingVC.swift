//
//  PlayingVC.swift
//  Pitch-Perfect
//
//  Created by Abdualziz Aljuaid on 26/03/2019.
//  Copyright © 2019 Abdualziz Aljuaid. All rights reserved.
//

import UIKit
import AVFoundation

class PlayingVC: UIViewController {

    //MARK:- IBOutlet
    @IBOutlet weak var snail: UIButton!
    @IBOutlet weak var rabbit: UIButton!
    @IBOutlet weak var chipmunk: UIButton!
    @IBOutlet weak var vader: UIButton!
    @IBOutlet weak var echo: UIButton!
    @IBOutlet weak var reverb: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    
    //MARK:- Properties
    var recordedAudioURL: URL!

    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    
    //MARK:- Enum
    enum ButtonType: Int {
        case slow = 0, fast, chipmunk, vader, echo, reverb
    }
    
    
    //MARK:- Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
        setupNavigationBar()
        setupImages()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        configureUI(.notPlaying)
    }
    
    
    
    //MARK:- Setup Navigation bar function
    func setupNavigationBar() {
        navigationController?.navigationBar.isHidden = true
    }
    
    
    //MARK:- Setup Images
    func setupImages(){
        snail.imageView!.contentMode = .scaleAspectFit
        rabbit.imageView!.contentMode = .scaleAspectFit
        chipmunk.imageView!.contentMode = .scaleAspectFit
        vader.imageView!.contentMode = .scaleAspectFit
        echo.imageView!.contentMode = .scaleAspectFit
        reverb.imageView!.contentMode = .scaleAspectFit
    }
    
    
    
    //MARK:- PlaySound Function
    @IBAction func playSound(_ sender: UIButton){
        switch(ButtonType(rawValue: sender.tag)!) {
            
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 1.5)
        case .chipmunk:
            playSound(pitch: 1000)
        case .vader:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }
        
        configureUI(.playing)
    }
    
    
    //MARK:- Stop Audio Function
    @IBAction func stopButtonPressed(_ sender: UIButton){
        stopAudio()
    }
    
    
    //MARK:- Re-record function
    @IBAction func reRecodButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
