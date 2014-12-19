//
//  BASWarehouseTableViewCell.m
//  RestrauntSystemPad
//
//  Created by Sergey Bekker on 21.07.14.
//  Copyright (c) 2014 BestAppStudio. All rights reserved.
//

#import "BASWarehouseTableViewCell.h"

@interface BASWarehouseTableViewCell()

@property(nonatomic,strong)  NSDictionary* contentData;
@property(nonatomic, strong) UIImageView *separator;
@property(nonatomic, strong) UIImageView *vertseparator;
@property(nonatomic, strong) UILabel* nameElement;
@property(nonatomic, strong) UILabel* amount;
@end

@implementation BASWarehouseTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withContent:(NSDictionary*)contentData
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        if(![contentData isKindOfClass:[NSNull class]]){
            self.contentData = [NSDictionary dictionaryWithDictionary:contentData];
            self.nameElement = [UILabel new];
            self.nameElement.font = [UIFont fontWithName:@"Helvetica-Bold" size:22.f];
            self.nameElement.textColor = [UIColor blackColor];
            self.nameElement.backgroundColor = [UIColor clearColor];
            [self.nameElement setTextAlignment:NSTextAlignmentLeft];
            [self.nameElement setText:(NSString*)[_contentData objectForKey:@"name_element"]];
            [self.contentView addSubview:self.nameElement];
            
            self.amount = [UILabel new];
            self.amount.font = [UIFont fontWithName:@"Helvetica-Bold" size:22.f];
            self.amount.textColor = [UIColor blackColor];
            self.amount.backgroundColor = [UIColor clearColor];
            [self.amount setTextAlignment:NSTextAlignmentCenter];
            NSNumber* amount = (NSNumber*)[_contentData objectForKey:@"amount"];
            [self.amount setText:[NSString stringWithFormat:@"%d",[amount integerValue]]];
            [self.contentView addSubview:self.amount];
        }
    
        self.separator = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gorizont.png"]];
        [self.contentView addSubview:_separator];
        
        self.vertseparator = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"vertical.png"]];
        [self.contentView addSubview:_vertseparator];

    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGRect frame = self.contentView.frame;
    
    [_separator setFrame:CGRectMake(0.f, frame.size.height - 7.f, frame.size.width, 7.f)];
    [_vertseparator setFrame:CGRectMake(frame.size.width - 153.f, 0, 7.f, frame.size.height)];
    
    if(_nameElement != nil){
        [_nameElement setFrame:CGRectMake(30.f, -4.f, _vertseparator.frame.origin.x - 30.f, frame.size.height)];
        [_amount setFrame:CGRectMake(_vertseparator.frame.origin.x, -4.f, frame.size.width - _vertseparator.frame.origin.x, frame.size.height)];
    }
    
    
    

    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
