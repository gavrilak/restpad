//
//  BASAppDelegate.h
//  RestrauntSystemPad
//
//  Created by Sergey on 19.07.14.
//  Copyright (c) 2014 BestAppStudio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Settings.h"
#import "BASBaseController.h"
#import "BASTabbar.h"
#import "BASVirtualTableView.h"
#import "Reachability.h"

@class RCSAuthViewController;

@interface BASAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) UINavigationController* navController;
@property (nonatomic, strong) RCSAuthViewController* authController;
@property (nonatomic, strong) BASBaseController* baseController;
@property ( nonatomic,strong) BASVirtualTableView* virtualView;
@property (nonatomic, retain) Reachability* internetReachable;
@property (nonatomic, strong) BASTabbar* tabBar;
@property (nonatomic, assign) UserType userType;
@property (nonatomic, assign) NSUInteger noticeCnt;
@property (nonatomic, assign) BOOL isNotice;
@property (nonatomic, assign) BOOL isOrder;
@property (nonatomic, assign) BOOL isWaiter;
@property (nonatomic, assign) BOOL isBackground;
@property (nonatomic, assign) BOOL isShowMessage;
@property (nonatomic, assign) BOOL isVirtual;
@property (nonatomic, strong) NSDictionary* employeeInfo;
@property (nonatomic, strong) NSArray* orders;
@property (nonatomic, assign) NSUInteger curCoastOrder;
@property (nonatomic, assign) NSUInteger id_table;
@property (nonatomic, assign) NSUInteger id_order;
@property (nonatomic, strong) NSDictionary* titleInfo;
@property (nonatomic, strong) NSArray* tableList;
@property (nonatomic, strong) NSArray* waiterList;
@property (nonatomic, strong) NSString* noticeMessage;
@property (nonatomic, assign) BOOL isValidData;
@property (nonatomic, strong) NSArray* jobsList;
@property (nonatomic, strong) NSArray* employeesList;
@property (nonatomic, strong) NSArray* dishesList;
@property (nonatomic, strong) NSArray* menuList;
@property (nonatomic, assign) BOOL isBusy;
@property(nonatomic, strong) UIPopoverController *popover;

- (NSArray*)sortContent:(NSArray*)source withType:(SwitchType)type;
- (void)startbackgroundTask;
- (BOOL) is4InchScreen;
- (void)setNoticeCnt:(NSUInteger)noticeCnt;
- (NSString*)formatMessage:(NSString*)message;
- (void) showViewInPopover:(UIViewController*)controller withView:(UIView*)view withFrame:(CGRect)frame;
- (void) btnLogoutPressed;
- (void)initPickerData;
@end
