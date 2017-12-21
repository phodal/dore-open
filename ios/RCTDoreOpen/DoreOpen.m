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

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
    
}

- (instancetype)initWithPreviewItemUrl:(NSString*)url {
    NSAssert(url != nil, @"Preview Item URL cannot be nil");
    self = [super init];
    if (self) {
        _url = url;
        [self initialize];
    }
    return self;
}

- (void)initialize {
    self.previewCtrl = [[QLPreviewController alloc] init];
    self.previewCtrl.delegate = self;
    self.previewCtrl.dataSource = self;
    self.previewView = self.previewCtrl.view;
    self.clipsToBounds = YES;
    [self addSubview:self.previewCtrl.view];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.previewView setFrame:self.frame];
}

- (void)setUrl:(NSString *)urlString {
    _url = [urlString stringByRemovingPercentEncoding];
    [self.previewCtrl refreshCurrentPreviewItem];
}

- (void)setAssetFileName:(NSString*)filename {
    _url = [[NSBundle mainBundle] pathForResource:[filename stringByDeletingPathExtension] ofType:[filename pathExtension]];
    [self.previewCtrl refreshCurrentPreviewItem];
}

RCT_EXPORT_METHOD(open:(NSString *) url) {
    
}

#pragma mark - QLPreviewControllerDataSource

- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller {
    return 1;
}

- (id <QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index {
    return [NSURL URLWithString:_url];
}

#pragma mark - QLPreviewControllerDelegate

- (BOOL)previewController:(QLPreviewController *)controller shouldOpenURL:(NSURL *)url forPreviewItem:(id <QLPreviewItem>)item {
    return YES;
}

@end
