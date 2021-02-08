//
//  FileViewerPlugin.swift
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
            try plugin.openDocumentFromLocalPath(filePath: filePath)
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
    
    @objc(previewMediaContent:)
    func previewMediaContent(command: CDVInvokedUrlCommand) {
        callbackId = command.callbackId
        let filePath = command.arguments[0] as? String ?? ""
        do {
            try plugin.previewMediaContent(filePath: filePath)
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
