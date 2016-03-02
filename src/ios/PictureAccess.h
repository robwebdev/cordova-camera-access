//
//  PictureAccess.h
//

#import <Cordova/CDVPlugin.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>

@interface PictureAccess : CDVPlugin

@property (copy)   NSString* callbackId;

- (void) checkAccess:(CDVInvokedUrlCommand *)command;
@end
