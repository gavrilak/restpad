//
//  BASTabbar.m
//  RestrauntSystemPad
//
//  Created by Sergey on 19.07.14.
//  Copyright (c) 2014 BestAppStudio. All rights reserved.
//

#import "BASTabbar.h"
#import "CustomBadge.h"

@interface BASTabbar(){
    UIButton* curButton;
}

@property (nonatomic,strong)NSArray* buttons;
@property (nonatomic, strong) CustomBadge *customBadge;

@end

@implementation BASTabbar

- (id)initWithFrame:(CGRect)frame
{
    TheApp;
    self = [super initWithFrame:frame];
    if (self) {
        
        NSMutableArray* temp = [[NSMutableArray alloc]initWithCapacity:7];
        
        self.selectIndex = 0;
        [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"tab_bar_ipad_gorizont.png"]]];
 
        
  
        UIButton* button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [button1 setBackgroundColor:[UIColor redColor]];
        [button1 setImage:[UIImage imageNamed:@"tables.png"] forState:UIControlStateNormal];
        [button1 setImage:[UIImage imageNamed:@"tables.png"] forState:UIControlStateHighlighted];
        button1.titleLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:12.f];
        [button1 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [button1 setTitleColor:[UIColor colorWithRed:142.0/255.0 green:215.0/255.0 blue:249.0/255.0 alpha:1.0] forState:UIControlStateHighlighted];
        [button1 setTitleColor:[UIColor colorWithRed:142.0/255.0 green:215.0/255.0 blue:249.0/255.0 alpha:1.0] forState:UIControlStateSelected];
        [button1 setTitle:@"Столы" forState:UIControlStateNormal];
        [button1 setTitle:@"Столы" forState:UIControlStateHighlighted];
        [button1 setTitle:@"Столы" forState:UIControlStateSelected];
        [button1 addTarget:self action:@selector(clikedButton:) forControlEvents:UIControlEventTouchUpInside];
        [button1 setImageEdgeInsets:UIEdgeInsetsMake(-8.f, 43.f, 8.f, 0)];
        [button1 setTitleEdgeInsets:UIEdgeInsetsMake(35.f, -23.f, 0.f, 0)];
        button1.tag = 0;

        
        UIButton* button2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [button2 setImage:[UIImage imageNamed:@"orders.png"] forState:UIControlStateNormal];
        [button2 setImage:[UIImage imageNamed:@"orders.png"] forState:UIControlStateHighlighted];
        button2.titleLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:12.f];
        [button2 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [button2 setTitleColor:[UIColor colorWithRed:142.0/255.0 green:215.0/255.0 blue:249.0/255.0 alpha:1.0] forState:UIControlStateHighlighted];
        [button2 setTitleColor:[UIColor colorWithRed:142.0/255.0 green:215.0/255.0 blue:249.0/255.0 alpha:1.0] forState:UIControlStateSelected];
        [button2 setTitle:@"Заказы" forState:UIControlStateNormal];
        [button2 setTitle:@"Заказы" forState:UIControlStateHighlighted];
        [button2 setTitle:@"Заказы" forState:UIControlStateSelected];
        [button2 addTarget:self action:@selector(clikedButton:) forControlEvents:UIControlEventTouchUpInside];
        [button2 setImageEdgeInsets:UIEdgeInsetsMake(-8.f, 43.f, 8.f, 0)];
        [button2 setTitleEdgeInsets:UIEdgeInsetsMake(35.f, -28.f, 0.f, 0)];
        button2.tag = 1;
        
        UIButton* button3 = [UIButton buttonWithType:UIButtonTypeCustom];
        [button3 setImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
        [button3 setImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateHighlighted];
        button3.titleLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:12.f];
        [button3 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [button3 setTitleColor:[UIColor colorWithRed:142.0/255.0 green:215.0/255.0 blue:249.0/255.0 alpha:1.0] forState:UIControlStateHighlighted];
        [button3 setTitleColor:[UIColor colorWithRed:142.0/255.0 green:215.0/255.0 blue:249.0/255.0 alpha:1.0] forState:UIControlStateSelected];
        [button3 setTitle:@"Меню" forState:UIControlStateNormal];
        [button3 setTitle:@"Меню" forState:UIControlStateHighlighted];
        [button3 setTitle:@"Меню" forState:UIControlStateSelected];
        [button3 addTarget:self action:@selector(clikedButton:) forControlEvents:UIControlEventTouchUpInside];
        [button3 setImageEdgeInsets:UIEdgeInsetsMake(-8.f, 35.f, 8.f, 0)];
        [button3 setTitleEdgeInsets:UIEdgeInsetsMake(35.f, -28.f, 0.f, 0)];
        button3.tag = 2;
        
        UIButton* button4 = [UIButton buttonWithType:UIButtonTypeCustom];
        [button4 setImage:[UIImage imageNamed:@"staff.png"] forState:UIControlStateNormal];
        [button4 setImage:[UIImage imageNamed:@"staff.png"] forState:UIControlStateHighlighted];
        button4.titleLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:12.f];
        [button4 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [button4 setTitleColor:[UIColor colorWithRed:142.0/255.0 green:215.0/255.0 blue:249.0/255.0 alpha:1.0] forState:UIControlStateHighlighted];
        [button4 setTitleColor:[UIColor colorWithRed:142.0/255.0 green:215.0/255.0 blue:249.0/255.0 alpha:1.0] forState:UIControlStateSelected];
        [button4 setTitle:@"Персонал" forState:UIControlStateNormal];
        [button4 setTitle:@"Персонал" forState:UIControlStateHighlighted];
        [button4 setTitle:@"Персонал" forState:UIControlStateSelected];
        [button4 addTarget:self action:@selector(clikedButton:) forControlEvents:UIControlEventTouchUpInside];
        [button4 setImageEdgeInsets:UIEdgeInsetsMake(-8.f, 59.f, 8.f, 0)];
        [button4 setTitleEdgeInsets:UIEdgeInsetsMake(35.f, -24.f, 0.f, 0)];
        button4.tag = 3;
        
        
        UIButton* button5 = [UIButton buttonWithType:UIButtonTypeCustom];
        [button5 setImage:[UIImage imageNamed:@"box.png"] forState:UIControlStateNormal];
        [button5 setImage:[UIImage imageNamed:@"box.png"] forState:UIControlStateHighlighted];
        button5.titleLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:12.f];
        [button5 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [button5 setTitleColor:[UIColor colorWithRed:142.0/255.0 green:215.0/255.0 blue:249.0/255.0 alpha:1.0] forState:UIControlStateHighlighted];
        [button5 setTitleColor:[UIColor colorWithRed:142.0/255.0 green:215.0/255.0 blue:249.0/255.0 alpha:1.0] forState:UIControlStateSelected];
        [button5 setTitle:@"Склад" forState:UIControlStateNormal];
        [button5 setTitle:@"Склад" forState:UIControlStateHighlighted];
        [button5 setTitle:@"Склад" forState:UIControlStateSelected];
        [button5 addTarget:self action:@selector(clikedButton:) forControlEvents:UIControlEventTouchUpInside];
        [button5 setImageEdgeInsets:UIEdgeInsetsMake(-8.f, 40.f, 8.f, 0)];
        [button5 setTitleEdgeInsets:UIEdgeInsetsMake(35.f, -18.f, 0.f, 0)];
        button4.tag = 4;
        
        UIButton* button6 = nil;
        if(app.userType == UserTypeAdmin){
            button6 = [UIButton buttonWithType:UIButtonTypeCustom];
            [button6 setImage:[UIImage imageNamed:@"waiter.png"] forState:UIControlStateNormal];
            [button6 setImage:[UIImage imageNamed:@"waiter.png"] forState:UIControlStateHighlighted];
            button6.titleLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:12.f];
            [button6 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            [button6 setTitleColor:[UIColor colorWithRed:142.0/255.0 green:215.0/255.0 blue:249.0/255.0 alpha:1.0] forState:UIControlStateHighlighted];
            [button6 setTitleColor:[UIColor colorWithRed:142.0/255.0 green:215.0/255.0 blue:249.0/255.0 alpha:1.0] forState:UIControlStateSelected];
            [button6 setTitle:@"Официант" forState:UIControlStateNormal];
            [button6 setTitle:@"Официант" forState:UIControlStateHighlighted];
            [button6 setTitle:@"Официант" forState:UIControlStateSelected];
            [button6 addTarget:self action:@selector(clikedButton:) forControlEvents:UIControlEventTouchUpInside];
        } else {
            button6 = [UIButton buttonWithType:UIButtonTypeCustom];
            [button6 setImage:[UIImage imageNamed:@"graph.png"] forState:UIControlStateNormal];
            [button6 setImage:[UIImage imageNamed:@"graph.png"] forState:UIControlStateHighlighted];
            button6.titleLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:12.f];
            [button6 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            [button6 setTitleColor:[UIColor colorWithRed:142.0/255.0 green:215.0/255.0 blue:249.0/255.0 alpha:1.0] forState:UIControlStateHighlighted];
            [button6 setTitleColor:[UIColor colorWithRed:142.0/255.0 green:215.0/255.0 blue:249.0/255.0 alpha:1.0] forState:UIControlStateSelected];
            [button6 setTitle:@"Статистика" forState:UIControlStateNormal];
            [button6 setTitle:@"Статистика" forState:UIControlStateHighlighted];
            [button6 setTitle:@"Статистика" forState:UIControlStateSelected];
            [button6 addTarget:self action:@selector(clikedButton:) forControlEvents:UIControlEventTouchUpInside];
            [button6 setImageEdgeInsets:UIEdgeInsetsMake(-8.f, 60.f, 8.f, 0)];
            [button6 setTitleEdgeInsets:UIEdgeInsetsMake(35.f, -20.f, 0.f, 0)];
        }
        button6.tag = 5;
  
        
        UIButton* button7 = [UIButton buttonWithType:UIButtonTypeCustom];
        [button7 setImage:[UIImage imageNamed:@"notice.png"] forState:UIControlStateNormal];
        [button7 setImage:[UIImage imageNamed:@"notice.png"] forState:UIControlStateHighlighted];
        button7.titleLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:12.f];
        [button7 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [button7 setTitleColor:[UIColor colorWithRed:142.0/255.0 green:215.0/255.0 blue:249.0/255.0 alpha:1.0] forState:UIControlStateHighlighted];
        [button7 setTitleColor:[UIColor colorWithRed:142.0/255.0 green:215.0/255.0 blue:249.0/255.0 alpha:1.0] forState:UIControlStateSelected];
        [button7 setTitle:@"Уведомления" forState:UIControlStateNormal];
        [button7 setTitle:@"Уведомления" forState:UIControlStateHighlighted];
        [button7 setTitle:@"Уведомления" forState:UIControlStateSelected];
        [button7 addTarget:self action:@selector(clikedButton:) forControlEvents:UIControlEventTouchUpInside];
        [button7 setImageEdgeInsets:UIEdgeInsetsMake(-8.f, 59.f, 8.f, 0)];
        [button7 setTitleEdgeInsets:UIEdgeInsetsMake(35.f, -18.f, 0.f, 0)];
        button7.tag = 6;
       
        if(app.userType == UserTypeAdmin){
            
            [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"tab_bar_ipad_boss.png"]]];
  
            
            [button2 setImageEdgeInsets:UIEdgeInsetsMake(-8.f, 47.f, 8.f, 0)];
            [button2 setTitleEdgeInsets:UIEdgeInsetsMake(35.f, -24.f, 0.f, 0)];
            
            [button3 setImageEdgeInsets:UIEdgeInsetsMake(-8.f, 41.f, 8.f, 0)];
            [button3 setTitleEdgeInsets:UIEdgeInsetsMake(35.f, -22.f, 0.f, 0)];
            
            [button4 setImageEdgeInsets:UIEdgeInsetsMake(-8.f, 65.f, 8.f, 0)];
            [button4 setTitleEdgeInsets:UIEdgeInsetsMake(35.f, -20.f, 0.f, 0)];

            [button6 setImageEdgeInsets:UIEdgeInsetsMake(-8.f, 71.f, 8.f, 0)];
            [button6 setTitleEdgeInsets:UIEdgeInsetsMake(35.f, -4.f, 0.f, 0)];
            
            [button7 setImageEdgeInsets:UIEdgeInsetsMake(-8.f, 77.f, 8.f, 0)];
            [button7 setTitleEdgeInsets:UIEdgeInsetsMake(35.f, -12.f, 0.f, 0)];

            [temp addObject:button1];
            [self addSubview:button1];
            [temp addObject:button2];
            [self addSubview:button2];
            [temp addObject:button3];
            [self addSubview:button3];
            [temp addObject:button4];
            [self addSubview:button4];
            [temp addObject:button6];
            [self addSubview:button6];
            [temp addObject:button7];
            [self addSubview:button7];

        } else {
            [temp addObject:button1];
            [self addSubview:button1];
            [temp addObject:button2];
            [self addSubview:button2];
            [temp addObject:button3];
            [self addSubview:button3];
            [temp addObject:button4];
            [self addSubview:button4];
            [temp addObject:button5];
            [self addSubview:button5];
            [temp addObject:button6];
            [self addSubview:button6];
            [temp addObject:button7];
            [self addSubview:button7];
        }
        
        self.buttons = [NSArray arrayWithArray:temp];
        
        CGFloat posX = 0;
        CGFloat width = 145.f;
        if(app.userType == UserTypeAdmin){
            width = 168.f;
        }
        
        for (UIButton* obj in _buttons) {
            [obj setFrame:CGRectMake(posX, 0, width, 56.f)];
            [obj setBackgroundColor:[UIColor clearColor]];
            [obj setTitleColor:[UIColor clearColor] forState:UIControlStateHighlighted];
   
            posX += (obj.frame.size.width + 1.f);
        
        }
        UIButton* button = (UIButton*)[_buttons firstObject];
        [button setSelected:YES];

    }
    return self;
}

