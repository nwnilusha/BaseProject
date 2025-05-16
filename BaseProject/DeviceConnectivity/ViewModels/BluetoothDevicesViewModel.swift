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
    @Published var connectedDevice: BluetoothDevice?
    @Published var isBluetoothEnabled = false
    @Published var connectionState: ConnectionState = .disconnected
    
    private var centralManager: CBCentralManager!
    private var deviceMap: [UUID: CBPeripheral] = [:]

    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: .main)
    }

    func connect(to device: BluetoothDevice) {
        connectionState = .connecting
        centralManager.stopScan()
        centralManager.connect(device.peripheral, options: nil)
    }

    func disconnect() {
        guard let peripheral = connectedDevice?.peripheral else { return }
        centralManager.cancelPeripheralConnection(peripheral)
        connectionState = .disconnected
        connectedDevice = nil
    }

    enum ConnectionState {
        case disconnected
        case connecting
        case connected
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
        
        let device = BluetoothDevice(id: peripheral.identifier, name: name, peripheral: peripheral)
        if !discoveredDevices.contains(device) {
            DispatchQueue.main.async {
                self.discoveredDevices.append(device)
                self.deviceMap[peripheral.identifier] = peripheral
            }
        }
    }

    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        DispatchQueue.main.async {
            if let device = self.discoveredDevices.first(where: { $0.peripheral == peripheral }) {
                self.connectedDevice = device
                self.connectionState = .connected
            }
        }
    }

    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        DispatchQueue.main.async {
            if self.connectedDevice?.peripheral == peripheral {
                self.connectedDevice = nil
                self.connectionState = .disconnected
            }
        }
    }

    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        DispatchQueue.main.async {
            self.connectionState = .disconnected
        }
    }
}

