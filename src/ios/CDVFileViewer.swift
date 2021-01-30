
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
        if !filePath.isEmpty {
            let url = URL(fileURLWithPath: filePath)
            do {
                try plugin.previewDocumentFromLocaPath(url: url)
            } catch let error {
                sendResult(result: "", error: error.localizedDescription)
            }
        }

    }
    
    @objc(previewDocumentFromUrl:)
    func previewDocumentFromUrl(command: CDVInvokedUrlCommand) {
        let url = command.arguments[0] as? String ?? ""
        if (!url.isEmpty) {
            do {
                try plugin.previewDocumentFromUrl(url: URL(string: url)!)
            } catch {
                sendResult(result: "", error: error.localizedDescription)
            }
        }
    }
    
    @objc(openDocumentFromLocalPath:)
    func openDocumentFromLocalPath(command: CDVInvokedUrlCommand) {
        let filePath = command.arguments[0] as? String ?? ""
        if (!filePath.isEmpty) {
            let url = URL(fileURLWithPath: filePath)
            do {
                try plugin.openDocumentFromUrl(url: url)
            } catch {
                sendResult(result: "", error: error.localizedDescription)
            }
        }
    }
    
    @objc(openDocumentFromUrl:)
    func openDocumentFromUrl(command: CDVInvokedUrlCommand) {
        let url = command.arguments[0] as? String ?? ""
        if (!url.isEmpty) {
            do {
                try plugin.openDocumentFromUrl(url: URL(string: url)!)
            } catch {
                sendResult(result: "", error: error.localizedDescription)
            }
        }
    }
    
    @objc(previewMediaContent:)
    func previewMediaContent(command: CDVInvokedUrlCommand) {
        let url = command.arguments[0] as? String ?? ""
        if (!url.isEmpty) {
            do {
                try plugin.previewMediaContent(url: URL(fileURLWithPath: url))
            } catch {
                sendResult(result: "", error: error.localizedDescription)
            }
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
