//
//  MainViewController.swift
//  DPNotificationController
//
//  Created by Nick on 19/4/16.
//  Copyright © 2016 spromicky. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBAction func presentNotificationController(sender: UIButton) {
        DPNotification.showNotificationWith(message: "tmp: " + "jasjash djaksldjkajslkdj kjalksj dlkjsjdkasdkdjas jash djaksld jkajslkdjkja lksjdlkjsj dkasdkdj a sjashd jaksldjkaj slkdjkjalksjdlkjsjdkas dkdjasjas h djaksldjk ajslkdjkjalks jdlkjsjdkasd kdjasj ashd jak sldjk ajslkdjkjalk sjdlkjsjdkasd kdjasjash djaksldjk ajslkdjkjalk sjdlkjsjdka sdkdjas jashdj aksldjk aj sl kdj kjalksjdl kjsjdkasdk djasjashdja ksldjkajslkdjkja lksjdlkjsjdk asdkdjasja shdjaksld jkajslkdjkjal ksjdlkjsjdk asdkd", title: "Some title", icon: UIImage(named: "Check"))
    }
}