- (void)clikedButton: (id)sender{
    
    TheApp;
    
    if (!app.isBusy){
        UIButton* button = (UIButton*)sender;
    
        for (UIButton* obj in _buttons) {
            [obj setSelected:NO];
        }
        [button setSelected:YES];
    

        for(int i = 0; i < _buttons.count; i++){
        
            if(button == (UIButton*)[_buttons objectAtIndex:i]){
                if(app.userType == UserTypeAdmin){
                    if(i == _buttons.count - 2) {
                    NSString *customURL = @"RestrauntSystem://";
                     
                     if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:customURL]])
                             [[UIApplication sharedApplication] openURL:[NSURL URLWithString:customURL]];
                  
                    self.selectIndex = i;
                    return;
                }
                if(i == _buttons.count - 1)
                    i--;
            }
            self.selectIndex = i;
            app.navController = nil;
            app.navController = [[UINavigationController alloc]initWithRootViewController:(UIViewController*)[app.baseController.viewControllers objectAtIndex:i]];
            app.window.rootViewController = app.navController;
            return;
            }
        }
    }
}
- (void)showNoticesCount:(NSUInteger)noticesCnt
{

    [self.customBadge removeFromSuperview];
    self.customBadge = nil;
    self.customBadge = [CustomBadge customBadgeWithString:[NSString stringWithFormat:@"%d",noticesCnt]
                                          withStringColor:[UIColor whiteColor]
                                           withInsetColor:[UIColor redColor]
                                           withBadgeFrame:YES
                                      withBadgeFrameColor:[UIColor whiteColor]
                                                withScale:1.0
                                              withShining:YES];
    _customBadge.tag = 111;
    CGRect frame = self.frame;
    [_customBadge setFrame:CGRectMake(frame.size.width -_customBadge.frame.size.width - 15.f, 0, _customBadge.frame.size.width, _customBadge.frame.size.height)];
    [self addSubview:_customBadge];
    
}

@end
