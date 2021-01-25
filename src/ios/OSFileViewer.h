#import <Cordova/CDV.h>

@interface OSDocumentViewer : CDVPlugin

- (void)previewDocumentFromLocalPath:(CDVInvokedUrlCommand*)command;
- (void)previewDocumentFromUrl:(CDVInvokedUrlCommand*)command;
- (void)openDocumentFromLocalPath:(CDVInvokedUrlCommand*)command;
- (void)openDocumentFromUrl:(CDVInvokedUrlCommand*)command;
- (void)previewMediaContent:(CDVInvokedUrlCommand*)command;

@end
