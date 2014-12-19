//
//  BASVirtualTableView.m
//  RestrauntSystemPad
//
//  Created by Sergey on 24.07.14.
//  Copyright (c) 2014 BestAppStudio. All rights reserved.
//

#import "BASVirtualTableView.h"
#import "CustomBadge.h"
#import "BASOrderViewController.h"

@interface BASVirtualTableView()

@property(nonatomic, strong) UILabel* nameCategory;
@property(nonatomic, strong) UIButton* button;
@property (nonatomic, strong) CustomBadge *customBadge;
@property (nonatomic,strong) NSArray *contentData;
@property(nonatomic, strong) UIPopoverController *popover;

@end
@implementation BASVirtualTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        UIImage* image = [[UIImage imageNamed:@"frame_virtual_table.png"]stretchableImageWithLeftCapWidth:20.f topCapHeight:20.f];
        [self setBackgroundColor:[UIColor colorWithPatternImage:image]];
 
  
        self.nameCategory = [UILabel new];
        self.nameCategory.font = [UIFont fontWithName:@"Helvetica-Bold" size:14.f];
        self.nameCategory.textColor = [UIColor colorWithRed:142.0/255.0 green:215.0/255.0 blue:249.0/255.0 alpha:1.0];
        self.nameCategory.backgroundColor = [UIColor clearColor];
        self.nameCategory .numberOfLines = 2;
        self.nameCategory.lineBreakMode = NSLineBreakByWordWrapping;
        [self.nameCategory setTextAlignment:NSTextAlignmentCenter];
        [self.nameCategory setText:@"Виртуальный стол"];
        [self.nameCategory setFrame:CGRectMake(0, 10.f, self.frame.size.width, 45.f)];
        [self addSubview:_nameCategory];
        
        self.button = [UIButton buttonWithType:UIButtonTypeCustom];
        image = [UIImage imageNamed:@"virt_table_btn.png"];
        _button.frame = CGRectMake(self.frame.size.width / 2 - image.size.width / 2, (self.frame.size.height - _nameCategory.frame.size.height) / 2 + 10.f, image.size.width, image.size.height);
        [_button setImage:image forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(btnPressed) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_button];
        
        [self getData];
        
    }
    return self;
}
- (void)getData{
    BASManager* manager = [BASManager sharedInstance];
    
    
    [manager getData:[manager formatRequest:@"GETVIRTUALTABLE" withParam:nil] success:^(id responseObject) {
        
        NSLog(@"Response: %@",responseObject);
        NSArray* param = (NSArray*)[responseObject objectForKey:@"param"];
        
        if(param != nil && param.count > 0){
  
            NSDictionary* dict = (NSDictionary*)[param objectAtIndex:0];
            NSNumber* count = (NSNumber*)[dict objectForKey:@"count"];
            if([count integerValue] > 0){
                self.contentData = (NSArray*)[dict objectForKey:@"virtualTableElements"];
                self.customBadge = [CustomBadge customBadgeWithString:[NSString stringWithFormat:@"%d",_contentData.count]
                                                      withStringColor:[UIColor whiteColor]
                                                       withInsetColor:[UIColor redColor]
                                                       withBadgeFrame:YES
                                                  withBadgeFrameColor:[UIColor whiteColor]
                                                            withScale:1.0
                                                          withShining:YES];
   
                [_customBadge setFrame:CGRectMake(_button.frame.origin.x + _button.frame.size.width - 15.f, _button.frame.origin.y + 6.f, _customBadge.frame.size.width, _customBadge.frame.size.height)];
                [self addSubview:_customBadge];
            } else {
                [_customBadge removeFromSuperview];
                if(self.popover.popoverVisible){
                    [self.popover dismissPopoverAnimated:YES];
                    self.popover = nil;
                }
            }
        }
    } failure:^(NSString *error) {
        [manager showAlertViewWithMess:ERROR_MESSAGE];
    }];

}
- (void)btnPressed{
    BASManager* manager = [BASManager sharedInstance];
    
    
    [manager getData:[manager formatRequest:@"GETVIRTUALTABLE" withParam:nil] success:^(id responseObject) {
        
        NSLog(@"Response: %@",responseObject);
        NSArray* param = (NSArray*)[responseObject objectForKey:@"param"];
        
        if(param != nil && param.count > 0){
            
            NSDictionary* dict = (NSDictionary*)[param objectAtIndex:0];
            NSNumber* count = (NSNumber*)[dict objectForKey:@"count"];
            if([count integerValue] > 0){
                self.contentData = (NSArray*)[dict objectForKey:@"virtualTableElements"];
                [_customBadge removeFromSuperview];
                self.customBadge = nil;
                self.customBadge = [CustomBadge customBadgeWithString:[NSString stringWithFormat:@"%d",_contentData.count]
                                                      withStringColor:[UIColor whiteColor]
                                                       withInsetColor:[UIColor redColor]
                                                       withBadgeFrame:YES
                                                  withBadgeFrameColor:[UIColor whiteColor]
                                                            withScale:1.0
                                                          withShining:YES];
           
                [_customBadge setFrame:CGRectMake(_button.frame.origin.x + _button.frame.size.width - 15.f, _button.frame.origin.y + 6.f, _customBadge.frame.size.width, _customBadge.frame.size.height)];
                [self addSubview:_customBadge];
                
        
                dict = @{@"order_items":_contentData};
                dict = @{@"order":dict};
                TheApp;
                app.isOrder = NO;
                BASOrderViewController* controller = [BASOrderViewController new];
                controller.isMove = YES;
                controller.contentData = dict;
                
                if(!self.popover.popoverVisible){
                    self.popover = nil;
                    self.popover  = [[UIPopoverController alloc] initWithContentViewController:controller];
                    [_popover setPopoverContentSize:CGSizeMake(320, 568)];
                    [_popover presentPopoverFromRect:_button.bounds inView:self permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
                }
            }
        }
        
        
    } failure:^(NSString *error) {
        [manager showAlertViewWithMess:ERROR_MESSAGE];
    }];

    
}
- (void)UpdateBadge{
    [self getData];
}
@end
