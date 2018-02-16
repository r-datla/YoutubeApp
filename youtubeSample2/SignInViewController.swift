//
//  SignInViewController.swift
//  youtubeSample2
//
//  Created by Rijutha Datla on 12/11/17.
//  Copyright © 2017 Rijutha. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
class SignInViewController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate {
    
    
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        
        Auth.auth().signIn(with: credential) { (user, error) in
            
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            print("user signed into firebase")
            //let searchView = searchViewController()
            //            self.navigationController?.pushViewController(searchView, animated: true)
            // self.navigationController?.setViewControllers(, animated: <#T##Bool#>)
            //self.navigationController?.present(searchViewController.searchSingleton, animated: true, completion: nil)
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "YoutubeVC") as! ViewController
            //vc.navigationItem.title = "Search Videos"
            //self.present(vc, animated: true, completion: nil)
            //self.navigationController?.pushViewController(vc, animated: true)
            self.navigationController?.pushViewController(vc, animated: true)
    }
    }
    

    @IBAction func SignInButton(_ sender: GIDSignInButton) {
        
        GIDSignIn.sharedInstance().signIn()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
     FirebaseApp.configure()
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        
        // Do any additional setup after loading the view.
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
