#import "RCTDoreOpen.h"
#import <React/RCTBridge.h>
#import <React/RCTEventDispatcher.h>
#import <React/RCTUtils.h>
#import "UIView+React.h"

@implementation DoreOpen

RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(open: (NSString *) path
                 resolver:(RCTPromiseResolveBlock)resolve
                 rejecter:(RCTPromiseRejectBlock)reject)
{
    if (path != nil && [path length] > 0) {
        
        NSURL *url = [NSURL URLWithString:path];
        NSError *err;
        
        if (url.isFileURL &&
            [url checkResourceIsReachableAndReturnError:&err] == YES) {
            
            self.fileUrl = url;
            
            QLPreviewController *previewCtrl = [[QLPreviewController alloc] init];
            previewCtrl.delegate = self;
            previewCtrl.dataSource = self;
            
            [previewCtrl.navigationItem setRightBarButtonItem:nil];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.viewController presentViewController:previewCtrl animated:YES completion:nil];
            });
            
            NSLog(@"dore.open - Success!");
            
        } else {
            NSLog(@"dore.open - Invalid file URL");
        }
    } else {
        NSLog(@"dore.open - Missing URL argument");
    }
}


#pragma - QLPreviewControllerDataSource Protocol

- (NSInteger)numberOfPreviewItemsInPreviewController:
(QLPreviewController *)controller {
    return 1;
}

- (id<QLPreviewItem>)previewController:(QLPreviewController *)controller
                    previewItemAtIndex:(NSInteger)index {
    return self;
}

- (void)previewControllerDidDismiss:(QLPreviewController *)controller {

}

#pragma - QLPreviewItem Protocol

- (NSURL *)previewItemURL {
    return self.fileUrl;
}

@end
