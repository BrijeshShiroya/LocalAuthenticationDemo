//
//  ViewController.swift
//  TouchIDDemo
//
//  Created by Creole02 on 7/7/17.
//  Copyright © 2017 CreoleStudios. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


  @IBAction func btnTapClicked(_ sender: UIButton) {
    userAuthentication()
  }
  
  
  func userAuthentication(){
    let context:LAContext = LAContext()
    var error:NSError?
    let reasonString = "Authentication is needed to access your notes."
    if context.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &error){
      context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: reasonString, reply: { (success, err) in
        if success{
           print("touch id is match")
        }else{
          // If authentication failed then show a message to the console with a short description.
          // In case that the error is a user fallback, then show the password alert view.
          print(err?.localizedDescription ?? "")
          
          switch err! {
            
          case LAError.systemCancel:
            print("Authentication was cancelled by the system")
            
          case LAError.userCancel:
            print("Authentication was cancelled by the user")
            
          case LAError.userFallback:
            print("User selected to enter custom password")
            //open your custom view that get password from use and then check validation and set desired output.
            OperationQueue.main.addOperation({
              //open your custom view that get password from use and then check validation and set desired 			output.
            })
            
          default:
            OperationQueue.main.addOperation({
            })
          }
        }
      })
      
    }else{
      switch error!{
        
      case LAError.touchIDNotEnrolled:
        print("TouchID is not enrolled")
        
      case LAError.passcodeNotSet:
        print("A passcode has not been set")
        
      default:
        // The LAError.TouchIDNotAvailable case.
        print("TouchID not available")
      }
    }
  }
  
}

