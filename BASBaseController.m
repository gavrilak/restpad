//
//  BASBaseController.m
//  RestrauntSystemPad
//
//  Created by Sergey on 19.07.14.
//  Copyright (c) 2014 BestAppStudio. All rights reserved.
//

#import "BASBaseController.h"
#import "CustomBadge.h"
#import "BASTablesController.h"
#import "BASOrdersController.h"
#import "BASMenuController.h"
#import "BASEmployeesController.h"
#import "BASWarehouseController.h"
#import "BASNotifyController.h"
#import "BASStatisticViewController.h"

@interface BASBaseController ()

@property (nonatomic, strong) CustomBadge *customBadge;

@end

@implementation BASBaseController



- (NSArray *)viewControllers{
    TheApp;
    if(_viewControllers == nil){
        
        NSMutableArray* temp = [[NSMutableArray alloc]initWithCapacity:6];
        

        [temp addObject:[BASTablesController new]];

        [temp addObject:[BASOrdersController new]];
        
        [temp addObject:[BASMenuController new]];
        
        [temp addObject:[BASEmployeesController new]];

        if(app.userType == UserTypeBoss){
            [temp addObject:[BASWarehouseController new]];
            [temp addObject:[BASStatisticViewController new]];
        }
        
        [temp addObject:[BASNotifyController new]];
        
        self.viewControllers = [NSArray arrayWithArray:temp];
        
    }
    return _viewControllers;
}
- (id)init
{
    self = [super init];
    if (self) {
       
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.view setBackgroundColor:[UIColor clearColor]];
    
    
}

#pragma mark - Public methods
- (void)setupBtnLogout
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *btnImg = [Settings image:ImageForHallsBtnLogout];
    btn.frame = CGRectMake(0.f, 0.f, btnImg.size.width, btnImg.size.height);
    [btn setImage:btnImg forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnLogoutPressed) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = barBtnItem;
}
- (void)setupBackBtn
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *btnImg = [Settings image:ImageForNavBarBtnBack];
    btn.frame = CGRectMake(0.f, 0.f, btnImg.size.width, btnImg.size.height);
    [btn setImage:btnImg forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnBackPressed) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = barBtnItem;
}
- (void)clearNoticesCount{
    TheApp;
    app.isNotice = NO;
    dispatch_async(dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:nil];
        [[self.view viewWithTag:111] removeFromSuperview];
        
        //[[self.tabBar.items objectAtIndex:TabBarItemNotices] setBadgeValue:nil];
    });
}
- (void)showNoticesCount:(NSUInteger)noticesCnt
{
    TheApp;
    [app.tabBar showNoticesCount:noticesCnt];

}
- (void)btnLogoutPressed{
    TheApp;
    [app btnLogoutPressed];
}

- (void)UpdateTablesView{
    
}
@end
