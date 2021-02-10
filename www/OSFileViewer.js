var exec = require('cordova/exec');

exports.previewDocumentFromLocalPath = function (filePath, fileMIMEType, success, error) {
    exec(success, error, 'CDVFileViewer', 'previewDocumentFromLocalPath', [filePath, fileMIMEType]);
};

exports.previewDocumentFromUrl = function (url, fileMIMEType, success, error) {
    exec(success, error, 'CDVFileViewer', 'previewDocumentFromUrl', [url, fileMIMEType]);
};

exports.openDocumentFromLocalPath = function (filePath, fileMIMEType, success, error) {
    exec(success, error, 'CDVFileViewer', 'openDocumentFromLocalPath', [filePath, fileMIMEType]);
};

exports.openDocumentFromUrl = function (url, success, error) {
    exec(success, error, 'OSFileViewer', 'openDocumentFromUrl', [url]);
};

exports.previewMediaContent = function (url, fileMIMEType, success, error) {
    exec(success, error, 'CDVFileViewer', 'previewMediaContent', [url, fileMIMEType]);
};


