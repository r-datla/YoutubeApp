//
//  PlayerViewController.swift
//  youtubeSample2
//
//  Created by Rijutha Datla on 12/10/17.
//  Copyright © 2017 Rijutha. All rights reserved.
//

import UIKit


class PlayerViewController: UIViewController, YTPlayerViewDelegate {
    var videoIdforPlaying: String = ""
    var videoTitle: String = ""
    
    @IBOutlet weak var baseView: UIView!
    
    @IBOutlet weak var videoTitleLabel: UILabel!
    
    @IBOutlet weak var playerView: YTPlayerView!
    
  
    @IBAction func closeButton(_ sender: Any) {
        
        //self.dismiss(animated: true, completion: nil)
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let dict = ["modestbranding" : 0,"controls" : 1 ,"autoplay" : 1,"playsinline" : 1,"autohide" : 1,"showinfo" : 0]
      //  playerView.load(withVideoId: videoIdforPlaying)
        playerView.load(withVideoId: videoIdforPlaying, playerVars: dict)
        playerView.delegate = self
        videoTitleLabel.text = videoTitle
        // Do any additional setup after loading the view.
    }
    func playerViewDidBecomeReady(_ playerView: YTPlayerView!) {
        playerView.playVideo()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
