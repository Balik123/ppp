//
//  mainPPPViewController.swift
//  PPP
//
//  Created by Jose Olvera on 08/02/20.
//  Copyright © 2020 Jose Olvera. All rights reserved.
//


import UIKit
import CryptoKit

class mainPPPViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    let col = 4
    let row = 6
    let numDiv = 4
    let miAlfabeto = "!#%+23456789:=?@ABCDEFGHJKLMNPRSTUVWXYZabcdefghijkmnopqrstuvwxyz"
    
    let celdaID = "cell"
    let defaults = UserDefaults.standard
    var arrData:[String] = []
    
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var key: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let data = genPPP.init(col: col ,row: row, numDiv: numDiv)
        key.adjustsFontSizeToFitWidth = true
        
        if (defaults.string(forKey: "sequenceKey") != nil){
            key.text = defaults.string(forKey: "sequenceKey")
        }
        else{
            key.text = data.getSequenceKey()
            defaults.set(data.getSequenceKey(), forKey: "sequenceKey")
        }
        
        arrData =  getPPP()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let data = genPPP.init(col: col ,row: row, numDiv: numDiv)
        key.adjustsFontSizeToFitWidth = true
        
        if (defaults.string(forKey: "sequenceKey") != nil){
            key.text = defaults.string(forKey: "sequenceKey")
        }
        else{
            key.text = data.getSequenceKey()
            defaults.set(data.getSequenceKey(), forKey: "sequenceKey")
           
        }
        
        arrData =  getPPP()
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (col * row)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: celdaID, for: indexPath) as! cellPPPCollectionViewCell
        
        for _ in arrData{
            cell.textPPP.text = arrData[indexPath.row]
        }

        
        
        return cell
    }
    
    
    
    func getPPP () -> [String]{
        var data: [String]
        let temData = genPPP.init(col: self.col ,row: self.row, numDiv: self.numDiv)
        
        if (defaults.array(forKey: "ppp") != nil){
            data = defaults.array(forKey: "ppp") as! [String]
          }
        else{
            data = temData.DigitosFinales(alfabeto: miAlfabeto)
            defaults.set(temData.DigitosFinales(alfabeto: miAlfabeto), forKey: "ppp")
          }
        collectionView.reloadData()
    
    return data
        
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func getNewKey(_ sender: Any) {
        defaults.removeObject(forKey: "sequenceKey")
        defaults.removeObject(forKey: "ppp")
        
        self.viewWillAppear(true)
    }
    
}
