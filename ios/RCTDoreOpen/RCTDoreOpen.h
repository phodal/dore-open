#import <React/RCTBridgeModule.h>
#import <Foundation/Foundation.h>
#import <QuickLook/QuickLook.h>

@interface DoreOpen : NSObject <QLPreviewControllerDelegate,QLPreviewControllerDataSource, QLPreviewItem>

@property(strong, nonatomic) NSURL *fileUrl;
@property(readonly) NSURL *previewItemURL;
@property (nonatomic, copy) NSString* callbackId;

@end
