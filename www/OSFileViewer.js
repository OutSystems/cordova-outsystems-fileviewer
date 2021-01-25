var exec = require('cordova/exec');

exports.previewFileFromLocalPath = function (filePath, fileMIMEType, success, error) {
    exec(success, error, 'OSFileViewer', 'previewFileFromLocalPath', [filePath, fileMIMEType]);
};

exports.previewFileFromUrl = function (url, fileMIMEType, success, error) {
    exec(success, error, 'OSFileViewer', 'previewFileFromUrl', [url, fileMIMEType]);
};

exports.openFileFromLocalPath = function (filePath, fileMIMEType, success, error) {
    exec(success, error, 'OSFileViewer', 'openFileFromLocalPath', [filePath, fileMIMEType]);
};

exports.openFileFromUrl = function (url, fileMIMEType, success, error) {
    exec(success, error, 'OSFileViewer', 'openFileFromUrl', [url, fileMIMEType]);
};