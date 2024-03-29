//
//  OSFileViewer.swift
//  FileViewer
//
//  Created by Outsystems on 27/01/2021.
//

import UIKit

@objc(OSFileViewer)
class OSFileViewer : CDVPlugin {
    
    var plugin: FileViewerPlugin!
    var callbackId:String=""
    
    override func pluginInitialize() {
        plugin = FileViewerPlugin()
        plugin.rootViewController = self.viewController
    }
    
    @objc(isValidURL:)
    func isValidURL(command: CDVInvokedUrlCommand) {
        callbackId = command.callbackId
        
        let url = command.arguments[0] as? String ?? ""
        if url.isValidUrl() {
            sendResult(result: "true", error: "")
        } else {
            sendResult(result: "false", error: "")
        }
    }

    @objc(previewDocumentFromLocalPath:)
    func previewDocumentFromLocalPath(command: CDVInvokedUrlCommand) {
        callbackId = command.callbackId
        let filePath = command.arguments[0] as? String ?? ""
        do {
            try plugin.previewDocumentFromLocalPath(filePath: filePath)
        } catch {
            sendResult(result: "", error: error.localizedDescription)
        }
    }
    
    @objc(previewDocumentFromResources:)
    func previewDocumentFromResources(command: CDVInvokedUrlCommand) {
        callbackId = command.callbackId
        let fileName = command.arguments[0] as? String ?? ""
        let fileExtension = command.arguments[1] as? String ?? ""
        do {
            try plugin.previewDocumentFromResources(fileName: fileName, ext: fileExtension)
        } catch {
            sendResult(result: "", error: error.localizedDescription)
        }
    }
    
    @objc(previewDocumentFromUrl:)
    func previewDocumentFromUrl(command: CDVInvokedUrlCommand) {
        callbackId = command.callbackId
        let url = command.arguments[0] as? String ?? ""
        plugin.previewDocumentFromUrl(url: url, completion: { (inner: ErrorCompletionHandler) in
            do {
                _ = try inner()
            } catch {
                self.sendResult(result: "", error: error.localizedDescription)
            }
        })
    }
    
    @objc(openDocumentFromLocalPath:)
    func openDocumentFromLocalPath(command: CDVInvokedUrlCommand) {
        callbackId = command.callbackId
        let filePath = command.arguments[0] as? String ?? ""
        do {
            try plugin.openDocumentFromLocalPath(filePath: filePath, completion: sendResultOK)
        } catch {
            sendResult(result: "", error: error.localizedDescription)
        }
    }
    
    func sendResultOK() {
        sendResult(result: "", error: "")
    }
    
    @objc(openDocumentFromResources:)
    func openDocumentFromResources(command: CDVInvokedUrlCommand) {
        callbackId = command.callbackId
        let fileName = command.arguments[0] as? String ?? ""
        let fileExtension = command.arguments[1] as? String ?? ""
        do {
            try plugin.openDocumentFromResources(fileName: fileName, ext: fileExtension, completion: sendResultOK)
        } catch {
            sendResult(result: "", error: error.localizedDescription)
        }
    }
    
    @objc(openDocumentFromUrl:)
    func openDocumentFromUrl(command: CDVInvokedUrlCommand) {
        callbackId = command.callbackId
        let url = command.arguments[0] as? String ?? ""
        plugin.openDocumentFromUrl(url: url, completion: { (inner: ErrorCompletionHandler) -> Void in
            do {
                _ = try inner()
            } catch {
                self.sendResult(result: "", error: error.localizedDescription)
            }
        })
    }
    
    @objc(previewMediaContentFromLocalPath:)
    func previewMediaContentFromLocalPath(command: CDVInvokedUrlCommand) {
        callbackId = command.callbackId
        let filePath = command.arguments[0] as? String ?? ""
        do {
            try plugin.previewMediaContentFromLocalPath(filePath: filePath)
        } catch {
            sendResult(result: "", error: error.localizedDescription)
        }
    }
    
    @objc(previewMediaContentFromResources:)
    func previewMediaContentFromResources(command: CDVInvokedUrlCommand) {
        callbackId = command.callbackId
        let fileName = command.arguments[0] as? String ?? ""
        let fileExtension = command.arguments[1] as? String ?? ""
        do {
            try plugin.previewMediaContentFromResources(fileName: fileName, ext: fileExtension)
        } catch {
            sendResult(result: "", error: error.localizedDescription)
        }
    }
    
    @objc(previewMediaContentFromUrl:)
    func previewMediaContentFromUrl(command: CDVInvokedUrlCommand) {
        callbackId = command.callbackId
        let url = command.arguments[0] as? String ?? ""
        do {
            try plugin.previewMediaContentFromUrl(url: url)
        } catch {
            sendResult(result: "", error: error.localizedDescription)
        }
    }

    @objc(sendResult:error:)
    func sendResult(result:String,error:String) {
        var pluginResult = CDVPluginResult (status: CDVCommandStatus_ERROR);
        
        if error.isEmpty {
            let resultArray = [result]
            pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: resultArray)
        } else {
            let errorDict = ["code": "0", "message": error]
            pluginResult = CDVPluginResult(status: CDVCommandStatus_ERROR, messageAs: errorDict);
        }
        self.commandDelegate!.send(pluginResult, callbackId: callbackId);
        
        viewController.dismiss(animated: true, completion: nil)
    }
    
}
