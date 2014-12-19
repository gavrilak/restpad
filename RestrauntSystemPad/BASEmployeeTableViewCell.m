//
//  BASEmployeeTableViewCell.m
//  RestrauntSystemPad
//
//  Created by Sergey Bekker on 20.07.14.
//  Copyright (c) 2014 BestAppStudio. All rights reserved.
//

#import "BASEmployeeTableViewCell.h"

@interface BASEmployeeTableViewCell()

@property(nonatomic,strong)  NSDictionary* contentData;
@property(nonatomic, strong) UIImageView *separator;
@property(nonatomic, strong) NSArray* separators;
@property(nonatomic, strong) UIButton* startBt;
@property(nonatomic, strong) UIButton* finishBt;
@property(nonatomic, strong) UILabel* name;
@property(nonatomic, strong) UILabel* work;
@property(nonatomic, strong) UILabel* state;
@property(nonatomic, strong) UILabel* startTime;
@property(nonatomic, strong) UILabel* finishTime;

@end


@implementation BASEmployeeTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withContent:(NSDictionary*)contentData;
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        if(![contentData isKindOfClass:[NSNull class]]){
            self.contentData = [NSDictionary dictionaryWithDictionary:contentData];
            
       
            self.name = [UILabel new];
            self.name.font = [UIFont fontWithName:@"Helvetica-Bold" size:14.f];
            self.name.textColor = [UIColor blackColor];
            self.name.backgroundColor = [UIColor clearColor];
            [self.name setTextAlignment:NSTextAlignmentCenter];
            self.name.numberOfLines = 2;
            self.name.lineBreakMode = NSLineBreakByWordWrapping;
            [self.name setText:(NSString*)[_contentData objectForKey:@"name"]];
            [self.contentView addSubview:self.name];
            
            self.work = [UILabel new];
            self.work.font = [UIFont fontWithName:@"Helvetica-Bold" size:14.f];
            self.work.textColor = [UIColor blackColor];
            self.work.backgroundColor = [UIColor clearColor];
            [self.work setTextAlignment:NSTextAlignmentCenter];
            [self.work setText:(NSString*)[_contentData objectForKey:@"name_job"]];
            [self.contentView addSubview:self.work];
            
            self.state = [UILabel new];
            self.state.font = [UIFont fontWithName:@"Helvetica-Bold" size:14.f];
            self.state.textColor = [UIColor greenColor];
            self.state.backgroundColor = [UIColor clearColor];
            [self.state setTextAlignment:NSTextAlignmentCenter];
            NSNumber* status = (NSNumber*)[_contentData objectForKey:@"status"];
            [self.state setText:@"на работе"];
            if([status integerValue] == 0){
                [self.state setText:@"отсутствует"];
                self.state.textColor = [UIColor redColor];
            }
            [self.contentView addSubview:self.state];
            
            self.startTime = [UILabel new];
            self.startTime.font = [UIFont fontWithName:@"Helvetica-Bold" size:14.f];
            self.startTime.textColor = [UIColor blackColor];
            self.startTime.backgroundColor = [UIColor clearColor];
            [self.startTime setTextAlignment:NSTextAlignmentCenter];
            
            NSString* time = (NSString*)[_contentData objectForKey:@"coming_time"];
            if(time != nil){
                NSArray* sort = [time componentsSeparatedByString:@" "];
                time = [NSString stringWithFormat:@"%@",[sort objectAtIndex:1]];
                sort = [time componentsSeparatedByString:@":"];
                self.startTime.text = [NSString stringWithFormat:@"%@:%@",[sort objectAtIndex:0],[sort objectAtIndex:1]];
            }
            [self.contentView addSubview:self.startTime];
            
            self.finishTime = [UILabel new];
            self.finishTime.font = [UIFont fontWithName:@"Helvetica-Bold" size:14.f];
            self.finishTime.textColor = [UIColor blackColor];
            self.finishTime.backgroundColor = [UIColor clearColor];
            [self.finishTime setTextAlignment:NSTextAlignmentCenter];
            time = (NSString*)[_contentData objectForKey:@"leave_time"];
            if(time != nil){
                NSArray* sort = [time componentsSeparatedByString:@" "];
                time = [NSString stringWithFormat:@"%@",[sort objectAtIndex:1]];
                sort = [time componentsSeparatedByString:@":"];
                self.finishTime.text = [NSString stringWithFormat:@"%@:%@",[sort objectAtIndex:0],[sort objectAtIndex:1]];
            }
            [self.contentView addSubview:self.finishTime];
            
            NSNumber* id_job = (NSNumber*)[_contentData objectForKey:@"id_job"];
            if([id_job integerValue] != 1 ){
                self.startBt = [UIButton buttonWithType:UIButtonTypeCustom];
                [_startBt setBackgroundColor:[UIColor clearColor]];
                [_startBt addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
                [self.contentView addSubview:_startBt];
                
                self.finishBt = [UIButton buttonWithType:UIButtonTypeCustom];
                [_finishBt setBackgroundColor:[UIColor clearColor]];
                [_finishBt addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
                [self.contentView addSubview:_finishBt];
            }
        }
        self.separator = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"separator_person.png"]];
        [self.contentView addSubview:_separator];
        
        NSMutableArray *temp = [NSMutableArray new];
        for (int i = 0; i < 4; i++) {
            UIImageView *obj = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"razdelr_person.png"]];
            [temp addObject:obj];
            [self.contentView addSubview:obj];
        }
        self.separators = [NSArray arrayWithArray:temp];
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGRect frame = self.contentView.frame;
    
    [_separator setFrame:CGRectMake(0, frame.size.height - 0.5f, frame.size.width, 0.5f)];
    
    UIImageView* obj1 = (UIImageView*)[_separators objectAtIndex:0];
    [obj1 setFrame:CGRectMake(209.f, 0, 0.5f, 50.f)];

    UIImageView* obj2 = (UIImageView*)[_separators objectAtIndex:1];
    [obj2 setFrame:CGRectMake(400.5f, 0, 0.5f, 50.f)];
    
    UIImageView* obj3 = (UIImageView*)[_separators objectAtIndex:2];
    [obj3 setFrame:CGRectMake(606.5f, 0, 0.5f, 50.f)];

    UIImageView* obj4 = (UIImageView*)[_separators objectAtIndex:3];
    [obj4 setFrame:CGRectMake(712.5f, 0, 0.5f, 50.f)];


    [_name setFrame:CGRectMake(0, 0, obj1.frame.origin.x, frame.size.height - 0.5)];
    [_work setFrame:CGRectMake(obj1.frame.origin.x, 0, obj2.frame.origin.x - obj1.frame.origin.x, frame.size.height- 0.5)];
    [_state setFrame:CGRectMake(obj2.frame.origin.x, 0, obj3.frame.origin.x - obj2.frame.origin.x, frame.size.height- 0.5)];
    [_startTime setFrame:CGRectMake(obj3.frame.origin.x, 0, obj4.frame.origin.x - obj3.frame.origin.x, frame.size.height- 0.5)];
    [_finishTime setFrame:CGRectMake(obj4.frame.origin.x, 0, frame.size.width - obj4.frame.origin.x, frame.size.height- 0.5)];
    [_startBt setFrame:_startTime.frame];
    [_finishBt setFrame:_finishTime.frame];
    
    
}
- (void)clicked:(id) sender{
    UIButton* button = (UIButton*)sender;
    
    NSNumber* employee = (NSNumber*)[_contentData objectForKey:@"id_employee"];
    if(button == _startBt){
        if([_delegate respondsToSelector:@selector(clickedStartTime:)]){
            [_delegate clickedStartTime:[employee integerValue]];
        }
    } else{
        if([_delegate respondsToSelector:@selector(clickedFinishTime:)]){
            [_delegate clickedFinishTime:[employee integerValue]];
        }
    }
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
