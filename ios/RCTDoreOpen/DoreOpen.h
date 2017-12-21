#import <UIKit/UIKit.h>
#import <React/RCTUtils.h>
#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>

@interface DoreOpen : RCTEventEmitter <RCTBridgeModule>

- (instancetype)initWithPreviewItemUrl:(NSString*)url;

@end
