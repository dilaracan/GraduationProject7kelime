//
//  ViewController.swift
//  7Kelime
//
//  Created by  Dilara CAN on 15.12.2020.
//  Copyright © 2020 Come492. All rights reserved.
//

import UIKit
import Foundation
import CoreData


class ViewController: UIViewController {

    @IBOutlet weak var currentCevap: UITextField!
    @IBOutlet weak var cevapLabel: UILabel!
    @IBOutlet weak var soruLabel: UILabel!
    @IBOutlet weak var puanLabel: UILabel!
    
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    
    
    
    var harfBtn = [UIButton]()
    var cevapArray = [String]()
    var heceBtn = [UIButton]()
    //burada global değişken olarak level ve puanı tanımladım bu globalde aynı zamanda obje yarattım ama bu objenin Currentplayerin datalarını burada cekemedigimden load()fonksyonunda çektiğimde seviyeleri düzgünce okuyabildi.
    
    let defaults = UserDefaults.standard
    var level:Int!
    var puan:Int!
    var levelling = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        level = defaults.integer(forKey: "level")
        puan = defaults.integer(forKey: "score")
        
        if puan == 0 {
            puanLabel.text = "Puan 0"
        }
        else {
            puanLabel.text = "Puan " + String(puan)
        }
        
        print(level!)
      
        
        
        for heceler in view.subviews {
            if heceler.tag == 1000 {
                let btn = heceler as! UIButton
                harfBtn.append(btn)
                
                btn.addTarget(self, action: #selector(hecelereTiklandiginda), for: .touchUpInside)
            }
        }
        
        
        loadLevel(playlevel: level!)
        
    }
    
    @objc func hecelereTiklandiginda(btn: UIButton){
        currentCevap.text = currentCevap.text! + btn.titleLabel!.text!
        heceBtn.append(btn)
        btn.isHidden = true
    }
    
    func loadLevel(playlevel:Int){
        
        
        let level = playlevel
        
    
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
                            if parts.count < 2 {continue}
                            let answer = "\(parts[0])"
                            let clue = "\(parts[1])"
                               
                            clueString += "-\(clue)\n"
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
        if let solutionpnt = cevapArray.firstIndex(of: currentCevap.text!){
            levelling = levelling + 1
            heceBtn.removeAll()
            var splitHece = cevapLabel.text!.components(separatedBy: "\n")
            splitHece[solutionpnt] = currentCevap.text!
            cevapLabel.text = splitHece.joined(separator: "\n")
            
            currentCevap.text = ""
            puan! += 10
            
            puanLabel.text = "Puan \(puan!)"
            if levelling % 7 == 0 { //burada level atlamak için levellling counterim ile kontrol mod 7 ye göre atlatıyorum
                
                let ac = UIAlertController(title: "Tebrikler!", message: "Sonraki seviyeye hazır mısın?", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Başla", style: .default, handler: nil))
                present(ac, animated: true)
                level = level! + 1
                levelUp(nwlevel: self.level!, nwscore: self.puan!)
            }
        }
        else { //deneme cevabı yanlis girince oto temizliycekmi diye evet calisti
            for btn in heceBtn {
                btn.isHidden = false
            }

            heceBtn.removeAll()
            currentCevap.text=""
        }
        
       //saveData()
    }
    func levelUp(nwlevel:Int, nwscore:Int) {
        
        
        cevapArray.removeAll(keepingCapacity: true)
        let userDeafults = UserDefaults.standard
        userDeafults.setValue(nwlevel, forKey: "level")
        userDeafults.setValue(nwscore, forKey: "score")

        print(nwlevel)
//
        
        
        for btn in harfBtn {
            btn.isHidden = false
        }
        loadLevel(playlevel: nwlevel)
    }
    
    @IBAction func temizleBtn(_ sender: Any) {
        currentCevap.text=""
        for btn in heceBtn {
            btn.isHidden = false
        }

        heceBtn.removeAll()
    }
    @IBAction func pauseBtn(_ sender: Any) {
        self.performSegue(withIdentifier: "toPause", sender: self)
    }
    
    
    
  
}

