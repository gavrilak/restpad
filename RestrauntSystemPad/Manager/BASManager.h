//
//  BASManager.h
//  RestaurantControlSystem
//
//  Created by Sergey on 26.05.14.
//  Copyright (c) 2014 BestApp Studio. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BASManager : NSObject

+ (BASManager *)sharedInstance;

- (void)showAlertViewWithMess:(NSString *)mess;
- (void)getData:(NSDictionary*)dict success:(void (^) (NSDictionary* responseObject))success failure:(void (^) (NSString *error))failure;
- (NSDictionary*)formatRequest:(NSString*)command withParam:(id)param;

@end
