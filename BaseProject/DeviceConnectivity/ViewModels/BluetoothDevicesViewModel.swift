//
//  BluetoothDevicesViewModel.swift
//  BaseProject
//
//  Created by Nilusha Niwanthaka Wimalasena on 16/5/25.
//

import Foundation
import CoreBluetooth

class BluetoothDevicesViewModel: NSObject, ObservableObject, CBCentralManagerDelegate {
    
    @Published var discoveredPeripherals: [CBPeripheral] = []
    @Published var isBluetoothEnabled: Bool  = false
    
    private var centralManager: CBCentralManager?
    
    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: .main)
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            isBluetoothEnabled = true
            centralManager?.scanForPeripherals(withServices: nil, options: nil)
        } else {
            isBluetoothEnabled = false
        }
    }
    
    
    
}
