//
//  BASAppDelegate.m
//  RestrauntSystemPad
//
//  Created by Sergey on 19.07.14.
//  Copyright (c) 2014 BestAppStudio. All rights reserved.
//

#import "BASAppDelegate.h"
#import "RCSAuthViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "BASTablesController.h"
#import "BASNotifyController.h"

#define CIRCLETIME 15.f
#define VIBRCOUNT 5

@interface BASAppDelegate()

@property(nonatomic, strong)  AVAudioPlayer *player;
@property (nonatomic,strong)  AVAudioPlayer* playerNotice;
@property(nonatomic,assign)   int vibrateCount;
@property (nonatomic, retain) NSTimer * vibrateTimer;


@end

@implementation BASAppDelegate


- (BASTabbar*)tabBar{
    if(_tabBar == nil){
        _tabBar = [[BASTabbar alloc]initWithFrame:CGRectMake(0, 648.f, 1024.f, 56.f)];
    }
    
    return _tabBar;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.isShowMessage = NO;
    
    UILocalNotification *localNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    
    if (localNotification)
    {
        NSLog(@"Notification Body: %@",localNotification.alertBody);
        NSLog(@"%@", localNotification.userInfo);
    }
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    self.internetReachable = [Reachability reachabilityForInternetConnection];
    application.applicationIconBadgeNumber = 0;
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [self customizeNavBarAppearance];
    self.authController = [[RCSAuthViewController alloc]init];
    self.window.rootViewController = _authController;
    [self.window makeKeyAndVisible];
    
    return YES;

}
#pragma mark - Public methods
- (NSArray*)sortContent:(NSArray*)source withType:(SwitchType)type{
    
    NSMutableArray* data = [NSMutableArray new];
    NSInteger status = type;
    
    for(NSDictionary* obj in source){
        NSNumber* message_status = (NSNumber*)[obj objectForKey:@"message_status"];
        if([message_status intValue] == status){
            [data addObject:obj];
        }
    }
    
    
    return  [NSArray arrayWithArray:data];
}

- (void)startbackgroundTask{
    [self playBlankMp3];
    [self performSelectorInBackground:@selector(backgroundTask) withObject:nil];
}
- (void)setNoticeCnt:(NSUInteger)noticeCnt
{
    _noticeCnt = noticeCnt;
    
    
    if (_baseController != nil && [_baseController respondsToSelector:@selector(showNoticesCount:)] && _noticeCnt > 0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [[UIApplication sharedApplication] setApplicationIconBadgeNumber:noticeCnt];
            
        });
        [_baseController showNoticesCount:noticeCnt];
    } else {
        [_baseController clearNoticesCount];
    }
    
    
}
- (BOOL) is4InchScreen{
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    if (screenBounds.size.height == 568) {
        return YES;
    }
    return NO;
}

#pragma mark - Private methods
-(void)vibratePhone {
    
    _vibrateCount ++;
    
    if(_vibrateCount <= VIBRCOUNT)
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    else
        [_vibrateTimer invalidate];
    
    
}
- (void) playSound {
    
    NSString *name = [[NSString alloc] initWithFormat:@"alarm4"];
    NSString *source = [[NSBundle mainBundle] pathForResource:name ofType:@"mp3"];
    if (self.playerNotice) {
        [self.playerNotice stop];
        self.playerNotice = nil;
    }
    self.playerNotice=[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath: source] error:NULL];
    self.playerNotice.numberOfLoops = 0;
    [self.playerNotice play];
    
    self.vibrateCount = 0;
    self.vibrateTimer = nil;
    self.vibrateTimer = [NSTimer scheduledTimerWithTimeInterval:0.8f target:self selector:@selector(vibratePhone) userInfo:nil repeats:YES];
    
}
- (void)playBlankMp3
{
    NSError *error = nil;
    [[AVAudioSession sharedInstance] setActive:YES error:&error];
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:&error];
    
    NSString *audioFileName = [[Settings text:TextForBlankAudioFileName] stringByDeletingPathExtension];
    NSString *audioFileExt = [[Settings text:TextForBlankAudioFileName] pathExtension];
    NSURL *audioFileUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:audioFileName ofType:audioFileExt]];
    
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:audioFileUrl error:&error];
    if (error) {
        ALog(@"%@", error);
        
        return;
    }
    
    self.player.numberOfLoops = -1;
    [self.player play];
}

