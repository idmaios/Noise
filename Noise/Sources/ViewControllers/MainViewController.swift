//
//  MainViewController.swift
//  Noise
//
//  Created by Nick on 19/4/16.
//  Copyright © 2016 spromicky. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBAction func presentNotificationController(sender: UIButton) {
        Noise.showNotificationWith(title: "Some title", message: "tmp: " + "jasjash djaksldjkajslkdj kjalksj dlkjsjdkasdkdjas jash djaksld jkajslkdjkja lksjdlkjsj dkasdkdj a sjashd jaksldjkaj slkdjkjalksjdlkjsjdkas dkdjasjas h djaksldjk ajslkdjkjalks jdlkjsjdkasd kdjasj ashd jak sldjk ajslkdjkjalk sjdlkjsjdkasd kdjasjash djaksldjk ajslkdjkjalk sjdlkjsjdka sdkdjas jashdj aksldjk aj sl kdj kjalksjdl kjsjdkasdk djasjashdja ksldjkajslkdjkja lksjdlkjsjdk asdkdjasja shdjaksld jkajslkdjkjal ksjdlkjsjdk asdkd", icon: UIImage(named: "Check"))
    }
    
    @IBAction func errorNotification(sender: UIButton) {
        showNoise(title: "Error", message: "Something went wrong!", icon: UIImage(named: "Error"), type: .Error)
    }
    
    @IBAction func warningNotification(sender: UIButton) {
        showNoise(title: "Warning", message: "Something went bad, but still everything OK!", icon: UIImage(named: "Warning"), type: .Warning)
    }
    
    @IBAction func defaultNotification(sender: UIButton) {
        showNoise(title: nil, message: "Just simple not important message for user!", icon: nil, type: .Default)
    }
    
    @IBAction func successNotification(sender: UIButton) {
        showNoise(title: "Success", message: "You do your best! Congratulations!", icon: UIImage(named: "Ok"), type: .Success)
    }
    
    @IBAction func customColorNotification(sender: UIButton) {
        showNoise(title: nil, message: "Great custom background color notification!", icon: nil, duration: Noise.DefaultNotificationDuration,backgroundColor: UIColor.blueColor(), callBack: nil)
    }
}

