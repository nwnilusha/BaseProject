//
//  BluetoothModel.swift
//  BaseProject
//
//  Created by Nilusha Niwanthaka Wimalasena on 16/5/25.
//

import CoreBluetooth

struct BluetoothDevice: Identifiable, Equatable {
    let id: UUID
    let name: String
    let peripheral: CBPeripheral
    
    static func == (lhs: BluetoothDevice, rhs: BluetoothDevice) -> Bool {
        lhs.id == rhs.id
    }
}