- (void)showLocalNotification
{
    UIApplication* app = [UIApplication sharedApplication];
    
    UILocalNotification* alarm = [[UILocalNotification alloc] init];
    if (alarm)
    {
        alarm.fireDate = [NSDate date];
        alarm.timeZone = [NSTimeZone defaultTimeZone];
        alarm.repeatInterval = 0;
        alarm.soundName = @"alarm4.mp3";
        alarm.alertBody = self.noticeMessage;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [app scheduleLocalNotification:alarm];
        });
    }
}

- (void)backgroundTask {
    
     NSArray* controllers = self.baseController.viewControllers;
    
    while (YES) {
        
        [[BASManager sharedInstance] getData:[[BASManager sharedInstance] formatRequest:[Settings text:TextForApiFuncGetUnreadNoticeCnt] withParam:nil] success:^(NSDictionary* responseObject) {
            
            
            if([responseObject isKindOfClass:[NSDictionary class]]){
                
                NSArray* param = (NSArray*)[responseObject objectForKey:@"param"];
                NSLog(@"Response: %@",param);
                NSDictionary* dict = (NSDictionary*)[param objectAtIndex:0];
                if(dict != nil){
                    NSInteger result = [((NSNumber*)[dict objectForKey:@"count"]) intValue];
                    dict = (NSDictionary*)[dict objectForKey:@"message"];
                    self.noticeMessage = (NSString*)[dict objectForKey:@"message"];

                    if (result > self.noticeCnt) {
                        self.isNotice = YES;
                        if(!self.isBackground){
                            [self setNoticeCnt:result];
                            [self playSound];
                        } else {
                            [self showLocalNotification];
                        }
                        if(_tabBar.selectIndex == controllers.count -1){
                            for (UIViewController *v in self.baseController.viewControllers)
                            {
                                
                                if ([v isKindOfClass:[BASNotifyController class]]){
                                    [((BASNotifyController*)v) updateNotifyData];
                                    break;
                                }
                                
                            }
                        }
                    }
                    
                    self.noticeCnt = result;
                }
            }
           
            if(_tabBar.selectIndex == 0){
                for (UIViewController *v in self.baseController.viewControllers)
                {
        
                    if ([v isKindOfClass:[BASTablesController class]]){
                        //[((BASTablesController*)v) UpdateTablesView];
                        break;
                    }
                   
                }
            }
            
        } failure:^(NSString *error) {
            
        }];
        
        [NSThread sleepForTimeInterval:CIRCLETIME];
    }
}
- (void) showViewInPopover:(UIViewController*)controller withView:(UIView*)view withFrame:(CGRect)frame{
    if(!self.popover.popoverVisible){
        self.popover = nil;
        self.popover  = [[UIPopoverController alloc] initWithContentViewController:controller];
        [_popover setPopoverContentSize:CGSizeMake(320, 568)];
        [_popover presentPopoverFromRect:view.frame inView:view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }
}
- (void)customizeNavBarAppearance
{
    
    
    [[UINavigationBar appearance] setBackgroundImage:[Settings image:ImageForNavBarBg] forBarMetrics:UIBarMetricsDefault];
    
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [Settings color:ColorForNavBarTitleShadow];
    shadow.shadowOffset = [Settings offset:OffsetForNavBarTitleShadow];
    [[UINavigationBar appearance] setTitleTextAttributes:@{
                                                           NSForegroundColorAttributeName:[Settings color:ColorForNavBarTitle],
                                                           NSShadowAttributeName:shadow,
                                                           }];
}
- (void)btnLogoutPressed{
    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"Сообщение" message:@"Вы уверены что хотите завершить работу?" delegate:self cancelButtonTitle:@"Да" otherButtonTitles:@"Нет", nil];
    
    [alertView show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView.cancelButtonIndex == buttonIndex){
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:[Settings text:TextForAuthLoginKey]];
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:[Settings text:TextForAuthPassKey]];
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:[Settings text:TextForAuthRoleKey]];
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"employeeInfo"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        TheApp;
        app.window.rootViewController = (RCSAuthViewController*) app.authController;
    }
}
- (void)initPickerData{
    
    BASManager* manager = [BASManager sharedInstance];
    __block NSMutableArray* content = [NSMutableArray new];
    __block NSDictionary* dict = nil;
    
    [manager getData:[manager formatRequest:@"GETJOBLIST" withParam:nil] success:^(id responseObject) {
        
        if([responseObject isKindOfClass:[NSDictionary class]]){
            
            NSArray* param = (NSArray*)[responseObject objectForKey:@"param"];
            NSLog(@"Response: %@",param);
            [content addObjectsFromArray:param];
            dict = @{@"id_job":[NSNumber numberWithInt:-1],
                     @"name_job":[NSString stringWithFormat:@"Должность"]
                     };
            [content insertObject:dict atIndex:0];
            self.jobsList = [NSArray arrayWithArray:content];
            [content removeAllObjects];
            [manager getData:[manager formatRequest:@"GETEMPLOYEES" withParam:nil] success:^(id responseObject) {
                
                if([responseObject isKindOfClass:[NSDictionary class]]){
                    
                    NSArray* param = (NSArray*)[responseObject objectForKey:@"param"];
                    [content addObjectsFromArray:param];
                    NSLog(@"Response: %@",param);
                    
                    NSMutableArray* temp = [NSMutableArray new];
                    dict = @{@"id_employee":[NSNumber numberWithInt:-1],
                             @"name":[NSString stringWithFormat:@"Ф.И.О"]
                             };
                    [temp addObject:dict];
                    
                    for(NSDictionary* obj in content){
                        dict = @{@"id_employee":(NSNumber*)[obj objectForKey:@"id_employee"],
                                 @"name":(NSString*)[obj objectForKey:@"name"]
                                 };
                        [temp addObject:obj];
                    }
                   
                    self.employeesList = [NSArray arrayWithArray:temp];

                    [content removeAllObjects];
                    [manager getData:[manager formatRequest:@"GETSUBMENU" withParam:nil] success:^(id responseObject) {
                        
                        if([responseObject isKindOfClass:[NSDictionary class]]){
                            
                            NSArray* param = (NSArray*)[responseObject objectForKey:@"param"];
                            NSLog(@"Response: %@",param);
                            [content addObjectsFromArray:param];
                            dict = @{@"id_dish":[NSNumber numberWithInt:-1],
                                     @"name_dish":[NSString stringWithFormat:@"Блюдо"]
                                     };
                            [content insertObject:dict atIndex:0];
                            self.dishesList = [NSArray arrayWithArray:content];
                            [content removeAllObjects];
                            [manager getData:[manager formatRequest:@"GETMENU" withParam:nil] success:^(id responseObject) {
                                
                                if([responseObject isKindOfClass:[NSDictionary class]]){
                                    
                                    NSArray* param = (NSArray*)[responseObject objectForKey:@"param"];
                                    NSLog(@"Response: %@",param);
                                    [content addObjectsFromArray:param];
                                    dict = @{@"id_category":[NSNumber numberWithInt:-1],
                                             @"name_category":[NSString stringWithFormat:@"Категория"]
                                             };
                                    [content insertObject:dict atIndex:0];
                                    self.menuList = [NSArray arrayWithArray:content];
                                    
                                }
                                
                            } failure:^(NSString *error) {
                                [manager showAlertViewWithMess:ERROR_MESSAGE];
                            }];
                        }
                        
                    } failure:^(NSString *error) {
                        [manager showAlertViewWithMess:ERROR_MESSAGE];
                    }];

                }
                
            } failure:^(NSString *error) {
                [manager showAlertViewWithMess:ERROR_MESSAGE];
            }];

   
        }
        
    } failure:^(NSString *error) {
        [manager showAlertViewWithMess:ERROR_MESSAGE];
    }];

}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    self.isBackground = YES;
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    
    if(self.isBackground){
        NSArray* controllers = self.baseController.viewControllers;
        self.tabBar.selectIndex = controllers.count - 1;
        self.navController = nil;
        self.navController = [[UINavigationController alloc]initWithRootViewController:(UIViewController*)[controllers lastObject]];
        self.window.rootViewController = self.navController;
    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    self.isBackground = NO;
    if(self.jobsList == nil){
        
        [self initPickerData];
        
        
    }
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
