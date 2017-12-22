#import "DoreOpen.h"
#import <QuickLook/QuickLook.h>
#import <React/RCTBridge.h>
#import <React/RCTEventDispatcher.h>

@interface DoreOpen () <RCTBridgeModule, QLPreviewControllerDataSource, QLPreviewControllerDelegate>

@property UIView* previewView;
@property QLPreviewController* previewCtrl;
@property NSString *_url;

@end

@implementation DoreOpen

@synthesize bridge = _bridge;

RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(open:(NSString *) path) {
    if (path != nil && [path length] > 0) {
        NSURL *url = [NSURL URLWithString:path];
        self._url = url;
        
        self.previewCtrl = [[QLPreviewController alloc] init];
        self.previewCtrl.delegate = self;
        self.previewCtrl.dataSource = self;
        self.previewView = self.previewCtrl.view;
        
        [self.previewCtrl.navigationItem setRightBarButtonItem:nil];
        UIWindow *window = RCTKeyWindow();
    
        CGFloat width;
        CGFloat height;

        UIInterfaceOrientation deviceOrientation = [UIApplication sharedApplication].statusBarOrientation;
        if(UIInterfaceOrientationIsLandscape(deviceOrientation)){
            width = window.frame.size.width;
            height= window.frame.size.height;
        } else {
            width = window.frame.size.width;
            height= window.frame.size.height;
        }
        self.previewCtrl.view.frame = CGRectMake(0, 0, width, height);
        [self.previewCtrl refreshCurrentPreviewItem];

        dispatch_async(dispatch_get_main_queue(), ^{

            [window addSubview:self.previewCtrl.view];
            
            [window makeKeyAndVisible];

        });
    } else {
        NSLog(@"Dore.open - Missing URL argument");
    }
}

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
    return [NSURL URLWithString:self._url];
}

- (void)previewControllerDidDismiss:(QLPreviewController *)controller {
    NSLog(@"Dismiss");
}

- (NSURL *)previewItemURL {
    return self._url;
}

@end
