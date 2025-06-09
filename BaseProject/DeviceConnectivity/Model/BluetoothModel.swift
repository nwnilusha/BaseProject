//
//  BluetoothModel.swift
//  BaseProject
//
//  Created by Nilusha Niwanthaka Wimalasena on 16/5/25.
//

import CoreBluetooth

struct BluetoothDevice: Identifiable, Equatable, Hashable {
    let id: UUID
    let name: String
    var deviceState: CBPeripheralState
    let peripheral: CBPeripheral
    
    static func == (lhs: BluetoothDevice, rhs: BluetoothDevice) -> Bool {
        lhs.id == rhs.id
    }
}

