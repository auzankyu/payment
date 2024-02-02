//
//  ScannerManager.swift
//  QRCodeApps
//
//  Created by Auzan Lazuardi on 31/01/24.
//

import Foundation
import AVFoundation

class ScannerManager {
    static let shared = ScannerManager()
    
    func getSession(session: AVCaptureSession, completion: @escaping (AVCaptureSession) -> Void) {
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        
        //Add input to session
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        if session.canAddInput(videoInput) {
            session.addInput(videoInput)
        } else {
            return
        }
        completion(session)

    }
}
