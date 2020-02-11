- .h
- 
```ObjC
#import <UIKit/UIKit.h>
#import "NetworkListener.h"

@interface BaseViewController : UIViewController

/// 网络连接状态
@property (readonly, assign, nonatomic) NetworkStatus networkStatus;

@end
```

- .m

```ObjC
@interface BaseViewController ()
@property (readwrite, assign, nonatomic) NetworkStatus networkStatus;
@end


@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    [self listenerNetworkStatus];
}

#pragma mark - Private Methods
- (void)listenerNetworkStatus {
    [[NetworkListener sharedManager] startNetworkReachabilityListener:^(NetworkStatus status) {
        self.networkStatus = status;
    }];
}

@end
```