//
//  BASManager.m
//  RestaurantControlSystem
//
//  Created by Sergey on 26.05.14.
//  Copyright (c) 2014 BestApp Studio. All rights reserved.
//

#import "BASManager.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

@interface BASManager()

@end

@implementation BASManager


+ (BASManager *)sharedInstance {
    
    static dispatch_once_t once;
    static BASManager *sharedInstance;
    
    dispatch_once(&once, ^{
        sharedInstance = [BASManager new];
    });
    
    
    return sharedInstance;
}
- (NSDictionary*)formatRequest:(NSString*)command withParam:(NSDictionary*)param{
    NSDictionary* dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          command,@"command",
                          param,@"param",
                          nil];
    return dict;
}
- (void)getData:(NSDictionary*)dict success:(void(^)(id responseObject))success failure:(void (^) (NSString *error))failure{
   
     @synchronized(self) {
        __block UserType userType = userType;
        NSError* error = nil;
        
        NSURL *baseUrl = [NSURL URLWithString:[Settings text:TextForAPIBaseURL]];
        
        __block ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:baseUrl];
        [request addRequestHeader:@"Content-Type" value:@"application/json"];
        [request setRequestMethod:@"POST"];

        [request setPostBody:[NSMutableData dataWithData:[NSJSONSerialization dataWithJSONObject:dict options:0 error:&error]]];
        
     
        [request setCompletionBlock:^{
           // NSString* str = @"{\"param\":[{\"id_category\":0,\"name_category\":\"Desserts\",\"load\":2,\"modificators\":[{\"id_modificator\":1,\"name_modificator\":\"With add fruits\"}]},{\"id_category\":1,\"name_category\":\"Salads\",\"load\":0,\"modificators\":[{\"id_modificator\":0,\"name_modificator\":\"Without salt\"}]},{\"id_category\":2,\"name_category\":\"Soups\",\"load\":1,\"modificators\":[]},{\"id_category\":3,\"name_category\":\"Alcohol\",\"load\":2,\"modificators\":[{\"id_modificator\":2,\"name_modificator\":\"With ice\"}]},{\"id_category\":4,\"name_category\":\"Drinks\",\"load\":1,\"modificators\":[]}]}";
            //NSData* data = [str dataUsingEncoding:NSUTF8StringEncoding];
           // id json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            
            NSString* responceString = [[NSString alloc] initWithData:[request responseData] encoding:NSWindowsCP1251StringEncoding];
            if(responceString != nil){
                NSData* responceData = [responceString dataUsingEncoding:NSUTF8StringEncoding];
                id json = [NSJSONSerialization JSONObjectWithData:responceData options:kNilOptions error:nil];
                success (json);
            }
        }];
        
        [request setFailedBlock:^{
            NSError *error = [request error];
            failure (error.localizedDescription);
            
        }];
        
        [request setShouldContinueWhenAppEntersBackground:YES];
        [request setTimeOutSeconds:10];
        [request startAsynchronous];
     }
}
- (void)showAlertViewWithMess:(NSString *)mess
{
    TheApp;
    if(!app.isShowMessage){
        app.isShowMessage = YES;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[Settings text:TextForAuthAlertTitle] message:mess delegate:self cancelButtonTitle:[Settings text:TextForAuthAlertCancel] otherButtonTitles:nil];
        [alert show];
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView.cancelButtonIndex == buttonIndex){
        TheApp;
        app.isShowMessage = NO;
    }
}
@end
