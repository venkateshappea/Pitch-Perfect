//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Venkatesh Appea on 2015-08-19.
//  Copyright (c) 2015 Venkatesh Appea. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    var player:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audiofile: AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        if var path = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3"){
//            var fileurl = NSURL.fileURLWithPath(path)
//
//        }else {
//            println("empty filepath")
//        }
        player = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        player.enableRate = true
        audioEngine = AVAudioEngine()
        audiofile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
        // Do any additional setup after loading the view.
    }

    @IBAction func darthvaderPlayback(sender: UIButton) {
        playbackwithvariblePitch(-1000)
    }
    @IBAction func ChipmunkPlayback(sender: UIButton) {
        playbackwithvariblePitch(1000)
    }
    
    func playbackwithvariblePitch(pitch: Float){
        player.stop()
        audioEngine.stop()
        audioEngine.reset()

        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitch = AVAudioUnitTimePitch()
        changePitch.pitch = pitch
        audioEngine.attachNode(changePitch)
        
        audioEngine.connect(audioPlayerNode, to: changePitch, format: nil)
        audioEngine.connect(changePitch, to: audioEngine.outputNode, format: nil)
    
        audioPlayerNode.scheduleFile(audiofile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func fastPlayback(sender: UIButton) {
        player.stop()
        player.rate = 2
        player.play()
    }
    
    @IBAction func stopAudio(sender: UIButton) {
        player.stop()
        player.currentTime = 0
    }
    
    @IBAction func SlowPlayback(sender: UIButton) {
        //playaudioplayer
        player.stop()
        player.rate = 0.5
        player.play()
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
