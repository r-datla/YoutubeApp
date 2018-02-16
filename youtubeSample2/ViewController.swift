//
//  ViewController.swift
//  youtubeSample2
//
//  Created by Rijutha Datla on 12/8/17.
//  Copyright © 2017 Rijutha. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class ViewController: UIViewController, UISearchBarDelegate, GIDSignInDelegate{
    
    
    @IBAction func SignOutButton(_ sender: UIButton) {
        
        GIDSignIn.sharedInstance().signOut()
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
    // already signed out
    }
    
   //var scrollview = UIScrollView()
    
    @IBOutlet weak var view1: UIView!
    
    @IBOutlet weak var view2: UIView!
    
    @IBOutlet weak var view3: UIView!
    
    @IBOutlet weak var view4: UIView!
    
    @IBOutlet weak var view5: UIView!
    
    @IBOutlet weak var viewImage1: UIImageView!
    
    @IBOutlet weak var viewImage2: UIImageView!
    
    @IBOutlet weak var viewImage3: UIImageView!
    
    @IBOutlet weak var viewImage4: UIImageView!
    
    @IBOutlet weak var viewImage5: UIImageView!
    
    @IBOutlet weak var viewLabel1: UILabel!
    
    @IBOutlet weak var viewLabel2: UILabel!
    
    @IBOutlet weak var viewLabel3: UILabel!
    
    @IBOutlet weak var viewLabel4: UILabel!
    
    @IBOutlet weak var viewLabel5: UILabel!
    
    
    var x : String = ""
    var titleArray2 = [String]()
    var imageArray2 = [UIImage]()
    var videoIdArray2 = [String]()
    var viewsArray = [UIView]()
    let Transition = PopAnimator()
    var selectedView = UIView()
