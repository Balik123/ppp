//
//  genPPP.swift
//  PPP
//
//  Created by Jose Olvera on 08/02/20.
//  Copyright © 2020 Jose Olvera. All rights reserved.
//

import Foundation
import UIKit
import CryptoKit


struct genPPP{
    
    let col: Int
    let row: Int
    let numDiv: Int
    
    
    let key = SymmetricKey(size: .bits256)
    
    
    
    func DigitosFinales(alfabeto: String) -> [String] {
        let letras = alfabeto
        let miAlfabeto = Array(letras)
        var tempPPP: [Character] = []
        
        var misDigitos: [String] = []
        var contador = 0
        while misDigitos.count < (col * row * numDiv) {
            let textoCifrado = genClaves().separate(every: 2, with: ",")
            let tempArray = textoCifrado.components(separatedBy: ",")
            for item in tempArray{
                misDigitos.append(item)
            }
           contador = contador + 1
        }
        
        for md in misDigitos{
            let num: Int = Int(md, radix: 16)!
            let div: Int = self.numDiv
            var res: Int = num/div
            
           
            while res > (miAlfabeto.count - 1) {
                res = res / div
            }
            
            tempPPP.append(miAlfabeto[res])
        }
        
        let temporalFinal = String(tempPPP)
        let PPP = temporalFinal.separate(every: 4, with: ",").components(separatedBy: ",")
        
        return PPP
    }
    
 
    
    func genClaves() -> String {
        let obtenerNum = createNum()
        var myArray = [String]()
        
        let mySealedBox = try? AES.GCM.seal(obtenerNum, using: key)
        let cifrado = mySealedBox?.ciphertext
        
        let cipherText = cifrado?.withUnsafeBytes{
            return Array($0)
        }
        for numbers in cipherText!{
            myArray.append(intToHex(integer: numbers))
        }
        
        return myArray.joined()
        
    }
    
    

    func getSequenceKey() -> String{
        var myArray = [String]()
        let keyBytes = key.withUnsafeBytes{return Array($0)}
        for numbers in keyBytes{
            myArray.append(intToHex(integer: numbers))
        }
        return myArray.joined()
    }
    
    

    func intToHex(integer: UInt8) -> String{
        return String(format: "%02X", integer)
    }
    
    
    func createNum() -> Data{
            let currentTime = Date().toMillis()
            let num: UInt128 = UInt128(currentTime!)
            var uInt128toByn = String(num, radix: 2)
            
            while uInt128toByn.count < 128 {
                uInt128toByn = "0" + uInt128toByn
            }
            
            return Data(uInt128toByn.utf8)
        }

    
   
    
}


