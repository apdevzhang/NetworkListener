//
//  Copyright © 2018 Better. All rights reserved.
//

#import <Foundation/Foundation.h>
#if __has_include(<Reachability/Reachability.h>)
    #import <Reachability/Reachability.h>
#else
    #import "Reachability.h"
#endif

/**
 typedef NS_ENUM(NSInteger, NetworkStatus) {
     // Apple NetworkStatus Compatible Names.
     NotReachable = 0,
     ReachableViaWiFi = 2,
     ReachableViaWWAN = 1
 };
 */

typedef void (^NetworkReachabilityStatusBlock)(NetworkStatus status);

@interface NetworkListener : NSObject

+ (instancetype)sharedManager;

@property (copy, nonatomic) NetworkReachabilityStatusBlock networkReachabilityStatusBlock;

@property (readonly, assign, nonatomic) NetworkStatus networkStatus;

- (void)startNetworkReachabilityListener:(NetworkReachabilityStatusBlock)block;

- (void)removeNetworkReachabilityListener;

@end
