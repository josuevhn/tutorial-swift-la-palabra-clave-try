//: Playground - noun: a place where people can play

import Cocoa

enum VendingMachineError: Error {
    
    case invalidSelection
    case insufficientFunds(coinsNeeded: Int)
    case outOfStock
    
} // VendingMachineError

struct Item {
    
    var price: Int
    var count: Int
    
} // Item

class VendingMachine {
    
    var inventory = [
        
        "Candy Bar": Item(price: 12, count: 7),
        "Chips": Item(price: 10, count: 4),
        "Pretzels": Item(price: 7, count: 11)
        
    ]
    
    var coinsDeposited = 0
    
    func vend(itemNamed name: String) throws {
        
        guard let item = inventory[name] else {
            
            throw VendingMachineError.invalidSelection
            
        } // guard
        
        guard item.count > 0 else {
            
            throw VendingMachineError.outOfStock
            
        } // guard
        
        guard item.price <= coinsDeposited else {
            
            throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - coinsDeposited)
            
        } // guard
        
        coinsDeposited -= item.price
        
        var newItem = item
        
        newItem.count -= 1
        
        inventory[name] = newItem
        
        print("Dispensando \(name)")
        
    } // vend
    
} // VendingMachine

let favoriteSnacks = [
    
    "Alice": "Chips",
    "Bob": "Licorice",
    "Eve": "Pretzels",
    
]

func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws {
    
    let snackName = favoriteSnacks[person] ?? "Candy Bar"
    
    try vendingMachine.vend(itemNamed: snackName)
    
} // buyFavoriteSnack

var barVendingMachine = VendingMachine()

barVendingMachine.coinsDeposited = 8

do {
    
    try buyFavoriteSnack(person: "Alice", vendingMachine: barVendingMachine)
    
} catch VendingMachineError.invalidSelection {
    
    print("Selección Inválida!")
    
} catch VendingMachineError.outOfStock {
    
    print("Producto no Disponible!")
    
} catch VendingMachineError.insufficientFunds(let coinsNeeded) {
    
    print("Fondos insuficientes. Por favor inserte \(coinsNeeded) monedas adicionales.")
    
} // catch
