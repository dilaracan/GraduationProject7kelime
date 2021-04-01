//
//  AyarlarViewController.swift
//  7Kelime
//
//  Created by Hasan Dagg on 21.12.2020.
//  Copyright © 2020 Come492. All rights reserved.
//

import UIKit
import CoreData

class AyarlarViewController: UIViewController {

    @IBOutlet weak var fxSlider: UISlider!
    @IBOutlet weak var muzikSlider: UISlider!
    
    
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func resetGame(_ sender: Any) {
        let defaults = UserDefaults.standard
        
        
        
        
        let ac = UIAlertController(title: "Oyun Sıfırlanıcak", message: "Tüm seviyeni ve puanını yeniden başlatmak istediğine emin misin?", preferredStyle: UIAlertController.Style.alert)

        ac.addAction(UIAlertAction(title: "Evet", style: .default, handler: { (action: UIAlertAction!) in
            
            defaults.setValue(1, forKey: "level")
            defaults.setValue(0, forKey: "score")
            
            self.performSegue(withIdentifier: "toAyardanMainVC", sender: self)
              }))

        ac.addAction(UIAlertAction(title: "Hayır", style: .cancel, handler: { (action: UIAlertAction!) in
              print("Handle Cancel Logic here")
              }))

        present(ac, animated: true, completion: nil)
        
        
        
        

        
        
    }
    @IBAction func backBtn(_ sender: Any) {
        self.performSegue(withIdentifier: "toAyardanMainVC", sender: self)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
