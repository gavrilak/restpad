//
//  BASInfoView.m
//  RestrauntSystemPad
//
//  Created by Sergey on 25.07.14.
//  Copyright (c) 2014 BestAppStudio. All rights reserved.
//

#import "BASInfoView.h"

@interface BASInfoView()

@property(nonatomic,strong)UILabel* waiterView;
@property(nonatomic,strong)UILabel* tableView;
@end


@implementation BASInfoView

- (id)initWithFrame:(CGRect)frame withContent:(NSDictionary*)contentData
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"circuit.png"]]];
        
        UIImage* image = [UIImage imageNamed:@"choice_waiter.png"];
        
        UILabel *lb1 = [UILabel new];
        lb1.font = [UIFont fontWithName:@"Helvetica-Bold" size:14.f];
        lb1.textColor = [UIColor colorWithRed:142.0/255.0 green:215.0/255.0 blue:249.0/255.0 alpha:1.0];
        lb1.backgroundColor = [UIColor clearColor];
        [lb1 setTextAlignment:NSTextAlignmentCenter];
        [lb1 setText:@"Официант"];
        [lb1 setFrame:CGRectMake(self.frame.size.width / 2 - image.size.width / 2, 15.f, image.size.width, image.size.height)];
        [self addSubview:lb1];
        
        
        self.waiterView = [UILabel new];
        self.waiterView.font = [UIFont fontWithName:@"Helvetica-Bold" size:14.f];
        self.waiterView.textColor = [UIColor blackColor];
        self.waiterView.backgroundColor = [UIColor colorWithPatternImage:image];
        self.waiterView.shadowColor = [UIColor whiteColor];
        self.waiterView.shadowOffset = CGSizeMake(0, 1.0);
        [self.waiterView setTextAlignment:NSTextAlignmentCenter];
        [self.waiterView setText:(NSString*)[contentData objectForKey:@"name"]];
        [self.waiterView setFrame:CGRectMake(self.frame.size.width / 2 - image.size.width / 2, 45.f, image.size.width, image.size.height)];
        [self addSubview:_waiterView];
        
        
        UILabel *lb2 = [UILabel new];
        lb2.font = [UIFont fontWithName:@"Helvetica-Bold" size:14.f];
        lb2.textColor = [UIColor colorWithRed:142.0/255.0 green:215.0/255.0 blue:249.0/255.0 alpha:1.0];
        lb2.backgroundColor = [UIColor clearColor];
        [lb2 setTextAlignment:NSTextAlignmentCenter];
        [lb2 setText:@"Стол"];
        [lb2 setFrame:CGRectMake(self.frame.size.width / 2 - image.size.width / 2, 85.f, image.size.width, image.size.height)];
        [self addSubview:lb2];
        
        self.tableView = [UILabel new];
        self.tableView.font = [UIFont fontWithName:@"Helvetica-Bold" size:14.f];
        self.tableView.textColor = [UIColor blackColor];
        self.tableView.backgroundColor = [UIColor colorWithPatternImage:image];
        self.tableView.shadowColor = [UIColor whiteColor];
        self.tableView.shadowOffset = CGSizeMake(0, 1.0);
        [self.tableView setTextAlignment:NSTextAlignmentCenter];
        [self.tableView setText:(NSString*)[contentData objectForKey:@"table"]];
        [self.tableView setFrame:CGRectMake(self.frame.size.width / 2 - image.size.width / 2, 115.f, image.size.width, image.size.height)];
        [self addSubview:_tableView];

    }
    return self;
}


@end
