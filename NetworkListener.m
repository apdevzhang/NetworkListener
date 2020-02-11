//
//  Copyright © 2018 Better. All rights reserved.
//

#import "NetworkListener.h"

@interface NetworkListener ()
@property (strong, nonatomic) Reachability *reachability;
@property (readwrite, assign, nonatomic) NetworkStatus networkStatus;
@end

@implementation NetworkListener

+ (instancetype)sharedManager {
    static NetworkListener *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[self alloc] init];
    });
    return _sharedManager;
}

#pragma mark - Public Methods
- (void)startNetworkReachabilityListener:(NetworkReachabilityStatusBlock)block {
    _networkReachabilityStatusBlock = block;
    
    block([self.reachability currentReachabilityStatus]);
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:kReachabilityChangedNotification object:nil] subscribeNext:^(id x) {
        Reachability *reachability = [x object];
        
        NetworkStatus networkStatus = [reachability currentReachabilityStatus];
        
        NSParameterAssert([reachability isKindOfClass:[reachability class]]);
        
        block(networkStatus);
    }];
    
    [self.reachability startNotifier];
}

- (void)removeNetworkReachabilityListener {
    [self.reachability stopNotifier];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
}

#pragma mark - Getter
- (Reachability *)reachability {
    if (!_reachability) {
        _reachability = Reachability.reachabilityForInternetConnection;
    }
    return _reachability;
}

- (NetworkStatus)networkStatus {
    return [self.reachability currentReachabilityStatus];
}

@end
