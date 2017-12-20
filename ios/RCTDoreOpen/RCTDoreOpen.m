#import "RCTDoreOpen.h"

@implementation DoreOpen

RCT_EXPORT_MODULE();

RCT_REMAP_METHOD(open,
                 resolver:(RCTPromiseResolveBlock)resolve
                 rejecter:(RCTPromiseRejectBlock)reject)
{
    resolve(@"Hello World!");
}

@end
