//
//  CameraAccess.m
//

#import "CameraAccess.h"

@implementation CameraAccess

@synthesize callbackId;

- (void) checkAccess:(CDVInvokedUrlCommand *)command {

    // Check for permission
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];

    CDVPluginResult* result = nil;

    if (authStatus == AVAuthorizationStatusAuthorized) {
        NSLog(@"Access to camera granted");
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"Access granted"];
        [self invokeCallback:command withResult:result];
    }
    else if (authStatus == AVAuthorizationStatusNotDetermined) {
        NSLog(@"Access to camera not yet determined. Will ask user.");
        __block CDVPluginResult* result = nil;

        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if(granted){
                NSLog(@"Granted access to %@", AVMediaTypeVideo);
                result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"Access granted"];
                [self invokeCallback:command withResult:result];
            } else {
                NSLog(@"Not granted access to %@", AVMediaTypeVideo);
                result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Access denied"];
                [self invokeCallback:command withResult:result];
            }
        }];
    }
    else {
        NSLog(@"Access to camera denied");
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Access denied"];
        [self invokeCallback:command withResult:result];
    }
}

- (void) invokeCallback:(CDVInvokedUrlCommand *)command withResult:(CDVPluginResult *)result {
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

@end
