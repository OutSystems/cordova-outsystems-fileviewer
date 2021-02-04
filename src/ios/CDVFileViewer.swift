
import UIKit
import PDFKit


var callbackId:String=""

@objc(CDVFileViewer)
class CDVFileViewer : CDVPlugin {
    
    var plugin: FileViewerPlugin!
    
    override func pluginInitialize() {
        plugin = FileViewerPlugin(viewController: viewController)
    }

    @objc(previewDocumentFromLocalPath:)
    func previewDocumentFromLocalPath(command: CDVInvokedUrlCommand) {
        let filePath = command.arguments[0] as? String ?? ""
        do {
            try plugin.previewDocumentFromLocalPath(url: filePath)
        } catch {
            sendResult(result: "", error: error.localizedDescription)
        }

    }
    
    @objc(previewDocumentFromUrl:)
    func previewDocumentFromUrl(command: CDVInvokedUrlCommand) {
        let url = command.arguments[0] as? String ?? ""
        do {
            try plugin.previewDocumentFromUrl(url: url)
        } catch {
            sendResult(result: "", error: error.localizedDescription)
        }
    }
    
    @objc(openDocumentFromLocalPath:)
    func openDocumentFromLocalPath(command: CDVInvokedUrlCommand) {
        let filePath = command.arguments[0] as? String ?? ""
        do {
            try plugin.openDocumentFromLocalPath(url: filePath)
        } catch {
            sendResult(result: "", error: error.localizedDescription)
        }
    }
    
    @objc(openDocumentFromUrl:)
    func openDocumentFromUrl(command: CDVInvokedUrlCommand) {
        let url = command.arguments[0] as? String ?? ""
        do {
            try plugin.openDocumentFromUrl(url: url)
        } catch {
            sendResult(result: "", error: error.localizedDescription)
        }
    }
    
    @objc(previewMediaContent:)
    func previewMediaContent(command: CDVInvokedUrlCommand) {
        let url = command.arguments[0] as? String ?? ""
        do {
            try plugin.previewMediaContent(url: url)
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