//    let view1 = UIView()
//    let view2 = UIView()
//    let view3 = UIView()
//    let view4 = UIView()
//    let view5 = UIView()
//    
//    
//    
//    var viewsecond = UIView()
   
    
   var apiKey = "AIzaSyCgV6S_MQxMu7KTBiVQEkgEfjcvFsHkV-c"
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func searchButton(_ sender: UIButton) {
       
        self.getYoutubeDataUsingGCD()
    }
    
    
    
    
    
   /* func getYoutubeData(){
        let urlString = "https://www.googleapis.com/youtube/v3/search?part=snippet&q=\(textField.text!)&type=video&key=\(apiKey)"
        // urlString = urlString.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        
        // Create a NSURL object based on the above string.
        let targetURL = URL(string: urlString)
        //let targetURL = URL.init(string: urlString)
        let session = URLSession.shared
        session.dataTask(with: targetURL!){ (data, response, error) in
            if let response = response{
                print(response)
                
            }
            if let data = data {
                print(data)
                do{
                    let jsonData = try JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
                    //print(jsonData)
                    let items = jsonData["items"] as! [[String:Any]]
                    //print(items)
                    var titleArray = [String]()
                    for temp in items{
                        let snippet = temp["snippet"] as! [String:Any]
                        //Getting the title of the vide
                        let videoTitle = snippet["title"] as! String
                        //print(videoTitle)
                        
                        titleArray.append(videoTitle)
                        
                        //Getting the thumbnail for the video
                        /* let thumbnail = snippet["thumbnails"] as! [String:Any]
                         let defaultThumbnail = thumbnail["default"] as![String:Any]
                         let thumbnailUrlString = defaultThumbnail["url"] as! String
                         let thumbnailUrl = URL.init(string: thumbnailUrlString)
                         let session2 = URLSession.shared
                         session2.dataTask(with: thumbnailUrl!) { (data1, response, error) in
                         if let data = data1 {
                         self.imageArray.append(UIImage.init(data: data)!)
                         }
                         }.resume()*/
                        
                    }
                    
                    
                    print(titleArray)
                    self.titleArray2 = titleArray
                    print(self.titleArray2)
                    
                    
                    
                }
                catch let error {
                    print(error)
                }
                
            }
            }.resume()
    }*/
    
    
    
    func getYoutubeDataUsingGCD(){
        
        let scrollViewImageArray = [viewImage1,viewImage2,viewImage3,viewImage4,viewImage5]
        let scrollViewLabelArray = [viewLabel1,viewLabel2,viewLabel3,viewLabel4,viewLabel5]
//         var views = [view1,view2,view3,view4,view5]
//
//
//        scrollview = UIScrollView.init(frame: CGRect.init(x: 0, y: 100, width: self.view.frame.width, height: self.view.frame.height))
//
//        scrollview.contentSize = CGSize.init(width: scrollview.frame.width, height: scrollview.frame.height * 7)
//        scrollview.contentOffset = CGPoint.init(x: 0, y: 100)
//
//        viewsecond = UIView.init(frame: CGRect.init(x: scrollview.frame.minX, y: scrollview.frame.minY, width: scrollview.frame.width, height: scrollview.frame.height))
        //viewsecond.backgroundColor = UIColor.cyan
        
        //let urlString = "https://www.googleapis.com/youtube/v3/search?part=snippet&q=\(textField.text!)&type=video&key=\(apiKey)"
        let urlString = "https://www.googleapis.com/youtube/v3/search?part=snippet&q=\(x)&type=video&key=\(apiKey)"
       
        let backgroundThread = DispatchQueue.global(qos: .background)
        backgroundThread.async {
           
            let targetURL = URL.init(string: urlString)
            
            do{
                let data = try Data.init(contentsOf: targetURL!)
                let jsonData = try JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
                print(jsonData)
                let items = jsonData["items"] as! [[String:Any]]
                //print(items)
                var titleArray = [String]()
                var imageArray = [UIImage]()
                var videoIdArray = [String]()
                for temp in items{
                    let snippet = temp["snippet"] as! [String:Any]
                    
                    
                    //Getting the title of the vide
                    let videoTitle = snippet["title"] as! String
                    //print(videoTitle)
                    
                    titleArray.append(videoTitle)
                    
                    
                    let thumbnail = snippet["thumbnails"] as! [String:Any]
                    let defaultThumbnail = thumbnail["default"] as![String:Any]
                    let thumbnailUrlString = defaultThumbnail["url"] as! String
                    let thumbnailUrl = URL.init(string: thumbnailUrlString)
                    let imagedata = try Data.init(contentsOf: thumbnailUrl!)
                    let imageform = UIImage.init(data: imagedata)
                    
                    imageArray.append(imageform!)
                    
                    
                    let id = temp["id"] as! [String:Any]
                    let videoId = id["videoId"] as! String
                    videoIdArray.append(videoId)
                    
                }
                // print(titleArray)
                DispatchQueue.main.async {
                   
                    self.titleArray2 = titleArray
                    print(self.titleArray2)
                    //self.testLabel.text = String(describing: self.titleArray2)
                    self.imageArray2 = imageArray
                   // self.testImage.image = self.imageArray2[1]
                    self.videoIdArray2 = videoIdArray
                    
                    for i in 0..<5{
                        scrollViewImageArray[i]?.image = self.imageArray2[i]
                        scrollViewLabelArray[i]?.text = self.titleArray2[i]
                    }
                    
                    let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(self.view1Tapped))
                    self.view1.addGestureRecognizer(tapGesture1)
                    let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(self.view2Tapped))
                    self.view2.addGestureRecognizer(tapGesture2)
                    let tapGesture3 = UITapGestureRecognizer(target: self, action: #selector(self.view3Tapped))
                    self.view3.addGestureRecognizer(tapGesture3)
                    let tapGesture4 = UITapGestureRecognizer(target: self, action: #selector(self.view4Tapped))
                    self.view4.addGestureRecognizer(tapGesture4)
                    let tapGesture5 = UITapGestureRecognizer(target: self, action: #selector(self.view5Tapped))
                    self.view5.addGestureRecognizer(tapGesture5)
//
//                    for i in 0..<5 {
//                        
//                        
//                       // view[i] = UIView.init(frame: CGRect.init(x: (Int((scrollview.frame.width)/2 - 50)), y: (400 + (i*100)), width: 100, height: 100))
//                        // viewarray[i].backgroundColor = result[i]
//                        views[i] = UIView.init(frame: CGRect.init(x: 0, y: (self.scrollview.frame.minY + CGFloat(310*i)), width: self.scrollview.frame.width, height: 300))
////
//                        var image1 = UIImageView.init(frame: CGRect.init(x: views[i].frame.minX , y: views[i].frame.minY, width: views[i].frame.width, height: views[i].frame.height))
//                        var viewLabel = UILabel.init(frame: CGRect.init(x: image1.frame.minX, y: image1.frame.minY, width: image1.frame.width, height: 50))
//                        viewLabel.numberOfLines = 0
//                        viewLabel.text = self.titleArray2[i]
//                    
//                        viewLabel.textColor = UIColor.blue
//                        image1.image = self.imageArray2[i]
//                        
//                        self.view.addSubview(self.scrollview)
//                        self.scrollview.addSubview(self.viewsecond)
//                        
//                        self.viewsecond.addSubview(views[i])
//                        
//                        views[i].addSubview(image1)
//                        image1.addSubview(viewLabel)
//                        
//                    }
//                   
                
                    
                
                }
                
                
            }
            catch let error{
                print(error)
            }
        }
       
    
    }
    
    
    
    @objc func view1Tapped(_ tap: UIGestureRecognizer){
        selectedView = (tap.view)!
        print(selectedView)
    self.handleTap(i: 0)
    }
    @objc func view2Tapped(_ tap: UIGestureRecognizer){
        selectedView = (tap.view)!
        print(selectedView)
        self.handleTap(i: 1)
    }
    @objc func view3Tapped(_ tap: UIGestureRecognizer){
        selectedView = (tap.view)!
        print(selectedView)
        self.handleTap(i: 2)
    }
    @objc func view4Tapped(_ tap: UIGestureRecognizer){
        selectedView = (tap.view)!
        print(selectedView)
        self.handleTap(i: 3)
    }
    @objc func view5Tapped(_ tap: UIGestureRecognizer){
        selectedView = (tap.view)!
        print(selectedView)
        self.handleTap(i: 4)
    }
    
    
    
    func handleTap(i:Int){
        
       
        print("View \(i+1) Tapped")
    
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let pvc = storyboard.instantiateViewController(withIdentifier: "PVC") as! PlayerViewController
    pvc.videoIdforPlaying = videoIdArray2[i]
    pvc.videoTitle = titleArray2[i]
        pvc.transitioningDelegate = self
    
    self.present(pvc, animated: true, completion: nil)
    
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //scrollview.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
      viewsArray = [view1, view2, view3, view4, view5]
       searchBar.delegate = self
       
        Transition.dismissCompletion = {
            self.selectedView.isHidden = false
            }
       // search.enablesReturnKeyAutomatically = false
       
        
    }
   
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("search text : \(String(describing: searchBar.text!))")
        x = searchBar.text!
        self.getYoutubeDataUsingGCD()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
extension ViewController: UIViewControllerTransitioningDelegate{
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
       
        
        Transition.originFrame = selectedView.superview!.convert(selectedView.frame, to: nil)
        Transition.presenting = true
        selectedView.isHidden = true
         
    
        
       return Transition
    
}
    
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        Transition.presenting = false
     //  view1.isHidden = false
        return Transition
    }

}
