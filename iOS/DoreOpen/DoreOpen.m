#import "DoreOpen.h"
#import <QuickLook/QuickLook.h>
#import <React/RCTBridge.h>
#import <React/RCTEventDispatcher.h>

@interface DoreOpen () <QLPreviewControllerDataSource, QLPreviewControllerDelegate>

@property UIView* previewView;
@property QLPreviewController* previewCtrl;

@end

@implementation DoreOpen

@synthesize bridge = _bridge;

RCT_EXPORT_METHOD(open:(NSString *) url)
{

}

- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller {
  return 1;
}

- (nonnull id<QLPreviewItem>)previewController:(nonnull QLPreviewController *)controller previewItemAtIndex:(NSInteger)index {
  return self;
}

+ (NSString *)moduleName {
    return @"DoreOpen";
}

@end

