//
//  BASInfographView.m
//  RestrauntSystemPad
//
//  Created by Sergey on 01.12.14.
//  Copyright (c) 2014 BestAppStudio. All rights reserved.
//

#import "BASInfographView.h"

@interface BASInfographView ()

@property (nonatomic,strong) UIView* breakfastView;
@property (nonatomic,strong) UIView* lunchView;
@property (nonatomic,strong) UIView* dinnerView;
@property (nonatomic,strong) UILabel* dateLabel;
@property (nonatomic,strong) UIImageView* dateView;
@property (nonatomic,strong) NSDictionary* contentData;

@end

@implementation BASInfographView

- (id)initWithFrame:(CGRect)frame withContent:(NSDictionary*)content{
    self = [super initWithFrame:frame];
    if(self){
        CGFloat sz = self.bounds.size.width - 15.f;
        
        UIImage* image = [UIImage imageNamed:@"data_infograph"];
        [self setBackgroundColor:[UIColor clearColor]];
        self.contentData = [NSDictionary dictionaryWithDictionary:content];
        
        self.dateView = [[UIImageView alloc]initWithImage:image];
        [_dateView setFrame:CGRectMake(0, self.bounds.size.height - image.size.height, image.size.width, image.size.height)];
        [self addSubview:_dateView];
        
        self.dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _dateView.frame.origin.y + _dateView.frame.size.height / 2 - 10.f,_dateView.frame.size.width, 20.f)];
        [_dateLabel setBackgroundColor:[UIColor clearColor]];
        [_dateLabel setText:(NSString*)[_contentData objectForKey:@"date"]];
        [_dateLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:13.f]];
        [_dateLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:_dateLabel];
        
        CGFloat orignY = 0;
        NSNumber* max_count = (NSNumber*)[_contentData objectForKey:@"max_count"];
        NSNumber* value = (NSNumber*)[_contentData objectForKey:@"breakfast"];
        self.breakfastView = [[UIView alloc]init];
        [_breakfastView setBackgroundColor:[UIColor colorWithRed:252.f/255.f green:241.f/255.f blue:58.f/255.f alpha:1.f]];
        orignY = [self sizeWithData:max_count withValue:value];
        [_breakfastView setFrame:CGRectMake(4.5f, orignY, sz / 3, _dateView.frame.origin.y - orignY)];
        [self addSubview:_breakfastView];
        UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(_breakfastView.frame.origin.x, _breakfastView.frame.origin.y ,_breakfastView.frame.size.width, 20.f)];
        [label setBackgroundColor:[UIColor clearColor]];
        if([value integerValue] > 0)
            [label setText:[NSString stringWithFormat:@"%ld",[value integerValue]]];
        [label setFont:[UIFont fontWithName:@"Helvetica-Bold" size:11.f]];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setTextColor:[UIColor grayColor]];
        [self addSubview:label];
        
        
        value = (NSNumber*)[_contentData objectForKey:@"lunch"];
        self.lunchView = [[UIView alloc]init];
        [_lunchView setBackgroundColor:[UIColor colorWithRed:147.f/255.f green:238.f/255.f blue:91.f/255.f alpha:1.f]];
        orignY = [self sizeWithData:max_count withValue:value];
        [_lunchView setFrame:CGRectMake(_breakfastView.frame.origin.x + _breakfastView.frame.size.width + 2.f, orignY, sz / 3, _dateView.frame.origin.y - orignY)];
        [self addSubview:_lunchView];
        label = [[UILabel alloc]initWithFrame:CGRectMake(_lunchView.frame.origin.x, _lunchView.frame.origin.y ,_lunchView.frame.size.width, 20.f)];
        [label setBackgroundColor:[UIColor clearColor]];
        if([value integerValue] > 0)
            [label setText:[NSString stringWithFormat:@"%ld",[value integerValue]]];
        [label setFont:[UIFont fontWithName:@"Helvetica-Bold" size:11.f]];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setTextColor:[UIColor grayColor]];
        [self addSubview:label];
        
        value = (NSNumber*)[_contentData objectForKey:@"dinner"];
        self.dinnerView = [[UIView alloc]init];
        [_dinnerView setBackgroundColor:[UIColor colorWithRed:58.f/255.f green:102.f/255.f blue:228.f/255.f alpha:1.f]];
        orignY = [self sizeWithData:max_count withValue:value];
        [_dinnerView setFrame:CGRectMake(_lunchView.frame.origin.x + _lunchView.frame.size.width + 2.f, orignY, sz / 3, _dateView.frame.origin.y - orignY)];
        [self addSubview:_dinnerView];
        label = [[UILabel alloc]initWithFrame:CGRectMake(_dinnerView.frame.origin.x, _dinnerView.frame.origin.y ,_dinnerView.frame.size.width, 20.f)];
        [label setBackgroundColor:[UIColor clearColor]];
        if([value integerValue] > 0)
            [label setText:[NSString stringWithFormat:@"%ld",[value integerValue]]];
        [label setFont:[UIFont fontWithName:@"Helvetica-Bold" size:11.f]];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setTextColor:[UIColor grayColor]];
        [self addSubview:label];
        
        
        
    }
    return  self;
}
- (CGFloat)sizeWithData:(NSNumber*)max_count withValue:(NSNumber*)value{
    CGFloat orignY = 30.f;
    CGFloat hight = _dateView.frame.origin.y;
    
    orignY = ([value intValue] * hight) / [max_count intValue];
    
    return  hight - (CGFloat)orignY;
}
@end
