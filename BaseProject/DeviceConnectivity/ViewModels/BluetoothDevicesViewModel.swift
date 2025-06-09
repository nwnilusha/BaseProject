//
//  BluetoothDevicesViewModel.swift
//  BaseProject
//
//  Created by Nilusha Niwanthaka Wimalasena on 16/5/25.
//

import Foundation
import CoreBluetooth

class BluetoothDevicesViewModel: NSObject, ObservableObject {
    
    @Published var discoveredDevices: [BluetoothDevice] = []
    @Published var activeDevice: BluetoothDevice?
    @Published var isBluetoothEnabled = false
    
    private var centralManager: CBCentralManager!
    private var deviceMap: [UUID: CBPeripheral] = [:]
    
    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: .main)
    }
    
    func connect(to device: BluetoothDevice) {
        activeDevice = device
        activeDevice?.deviceState = .connecting
        centralManager.stopScan()
        centralManager.connect(device.peripheral, options: nil)
    }
    
    func disconnect() {
        activeDevice?.deviceState = .disconnecting
        guard let peripheral = activeDevice?.peripheral else { return }
        centralManager.cancelPeripheralConnection(peripheral)
    }
}

extension BluetoothDevicesViewModel: CBCentralManagerDelegate {
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        isBluetoothEnabled = central.state == .poweredOn
        
        if isBluetoothEnabled {
            central.scanForPeripherals(withServices: nil, options: nil)
        } else {
            discoveredDevices.removeAll()
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral,
                        advertisementData: [String : Any], rssi RSSI: NSNumber) {
        guard let name = peripheral.name else { return }
        
        let unwantedPrefixes = ["JBL", "Bose", "Sony"]
        if unwantedPrefixes.contains(where: { name.starts(with: $0) }) {
            return
        }

        if let services = advertisementData[CBAdvertisementDataServiceUUIDsKey] as? [CBUUID],
           services.isEmpty {
            return
        }
        
        let device = BluetoothDevice(id: peripheral.identifier, name: name, deviceState: .disconnected, peripheral: peripheral)
        if !discoveredDevices.contains(device) {
            DispatchQueue.main.async {
                self.discoveredDevices.append(device)
                self.deviceMap[peripheral.identifier] = peripheral
            }
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        DispatchQueue.main.async {
            if let _ = self.discoveredDevices.first(where: { $0.peripheral == peripheral }) {
                self.activeDevice?.deviceState = .connected
            }
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        DispatchQueue.main.async {
            if self.activeDevice?.peripheral == peripheral {
                self.activeDevice?.deviceState = .disconnected
            }
        }
    }
    
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        DispatchQueue.main.async {
            self.activeDevice?.deviceState = .disconnected
        }
    }
}

