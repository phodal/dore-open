#import <React/RCTBridgeModule.h>
#import <Foundation/Foundation.h>
#import <QuickLook/QuickLook.h>
#import <UIKit/UIKit.h>
#import <React/RCTUtils.h>
#import <React/RCTEventEmitter.h>


@interface DoreOpen : NSObject <RCTBridgeModule, QLPreviewControllerDelegate,QLPreviewControllerDataSource, QLPreviewItem>

@property(strong, nonatomic) NSURL *fileUrl;
@property(readonly) NSURL *previewItemURL;

@end
