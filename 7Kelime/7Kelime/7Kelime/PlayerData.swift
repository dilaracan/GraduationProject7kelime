//
//  PlayerData.swift
//  7Kelime
//
//  Created by  Dilara CAN on 15.12.2020.
//  Copyright © 2021 Come492. All rights reserved.
//

import Foundation

struct PlayerData {
    var score: Int  {
        didSet{
            let defaults = UserDefaults.standard
            if var dataplayer = defaults.object(forKey: "Player") as? PlayerData {
                dataplayer.score = score
                defaults.setValue(dataplayer, forKey: "Player")
            }
        }
    }
    var level: Int  {
        didSet {
            let defaults = UserDefaults.standard
                if var dataplayer = defaults.object(forKey: "Player") as? PlayerData {
                    dataplayer.level = level
                    defaults.setValue(dataplayer, forKey: "Player")
                }
            }
        }
    }

