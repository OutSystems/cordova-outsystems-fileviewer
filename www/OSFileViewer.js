var exec = require('cordova/exec');

exports.previewDocumentFromLocalPath = function (filePath, success, error) {
    exec(success, error, 'OSFileViewer', 'previewDocumentFromLocalPath', [filePath]);
};
    
exports.previewDocumentFromResources = function (fileName, fileExtension, success, error) {
    exec(success, error, 'OSFileViewer', 'previewDocumentFromResources', [fileName,fileExtension]);
};

exports.previewDocumentFromUrl = function (url, success, error) {
    exec(success, error, 'OSFileViewer', 'previewDocumentFromUrl', [url]);
};

exports.openDocumentFromLocalPath = function (filePath, success, error) {
    exec(success, error, 'OSFileViewer', 'openDocumentFromLocalPath', [filePath]);
};
    
exports.openDocumentFromResources = function (fileName, fileExtension, success, error) {
    exec(success, error, 'OSFileViewer', 'openDocumentFromResources', [fileName,fileExtension]);
};

exports.openDocumentFromUrl = function (url, success, error) {
    exec(success, error, 'OSFileViewer', 'openDocumentFromUrl', [url]);
};

exports.previewMediaContentFromLocalPath = function (filePath, success, error) {
    exec(success, error, 'OSFileViewer', 'previewMediaContentFromLocalPath', [filePath]);
};
    
exports.previewMediaContentFromResources = function (fileName,fileExtension, success, error) {
    exec(success, error, 'OSFileViewer', 'previewMediaContentFromResources', [fileName,fileExtension]);
};

exports.previewMediaContentFromUrl = function (url, success, error) {
    exec(success, error, 'OSFileViewer', 'previewMediaContentFromUrl', [url]);
};

exports.isValidURL = function (url, success, error) {
    exec(success, error, 'OSFileViewer', 'isValidURL', [url]);
};
