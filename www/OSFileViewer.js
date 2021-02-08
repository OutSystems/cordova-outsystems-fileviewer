var exec = require('cordova/exec');

exports.previewDocumentFromLocalPath = function (filePath, success, error) {
    exec(success, error, 'OSFileViewer', 'previewDocumentFromLocalPath', [filePath]);
};

exports.previewDocumentFromUrl = function (url, success, error) {
    exec(success, error, 'OSFileViewer', 'previewDocumentFromUrl', [url]);
};

exports.openDocumentFromLocalPath = function (filePath, success, error) {
    exec(success, error, 'OSFileViewer', 'openDocumentFromLocalPath', [filePath]);
};

exports.openDocumentFromUrl = function (url, success, error) {
    exec(success, error, 'OSFileViewer', 'openDocumentFromUrl', [url]);
};

exports.previewMediaContent = function (url, success, error) {
    exec(success, error, 'OSFileViewer', 'previewMediaContent', [url]);
};


