//
//  PlayerData.swift
//  7Kelime
//
//  Created by Amer Atia on 10.01.2021.
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

