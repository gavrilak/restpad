//
//  BASCategoryTableViewCell.m
//  RestrauntSystem
//
//  Created by Sergey on 06.06.14.
//  Copyright (c) 2014 BestAppStudio. All rights reserved.
//

#import "BASCategoryTableViewCell.h"

@interface BASCategoryTableViewCell()

@property(nonatomic,strong)UIImageView* bgView;
@property(nonatomic,strong)UIImageView* oclockView;
@property(nonatomic,strong)UILabel* titleLabel;

@end

@implementation BASCategoryTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withContent:(NSDictionary*)contentData
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentData = [NSDictionary dictionaryWithDictionary:contentData];
        
        [self setBackgroundColor:[UIColor clearColor]];
        
        self.bgView = [[UIImageView alloc]initWithImage:[_contentData objectForKey:[Settings text:TextForApiKeyImage]]];
        [self.contentView addSubview:_bgView];

        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.text = [self.contentData  objectForKey:[Settings text:TextForApiKeyTitle]];
        
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:_titleLabel];

        
        self.oclockView = [[UIImageView alloc]initWithImage:[self getIconLoadType:[_contentData objectForKey:[Settings text:TextForApiKeyTableState]]]];
        [self.contentView addSubview:_oclockView];

        
    }
    return self;
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    CGRect frame = self.contentView.frame;
    
    UIImage* img = (UIImage*)[_contentData objectForKey:[Settings text:TextForApiKeyImage]];
    [_bgView setFrame:CGRectMake(5.f, frame.size.height - img.size.height, frame.size.width - 10.f, img.size.height)];
    
    [_titleLabel setFrame:CGRectMake(5.f, frame.size.height - img.size.height, frame.size.width - 10.f, img.size.height)];
    
    img = (UIImage*)[Settings image:ImageForCatStateNormal];
    [_oclockView setFrame:CGRectMake(frame.size.width - img.size.width - 10.f, _bgView.frame.origin.y + 5.f, img.size.width, img.size.height)];
}
- (UIImage*)getIconLoadType:(NSNumber *)noticeType
{
    UIImage *img = nil;
    switch (noticeType.integerValue) {
        case 0:
            img = [Settings image:ImageForCatStateNormal];
            break;
        case 1:
            img = [Settings image:ImageForCatStateYellow];
            break;
        case 2:
            img = [Settings image:ImageForCatStateRed];
            break;
            
        default:
            break;
    }
    return img;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
