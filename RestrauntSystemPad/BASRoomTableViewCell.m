//
//  BASRoomTableViewCell.m
//  RestrauntSystemPad
//
//  Created by Sergey on 21.07.14.
//  Copyright (c) 2014 BestAppStudio. All rights reserved.
//

#import "BASRoomTableViewCell.h"

@interface BASRoomTableViewCell(){
    BOOL state;
}

@property(nonatomic,strong)  NSDictionary* contentData;
@property(nonatomic,strong)  UIImageView    *bgView;
@property(nonatomic, strong) UILabel* nameElement;
@property (nonatomic,strong) UIButton* accesoryView;

@end

@implementation BASRoomTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withContent:(NSDictionary*)contentData 
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentData = [NSDictionary dictionaryWithDictionary:contentData];
        [self setBackgroundColor:[UIColor clearColor]];
        NSNumber* st = (NSNumber*)[_contentData objectForKey:@"availability"];
        state = (BOOL)st.integerValue;
        
        self.bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"button_holl.png"]];
        [self.contentView addSubview:_bgView];
        
        self.nameElement = [UILabel new];
        self.nameElement.font = [UIFont fontWithName:@"Helvetica-Bold" size:22.f];
        self.nameElement.textColor = [UIColor colorWithRed:90.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1.0];
        self.nameElement.shadowColor = [UIColor colorWithRed:188.0/255.0 green:188.0/255.0 blue:188.0/255.0 alpha:1.0];
        self.nameElement.shadowOffset = CGSizeMake(0.0, 1.0);
        self.nameElement.backgroundColor = [UIColor clearColor];
        [self.nameElement setTextAlignment:NSTextAlignmentCenter];
        [self.nameElement setText:(NSString*)[_contentData objectForKey:@"name_room"]];
        [self.contentView addSubview:self.nameElement];
        
        UIImage *image = [UIImage imageNamed:@"tick_act.png"];
        self.accesoryView = [UIButton buttonWithType:UIButtonTypeCustom];
        [_accesoryView setBackgroundColor:[UIColor clearColor]];
        [_accesoryView setImage:[UIImage imageNamed:@"cross_act.png"] forState:UIControlStateNormal];
        if(state)
            [_accesoryView setImage:image forState:UIControlStateNormal];
        [_accesoryView addTarget:self action:@selector(clicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_accesoryView];


        
    }
    return self;
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    CGRect frame = self.contentView.frame;
    
    UIImage* image = [UIImage imageNamed:@"button_holl.png"];
    [_bgView setFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    
    [_nameElement setFrame:_bgView.frame];
    [_accesoryView setFrame:CGRectMake(frame.size.width - 45.f, frame.size.height / 2 - 30.f, 40.f, 40.f)];

}
- (void)clicked{
    state = ! state;
    [_accesoryView setImage:[UIImage imageNamed:@"cross_act.png"] forState:UIControlStateNormal];
    if(state)
        [_accesoryView setImage:[UIImage imageNamed:@"tick_act.png"] forState:UIControlStateNormal];
    
    NSDictionary* dict = @{
                           @"id_room": (NSNumber*)[_contentData objectForKey:@"id_room"],
                           @"available": [NSNumber numberWithInt:(NSInteger)state],
                           };
    
    BASManager* manager = [BASManager sharedInstance];
    
    [manager getData:[manager formatRequest:@"SETAVAILABLEROOM" withParam:dict] success:^(id responseObject) {
        if([responseObject isKindOfClass:[NSDictionary class]]){
            NSArray* param = (NSArray*)[responseObject objectForKey:@"param"];
        }
    } failure:^(NSString *error) {
        [manager showAlertViewWithMess:ERROR_MESSAGE];
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}

@end
