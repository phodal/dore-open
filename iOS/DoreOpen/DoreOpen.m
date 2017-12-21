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

RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(open:(NSString *) path {
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
                UIWindow *window = RCTKeyWindow();
//                [window presentViewController:previewCtrl animated:YES completion:nil];
                [window addSubview:self.previewCtrl.view];
            });
            
            NSLog(@"cordova.disusered.open - Success!");
            
        } else {
            NSLog(@"cordova.disusered.open - Invalid file URL");
        }
    } else {
        NSLog(@"cordova.disusered.open - Missing URL argument");
    }
})

#pragma mark - QLPreviewControllerDataSource

- (NSInteger)numberOfPreviewItemsInPreviewController:
(QLPreviewController *)controller {
    return 1;
}

- (id<QLPreviewItem>)previewController:(QLPreviewController *)controller
                    previewItemAtIndex:(NSInteger)index {
    return self;
}

#pragma mark - QLPreviewControllerDelegate

- (BOOL)previewController:(QLPreviewController *)controller shouldOpenURL:(NSURL *)url forPreviewItem:(id <QLPreviewItem>)item {
    return YES;
}

- (void)previewControllerDidDismiss:(QLPreviewController *)controller {
    NSLog(@"Dismiss");
}

- (NSURL *)previewItemURL {
    return self.fileUrl;
}

@end
