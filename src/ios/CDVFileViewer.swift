//
//  FileViewerPlugin.swift
//
//  Created by Outsystems on 27/01/2021.
//

import UIKit

@objc(CDVFileViewer)
class CDVFileViewer : CDVPlugin {
    
    var plugin: FileViewerPlugin!
    var callbackId:String=""
    
    override func pluginInitialize() {
        plugin = FileViewerPlugin()
        plugin.rootViewController = self.viewController
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
    
    @objc(previewDocumentFromUrl:)
    func previewDocumentFromUrl(command: CDVInvokedUrlCommand) {
        callbackId = command.callbackId
        let url = command.arguments[0] as? String ?? ""
        do {
            try plugin.previewDocumentFromUrl(url: url)
        } catch {
            sendResult(result: "", error: error.localizedDescription)
        }
    }
    
    @objc(openDocumentFromLocalPath:)
    func openDocumentFromLocalPath(command: CDVInvokedUrlCommand) {
        callbackId = command.callbackId
        let filePath = command.arguments[0] as? String ?? ""
        do {
            try plugin.openDocumentFromLocalPath(filePath: filePath)
        } catch {
            sendResult(result: "", error: error.localizedDescription)
        }
    }
    
    @objc(openDocumentFromUrl:)
    func openDocumentFromUrl(command: CDVInvokedUrlCommand) {
        callbackId = command.callbackId
        let url = command.arguments[0] as? String ?? ""
        do {
            try plugin.openDocumentFromUrl(url: url)
        } catch {
            sendResult(result: "", error: error.localizedDescription)
        }
    }
    
    @objc(previewMediaContent:)
    func previewMediaContent(command: CDVInvokedUrlCommand) {
        callbackId = command.callbackId
        let url = command.arguments[0] as? String ?? ""
        do {
            try plugin.previewMediaContent(filePath: url)
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
            let resultErrorArray = [error]
            pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: resultErrorArray);
        }
        self.commandDelegate!.send(pluginResult, callbackId: callbackId);
        
        viewController.dismiss(animated: true, completion: nil)
    }
    
}
