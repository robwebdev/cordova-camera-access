/**
 * A simple plugin for Cordova to check access to the camera roll on iOS.
 *
 * Developed by berliner for markveys
 */

var CameraAccess = function() {

};

/*
*	success - success callback
*	fail - error callback
*/
CameraAccess.prototype.checkAccess = function(success, fail) {
  if (device.platform.toLowerCase() != 'ios') {
    success();
    return;
  }
  cordova.exec(success, fail, "CameraAccess", "checkAccess");
};
if(!window.plugins) {
    window.plugins = {};
}
if (!window.plugins.cameraAccess) {
    window.plugins.cameraAccess = new CameraAccess();
}

if (typeof module != 'undefined' && module.exports) {
  module.exports = CameraAccess;
}
