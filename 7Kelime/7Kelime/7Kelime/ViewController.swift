//
//  ViewController.swift
//  7Kelime
//
//  Created by Hasan Dagg on 15.12.2020.
//  Copyright © 2020 Come492. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var currentCevap: UITextField!
    @IBOutlet weak var cevapLabel: UILabel!
    @IBOutlet weak var soruLabel: UILabel!
    @IBOutlet weak var puanLabel: UILabel!
    
    var harfBtn = [UIButton]()
    var cevapArray = [String]()
    var heceBtn = [UIButton]()
    
    var puan = 0
    var level = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        for heceler in view.subviews {
            if heceler.tag == 1000 {
                let btn = heceler as! UIButton
                harfBtn.append(btn)
                
                btn.addTarget(self, action: #selector(hecelereTiklandiginda), for: .touchUpInside)
            }
        }
        
        loadLevel()
    }
    
    @objc func hecelereTiklandiginda(btn: UIButton){
        currentCevap.text = currentCevap.text! + btn.titleLabel!.text!
        heceBtn.append(btn)
        btn.isHidden = true
    }
    
    func loadLevel(){
        var clueString = ""
        var solitionString = ""
        var letterBits = [String]()
       
        
        if let levelPath = Bundle.main.path(forResource: "level\(level)", ofType: "txt"){
                if let levelContents = try? String(contentsOfFile: levelPath) {
                    var lines = levelContents.components(separatedBy: "\n")
                    lines.shuffle()
                    //for ile level txt mizin icindekileri tarayip olusturdugumuz degiskenlere atiyoruz index 0 level 1 ilk satırımız
                    for (index, line) in lines.enumerated() {
                        let parts = line.components(separatedBy: ": ")
                        let answer = parts[0]
                        let clue = parts[1]
                        
                        clueString += "\(index + 1). \(clue)\n"
                        
                        let solitionWord = answer.replacingOccurrences(of: "|", with: "")
                        solitionString += "\(solitionWord.count) Harf\n"
                        cevapArray.append(solitionWord)

                        let bits = answer.components(separatedBy: "|")
                        letterBits += bits
                    }
                }
            }
        
        
        soruLabel.text = clueString.trimmingCharacters(in: .whitespacesAndNewlines)
        cevapLabel.text = solitionString.trimmingCharacters(in: .whitespacesAndNewlines)
    
        letterBits.shuffle()
        harfBtn.shuffle()

        if letterBits.count == harfBtn.count {
            for i in 0 ..< letterBits.count { // 0 dan ..< e kadar swifte özel operator syntexi letterbits.counta kadar 0 dan gitsin for
                harfBtn[i].setTitle(letterBits[i], for: .normal)
            }
        }
        
    }
    
    
    @IBAction func cevapBtn(_ sender: Any) {
    }
    @IBAction func temizleBtn(_ sender: Any) {
    }
    

}

