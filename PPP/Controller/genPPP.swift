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
            let textoCifrado = genClaves(contador: contador).separate(every: 2, with: ",")
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
    
 
    
    func genClaves(contador: Int) -> String {
        let contador = contador
        let obtenerNum = createNum(num: contador)
        var myArray = [String]()
        
        let mySealedBox = try? AES.GCM.seal(Data(obtenerNum.joined().utf8), using: key)
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
    
    
    func createNum(num:Int) -> [String] {
        var num = num
        var miArr: [String] = []
        for _ in 1...128{
            let currenBit = num & 0x01
            if currenBit != 0{
                miArr.append("1")
            }
            else{
                miArr.append("0")
            }
            num >>= 1
        }
           return miArr.reversed()
    }
    
   
    
}


