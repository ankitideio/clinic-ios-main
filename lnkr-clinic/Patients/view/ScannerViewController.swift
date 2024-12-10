//
//  ScannerViewController.swift
//  lnkr-clinic
//
//  Created by meet sharma on 25/04/23.
//

import UIKit
import AVFoundation
class ScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    //MARK: - OUTLETS
    @IBOutlet weak var vwScaner: UIView!
    @IBOutlet weak var lblScaning: UILabel!
    @IBOutlet weak var imgVwScan: UIImageView!
    
    //MARK: - VARIABLES
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    var callBack:((_ cardNo:String)->())?
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
        captureSession = AVCaptureSession()

               guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
               let videoInput: AVCaptureDeviceInput

               do {
                   videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
               } catch {
                   return
               }

               if (captureSession.canAddInput(videoInput)) {
                   captureSession.addInput(videoInput)
               } else {
                   failed()
                   return
               }

               let metadataOutput = AVCaptureMetadataOutput()

               if (captureSession.canAddOutput(metadataOutput)) {
                   captureSession.addOutput(metadataOutput)

                   metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
                   metadataOutput.metadataObjectTypes = [.qr]
               } else {
                   failed()
                   return
               }

               previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
               previewLayer.frame = vwScaner.layer.bounds
               previewLayer.videoGravity = .resizeAspectFill
              self.vwScaner.layer.addSublayer(previewLayer)

               captureSession.startRunning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)

           if (captureSession?.isRunning == false) {
               captureSession.startRunning()
           }
       }

       override func viewWillDisappear(_ animated: Bool) {
           super.viewWillDisappear(animated)

           if (captureSession?.isRunning == true) {
               captureSession.stopRunning()
           }
       }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
           return .lightContent
       }
    
    //MARK: - SCANNER FUNTIONS
    func failed() {
            let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
            captureSession = nil
        }
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
            captureSession.stopRunning()

            if let metadataObject = metadataObjects.first {
                guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
                guard let stringValue = readableObject.stringValue else { return }
                AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
                found(code: stringValue)
            }

            dismiss(animated: true)
        }

        func found(code: String) {
            print(code)
            self.navigationController?.popViewController(animated: true)
            callBack?(code)
        }

        override var prefersStatusBarHidden: Bool {
            return true
        }

        override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
            return .portrait
        }
   
    
    //MARK: - ACTIONS
    @IBAction func actionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }


}
