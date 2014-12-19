    //
//  RCSAuthViewController.m
//  RestaurantControlSystem
//
//  Created by Bogdan Stasjuk on 25/11/2013.
//  Copyright (c) 2013 BestApp Studio. All rights reserved.
//

#import "RCSAuthViewController.h"
#import "RCSAuthView.h"




@interface RCSAuthViewController () <UITextFieldDelegate, RCSAuthViewDelegate>

@property(nonatomic, strong) RCSAuthView *authView;

@end


@implementation RCSAuthViewController


#pragma mark - Init methods


#pragma mark - Public methods


#pragma mark - UIViewController methods

- (void)viewDidLoad
{
    [self loadAuthView];
    [self checkAuthorized];
}

#pragma mark - RCSAuthViewDelegate methods
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.authView clearFields];
}
- (void)btnEnterPressedWithLogin:(NSString *)login andPassword:(NSString *)pass
{
    self.authView.activityViewAnimated = YES;

    BASManager* manager = [BASManager sharedInstance];
    
    typedef void(^Success)(UserType userType);
    typedef void(^Failure)(NSString *error);
    Success success = nil;
    Failure failure = nil;

    success = ^(UserType userType){
        [self setTabBarControllerWhenUserType:userType];
    };
   
    
    failure = ^(NSString *error){
        //[[NSUserDefaults standardUserDefaults] setValue:@"Waiter" forKey:[Settings text:TextForAuthLoginKey]];
        //[[NSUserDefaults standardUserDefaults] setValue:@"waiter" forKey:[Settings text:TextForAuthPassKey]];
        //[[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:1] forKey:[Settings text:TextForAuthRoleKey]];
        //[[NSUserDefaults standardUserDefaults] synchronize];
        
        [manager showAlertViewWithMess:error];
        self.authView.activityViewAnimated = NO;
    };
    
    NSDictionary* param = [NSDictionary dictionaryWithObjectsAndKeys:
                           login,@"login",
                           pass,@"pass"
                           , nil];
    

    [manager getData:[manager formatRequest:[Settings text:TextForApiFuncAuth] withParam:param] success:^(NSDictionary* responseObject) {
        
        TheApp;
        NSArray* response = (NSArray*)[responseObject objectForKey:@"param"];
        NSLog(@"Response: %@",response);
        
        NSDictionary* dict = (NSDictionary*)[response objectAtIndex:0];
        
        app.employeeInfo = [NSDictionary dictionaryWithDictionary:dict];
        
        NSString* result = (NSString*)[dict objectForKey:@"result"];
        
        if([result intValue] == 1){
            TheApp;
            NSNumber* role = (NSNumber*)[dict objectForKey:@"id_job"];
            if ([role integerValue] == 0 || [role integerValue] == 6) {
                app.userType = [role intValue];
                [[NSUserDefaults standardUserDefaults] setValue:login forKey:[Settings text:TextForAuthLoginKey]];
                [[NSUserDefaults standardUserDefaults] setValue:pass forKey:[Settings text:TextForAuthPassKey]];
                [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:[role intValue]] forKey:[Settings text:TextForAuthRoleKey]];
                [[NSUserDefaults standardUserDefaults] setValue:app.employeeInfo forKey:@"employeeInfo"];
                [[NSUserDefaults standardUserDefaults] synchronize];

                [app startbackgroundTask];
                success(app.userType);
            } else {
                failure(@"Неверный логин или пароль!");
            }
        } else {
            failure(@"Неверный логин или пароль!");
        }
        
        self.authView.activityViewAnimated = NO;
    } failure:^(NSString *error) {
        failure (error);
    }];

}


#pragma mark - Private methods

- (void)checkAuthorized
{

    TheApp;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    app.employeeInfo = (NSDictionary*)[defaults objectForKey:@"employeeInfo"];
    
    if(app.employeeInfo != nil){
        UserType userType = [((NSNumber*)[defaults objectForKey:[Settings text:TextForAuthRoleKey]]) intValue];
        [self setTabBarControllerWhenUserType:userType];
        [app startbackgroundTask];
    }

}

- (void)loadAuthView
{
    [super viewDidLoad];

    self.authView = [[RCSAuthView alloc] initWithFrame:CGRectMake(0, 0, 1024.f, 768.f)];
    self.authView.delegate = self;
    self.view = self.authView;
}

- (void)setTabBarControllerWhenUserType:(UserType)userType
{
    TheApp;
    app.userType = userType;
    //app.userType = UserTypeAdmin;
    //app.userType = UserTypeBoss;
    app.tabBar = nil;
    app.baseController = [BASBaseController new];
    app.navController = [[UINavigationController alloc]initWithRootViewController:(UIViewController*)[app.baseController.viewControllers objectAtIndex:0]];
    app.window.rootViewController = app.navController;
    

}

@end
