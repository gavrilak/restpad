//
//  BASBaseController.h
//  RestrauntSystemPad
//
//  Created by Sergey on 19.07.14.
//  Copyright (c) 2014 BestAppStudio. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BASBaseController : UIViewController

@property (nonatomic,assign) NSInteger selectedIndex;
@property (nonatomic,strong) NSArray*  viewControllers;

- (void)setupBtnLogout;
- (void)setupBackBtn;
- (void)clearNoticesCount;
- (void)showNoticesCount:(NSUInteger)noticesCnt;
- (void)UpdateTablesView;


@end
