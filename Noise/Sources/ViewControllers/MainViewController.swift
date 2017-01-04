//
//  MainViewController.swift
//  Noise
//
//  Created by Nick on 19/4/16.
//  Copyright © 2016 spromicky. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBAction func presentNotificationController(_ sender: UIButton) {
        Noise.showNotificationWith(title: "Some title", message: "tmp: " + "jasjash djaksldjkajslkdj kjalksj dlkjsjdkasdkdjas jash djaksld jkajslkdjkja lksjdlkjsj dkasdkdj a sjashd jaksldjkaj slkdjkjalksjdlkjsjdkas dkdjasjas h djaksldjk ajslkdjkjalks jdlkjsjdkasd kdjasj ashd jak sldjk ajslkdjkjalk sjdlkjsjdkasd kdjasjash djaksldjk ajslkdjkjalk sjdlkjsjdka sdkdjas jashdj aksldjk aj sl kdj kjalksjdl kjsjdkasdk djasjashdja ksldjkajslkdjkja lksjdlkjsjdk asdkdjasja shdjaksld jkajslkdjkjal ksjdlkjsjdk asdkd", icon: UIImage(named: "Check"))
    }
    
    @IBAction func errorNotification(_ sender: UIButton) {
        showNoise(title: "Error", message: "Something went wrong!", icon: UIImage(named: "Error"), type: .error)
    }
    
    @IBAction func warningNotification(_ sender: UIButton) {
        showNoise(title: "Warning", message: "Something went bad, but still everything OK!", icon: UIImage(named: "Warning"), type: .warning)
    }
    
    @IBAction func defaultNotification(_ sender: UIButton) {
        showNoise(title: nil, message: "Just simple not important message for user!", icon: nil, type: .default)
    }
    
    @IBAction func successNotification(_ sender: UIButton) {
        showNoise(title: "Success", message: "You do your best! Congratulations!", icon: UIImage(named: "Ok"), type: .success)
    }
    
    @IBAction func customColorNotification(_ sender: UIButton) {
        showNoise(title: nil, message: "Great custom background color notification!", icon: nil, duration: Noise.DefaultNotificationDuration,backgroundColor: UIColor.blue, callBack: nil)
    }
}

