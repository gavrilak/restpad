//
//  BASStatisticsCell.m
//  RestrauntSystemPad
//
//  Created by Sergey on 03.11.14.
//  Copyright (c) 2014 BestAppStudio. All rights reserved.
//

#import "BASStatisticsCell.h"

@interface BASStatisticsCell()

@property(nonatomic,strong)  UIImageView    *bgView;
@property (nonatomic,strong) NSDictionary* contentData;
@property (nonatomic,assign) StatisticsType type;
@property (nonatomic,strong) NSArray* Labels;
@end

@implementation BASStatisticsCell

- (void)setIndex:(NSInteger)index{
    _index = index;
    if(_type != revenue && _type != salary)
        [((UILabel*)[self.Labels objectAtIndex:0]) setText:[NSString stringWithFormat:@"%d",(int)_index + 1]];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withContent:(NSDictionary*)contentData withType:(StatisticsType)statType{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentData = [NSDictionary dictionaryWithDictionary:contentData];
        self.type = statType;
        [self setBackgroundColor:[UIColor clearColor]];
   
        [self setupBgView];
        [self createLabels];
        
        
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}
- (void)createLabels{
    NSMutableArray* temp = [NSMutableArray new];
    NSInteger count = 0;
    if(_type == sales_rankings){
        count = 4;
    } else if(_type == consumption_of_food){
         count = 5;
    } else if(_type == revenue){
         count = 10;
    } else if(_type == list_of_staff || _type == salary){
         count = 10;
    }
    
    for (int i = 0; i < count; i++) {
        UILabel * lb = [[UILabel alloc]init];
        //[lb setBackgroundColor:[UIColor redColor]];
        [lb setBackgroundColor:[UIColor clearColor]];
        lb.font = [UIFont fontWithName:@"Helvetica-Light" size:12.f];
        lb.textColor = [UIColor blackColor];
        lb.textAlignment = NSTextAlignmentCenter;
        [temp addObject:lb];
        [self addSubview:lb];
        
        
    }
    CGRect frame = self.contentView.frame;
    if(_type == sales_rankings){
        [((UILabel*)[temp objectAtIndex:0]) setFrame:CGRectMake(0, 0, 80.f, frame.size.height)];

        [((UILabel*)[temp objectAtIndex:1]) setFrame:CGRectMake(83.f, 0, 146.f, frame.size.height)];
        [((UILabel*)[temp objectAtIndex:1]) setText:(NSString*)[_contentData objectForKey:@"name_dish"]];
        
        [((UILabel*)[temp objectAtIndex:2]) setFrame:CGRectMake(233.f, 0, 137.f, frame.size.height)];
        NSNumber*  count_dish = (NSNumber*)[_contentData objectForKey:@"count_dish"];
        [((UILabel*)[temp objectAtIndex:2]) setText:[NSString stringWithFormat:@"%d",[count_dish intValue]]];

        [((UILabel*)[temp objectAtIndex:3]) setFrame:CGRectMake(374.f, 0, 141.f, frame.size.height)];
         NSNumber*  cost = (NSNumber*)[_contentData objectForKey:@"cost"];
        [((UILabel*)[temp objectAtIndex:3]) setText:[NSString stringWithFormat:@"%d",[cost intValue]]];
    }else if(_type == consumption_of_food){
        [((UILabel*)[temp objectAtIndex:0]) setFrame:CGRectMake(0, 0, 79.f, frame.size.height)];
 
        [((UILabel*)[temp objectAtIndex:1]) setFrame:CGRectMake(83.f, 0, 146.f, frame.size.height)];
        [((UILabel*)[temp objectAtIndex:1])setText:(NSString*)[_contentData objectForKey:@"name_category"]];
        
        [((UILabel*)[temp objectAtIndex:2]) setFrame:CGRectMake(233.f, 0, 137.f, frame.size.height)];
        [((UILabel*)[temp objectAtIndex:2]) setText:(NSString*)[_contentData objectForKey:@"name_dish"]];

        [((UILabel*)[temp objectAtIndex:3]) setFrame:CGRectMake(374.f, 0, 140.f, frame.size.height)];
        NSNumber*  count_dish = (NSNumber*)[_contentData objectForKey:@"count_dish"];
        [((UILabel*)[temp objectAtIndex:3]) setText:[NSString stringWithFormat:@"%d",[count_dish intValue]]];
        
        [((UILabel*)[temp objectAtIndex:4]) setFrame:CGRectMake(519.f, 0, 136.f, frame.size.height)];
        NSNumber*  cost = (NSNumber*)[_contentData objectForKey:@"cost"];
        [((UILabel*)[temp objectAtIndex:4]) setText:[NSString stringWithFormat:@"%d",[cost intValue]]];
    } else if(_type == revenue){
        [((UILabel*)[temp objectAtIndex:0]) setFrame:CGRectMake(0, 0, 70.f, frame.size.height)];
        NSString* date = (NSString*)[_contentData objectForKey:@"date"];
        NSArray* ar = [date componentsSeparatedByString:@"."];
        date = [NSString stringWithFormat:@"%@.%@.%@",[ar objectAtIndex:0],[ar objectAtIndex:1],[[ar objectAtIndex:2]substringFromIndex:2]];
        [((UILabel*)[temp objectAtIndex:0])setText:date];
        
        [((UILabel*)[temp objectAtIndex:1]) setFrame:CGRectMake(73.f, 0, 59.f, frame.size.height)];
        NSNumber*  total = (NSNumber*)[_contentData objectForKey:@"total"];
        [((UILabel*)[temp objectAtIndex:1]) setText:[NSString stringWithFormat:@"%d",[total intValue]]];
        
        [((UILabel*)[temp objectAtIndex:2]) setFrame:CGRectMake(134.f, 0, 59.f, frame.size.height)];
        NSNumber*  cash = (NSNumber*)[_contentData objectForKey:@"cash"];
        [((UILabel*)[temp objectAtIndex:2]) setText:[NSString stringWithFormat:@"%d",[cash intValue]]];
        
        [((UILabel*)[temp objectAtIndex:3]) setFrame:CGRectMake(195.f, 0, 58.f, frame.size.height)];
        NSNumber*  cashless = (NSNumber*)[_contentData objectForKey:@"cashless"];
        [((UILabel*)[temp objectAtIndex:3]) setText:[NSString stringWithFormat:@"%d",[cashless intValue]]];
        
        [((UILabel*)[temp objectAtIndex:4]) setFrame:CGRectMake(256.f, 0, 58.f, frame.size.height)];
        NSNumber*  kitchen = (NSNumber*)[_contentData objectForKey:@"kitchen"];
        [((UILabel*)[temp objectAtIndex:4]) setText:[NSString stringWithFormat:@"%d",[kitchen intValue]]];
        
        [((UILabel*)[temp objectAtIndex:5]) setFrame:CGRectMake(317.f, 0, 58.f, frame.size.height)];
        NSNumber*  bar = (NSNumber*)[_contentData objectForKey:@"bar"];
        [((UILabel*)[temp objectAtIndex:5]) setText:[NSString stringWithFormat:@"%d",[bar intValue]]];
        
        [((UILabel*)[temp objectAtIndex:6]) setFrame:CGRectMake(378.f, 0, 58.f, frame.size.height)];
        NSNumber*  hookah = (NSNumber*)[_contentData objectForKey:@"hookah"];
        [((UILabel*)[temp objectAtIndex:6]) setText:[NSString stringWithFormat:@"%d",[hookah intValue]]];
        
        [((UILabel*)[temp objectAtIndex:7]) setFrame:CGRectMake(439.f, 0, 58.f, frame.size.height)];
        NSNumber*  tax = (NSNumber*)[_contentData objectForKey:@"tax"];
        [((UILabel*)[temp objectAtIndex:7]) setText:[NSString stringWithFormat:@"%d",[tax intValue]]];
        
        [((UILabel*)[temp objectAtIndex:8]) setFrame:CGRectMake(500.f, 0, 58.f, frame.size.height)];
        NSNumber*  discount = (NSNumber*)[_contentData objectForKey:@"discount"];
        [((UILabel*)[temp objectAtIndex:8]) setText:[NSString stringWithFormat:@"%d",[discount intValue]]];
        
        [((UILabel*)[temp objectAtIndex:9]) setFrame:CGRectMake(561.f, 0, 120.f, frame.size.height)];
        NSNumber*  profit = (NSNumber*)[_contentData objectForKey:@"profit"];
        [((UILabel*)[temp objectAtIndex:9]) setText:[NSString stringWithFormat:@"%d",[profit intValue]]];

    } else if(_type == list_of_staff){
        [((UILabel*)[temp objectAtIndex:0]) setFrame:CGRectMake(0, 0, 33.f, frame.size.height)];
        
        [((UILabel*)[temp objectAtIndex:1]) setFrame:CGRectMake(36.f, 0, 83.f, frame.size.height)];
        [((UILabel*)[temp objectAtIndex:1]) setText:(NSString*)[_contentData objectForKey:@"name_job"]];
        ((UILabel*)[temp objectAtIndex:1]).numberOfLines = 2;
        ((UILabel*)[temp objectAtIndex:1]).lineBreakMode = NSLineBreakByCharWrapping;
       
        [((UILabel*)[temp objectAtIndex:2]) setFrame:CGRectMake(123.f, 0, 115.f, frame.size.height)];
        [((UILabel*)[temp objectAtIndex:2]) setText:(NSString*)[_contentData objectForKey:@"name"]];
        ((UILabel*)[temp objectAtIndex:2]).numberOfLines = 2;
        ((UILabel*)[temp objectAtIndex:2]).lineBreakMode = NSLineBreakByCharWrapping;
        
        [((UILabel*)[temp objectAtIndex:3]) setFrame:CGRectMake(242.f, 0, 53.f, frame.size.height)];
        NSNumber*  salary = (NSNumber*)[_contentData objectForKey:@"salary"];
        [((UILabel*)[temp objectAtIndex:3]) setText:[NSString stringWithFormat:@"%d",[salary intValue]]];

        
        [((UILabel*)[temp objectAtIndex:4]) setFrame:CGRectMake(298.f, 0, 57.f, frame.size.height)];
        NSNumber*  advance = (NSNumber*)[_contentData objectForKey:@"advance"];
        [((UILabel*)[temp objectAtIndex:4]) setText:[NSString stringWithFormat:@"%d",[advance intValue]]];
        
        [((UILabel*)[temp objectAtIndex:5]) setFrame:CGRectMake(358.f, 0, 58.f, frame.size.height)];
        NSNumber*  penalty = (NSNumber*)[_contentData objectForKey:@"penalty"];
        [((UILabel*)[temp objectAtIndex:5]) setText:[NSString stringWithFormat:@"%d",[penalty intValue]]];
        
        [((UILabel*)[temp objectAtIndex:6]) setFrame:CGRectMake(419.f, 0, 49.f, frame.size.height)];
        NSNumber*  rate = (NSNumber*)[_contentData objectForKey:@"rate"];
        [((UILabel*)[temp objectAtIndex:6]) setText:[NSString stringWithFormat:@"%d",[rate intValue]]];
        
        [((UILabel*)[temp objectAtIndex:7]) setFrame:CGRectMake(470.f, 0, 51.f, frame.size.height)];
        NSNumber*  premium = (NSNumber*)[_contentData objectForKey:@"premium"];
        [((UILabel*)[temp objectAtIndex:7]) setText:[NSString stringWithFormat:@"%d",[premium intValue]]];
        
        [((UILabel*)[temp objectAtIndex:8]) setFrame:CGRectMake(523.f, 0, 75.f, frame.size.height)];
        NSNumber*  payment_for_living = (NSNumber*)[_contentData objectForKey:@"payment_for_living"];
        [((UILabel*)[temp objectAtIndex:8]) setText:[NSString stringWithFormat:@"%d",[payment_for_living intValue]]];
        
        [((UILabel*)[temp objectAtIndex:9]) setFrame:CGRectMake(600.f, 0, 57.f, frame.size.height)];
        NSNumber*  balance = (NSNumber*)[_contentData objectForKey:@"balance"];
        [((UILabel*)[temp objectAtIndex:9]) setText:[NSString stringWithFormat:@"%d",[balance intValue]]];
    }else if(_type == salary){
        
        [((UILabel*)[temp objectAtIndex:0]) setFrame:CGRectMake(0, 0, 58.f, frame.size.height)];
        NSString* date = (NSString*)[_contentData objectForKey:@"date"];
        NSArray* ar = [date componentsSeparatedByString:@"."];
        date = [NSString stringWithFormat:@"%@.%@.%@",[ar objectAtIndex:0],[ar objectAtIndex:1],[[ar objectAtIndex:2]substringFromIndex:2]];
        [((UILabel*)[temp objectAtIndex:0])setText:date];
        
        [((UILabel*)[temp objectAtIndex:1]) setFrame:CGRectMake(58.f, 0, 77.f, frame.size.height)];
        [((UILabel*)[temp objectAtIndex:1]) setText:(NSString*)[_contentData objectForKey:@"name_job"]];
        ((UILabel*)[temp objectAtIndex:1]).numberOfLines = 2;
        ((UILabel*)[temp objectAtIndex:1]).lineBreakMode = NSLineBreakByCharWrapping;
        
        [((UILabel*)[temp objectAtIndex:2]) setFrame:CGRectMake(135.f, 0, 93.f, frame.size.height)];
        [((UILabel*)[temp objectAtIndex:2]) setText:(NSString*)[_contentData objectForKey:@"name"]];
        ((UILabel*)[temp objectAtIndex:2]).numberOfLines = 2;
        ((UILabel*)[temp objectAtIndex:2]).lineBreakMode = NSLineBreakByCharWrapping;
        
        [((UILabel*)[temp objectAtIndex:3]) setFrame:CGRectMake(228.f, 0, 62.f, frame.size.height)];
        NSNumber*  salary = (NSNumber*)[_contentData objectForKey:@"salary"];
        [((UILabel*)[temp objectAtIndex:3]) setText:[NSString stringWithFormat:@"%d",[salary intValue]]];
        
        
        [((UILabel*)[temp objectAtIndex:4]) setFrame:CGRectMake(290.f, 0, 65.f, frame.size.height)];
        NSNumber*  advance = (NSNumber*)[_contentData objectForKey:@"advance"];
        [((UILabel*)[temp objectAtIndex:4]) setText:[NSString stringWithFormat:@"%d",[advance intValue]]];
        
        [((UILabel*)[temp objectAtIndex:5]) setFrame:CGRectMake(355.f, 0, 69.f, frame.size.height)];
        NSNumber*  penalty = (NSNumber*)[_contentData objectForKey:@"penalty"];
        [((UILabel*)[temp objectAtIndex:5]) setText:[NSString stringWithFormat:@"%d",[penalty intValue]]];
        
        [((UILabel*)[temp objectAtIndex:6]) setFrame:CGRectMake(424.f, 0, 66.f, frame.size.height)];
        NSNumber*  rate = (NSNumber*)[_contentData objectForKey:@"rate"];
        [((UILabel*)[temp objectAtIndex:6]) setText:[NSString stringWithFormat:@"%d",[rate intValue]]];
        
        [((UILabel*)[temp objectAtIndex:7]) setFrame:CGRectMake(490.f, 0, 60.f, frame.size.height)];
        NSNumber*  premium = (NSNumber*)[_contentData objectForKey:@"premium"];
        [((UILabel*)[temp objectAtIndex:7]) setText:[NSString stringWithFormat:@"%d",[premium intValue]]];
        
        [((UILabel*)[temp objectAtIndex:8]) setFrame:CGRectMake(550.f, 0, 65.f, frame.size.height)];
        NSNumber*  payment_for_living = (NSNumber*)[_contentData objectForKey:@"payment_for_living"];
        [((UILabel*)[temp objectAtIndex:8]) setText:[NSString stringWithFormat:@"%d",[payment_for_living intValue]]];
        
        [((UILabel*)[temp objectAtIndex:9]) setFrame:CGRectMake(615.f, 0, 67.f, frame.size.height)];
        NSNumber*  balance = (NSNumber*)[_contentData objectForKey:@"balance"];
        [((UILabel*)[temp objectAtIndex:9]) setText:[NSString stringWithFormat:@"%d",[balance intValue]]];
    }
    self.Labels = [NSArray arrayWithArray:temp];
}
- (void)setupBgView{
    
    self.bgView = [[UIImageView alloc] initWithImage:[self imageWithType]];
    [self.contentView addSubview:_bgView];
}
- (UIImage*)imageWithType{
    
 
    UIImage* image= nil;
    if(_type == sales_rankings){
        image = [UIImage imageNamed:@"BgS1"];
    } else if(_type == consumption_of_food){
        image = [UIImage imageNamed:@"BgS2"];
    } else if(_type == revenue){
        image = [UIImage imageNamed:@"BgS3"];
    } else if(_type == list_of_staff){
        image = [UIImage imageNamed:@"BgS4"];
    }else if(_type == salary){
        image = [UIImage imageNamed:@"BgS5"];
    }
    return  image;
    
}
@end
