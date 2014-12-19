//
//  BASNoticeTableViewCell.m
//  RestrauntSystem
//
//  Created by Sergey on 06.06.14.
//  Copyright (c) 2014 BestAppStudio. All rights reserved.
//

#import "BASNoticeTableViewCell.h"

@interface BASNoticeTableViewCell()

@property(nonatomic, strong) UIImageView *separator;
@property(nonatomic, strong) UIImageView *imgView;
@property(nonatomic, strong) UILabel *textView;
@property(nonatomic, strong) UILabel *detailView;


@end

@implementation BASNoticeTableViewCell

- (void)setNoticeState:(NoticeState)noticeState
{
    _noticeState = noticeState;
    
    UIImage *stateImg = [self getStateImg];
    [_imgView setImage:stateImg];
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    self.textView.text = title;

}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withContent:(NSDictionary*)contentData;
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentData = [NSDictionary dictionaryWithDictionary:contentData];
        self.backgroundColor = [UIColor clearColor];
        
        self.imgView = [UIImageView new];
        [self.contentView addSubview:_imgView];
        
        self.textView = [UILabel new];
        self.textView.font = [UIFont fontWithName:@"Helvetica-Light" size:20.f];
        self.textView.textColor = [UIColor colorWithRed:255.0/255.0 green:107.0/255.0 blue:108.0/255.0 alpha:1.0];
        self.textView.backgroundColor = [UIColor clearColor];
        [self.textView setTextAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:_textView];
        
        self.detailView = [UILabel new];
        self.detailView.font = [UIFont fontWithName:@"Helvetica-Light" size:20.f];
        self.detailView.textColor = [UIColor colorWithRed:142.0/255.0 green:215.0/255.0 blue:249.0/255.0 alpha:1.0];
        self.detailView.backgroundColor = [UIColor clearColor];
        [self.detailView setTextAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:_detailView];
        
        self.title = (NSString*)[_contentData objectForKey:@"message"];
        NSNumber *state = (NSNumber*)[_contentData objectForKey:@"message_status"];
        self.noticeState = (NoticeState)[state integerValue];
        self.detailView.text = [NSString stringWithFormat:@"(%@)",(NSString*)[_contentData objectForKey:@"name"]];
        [self setupSeparator];
       
    }
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];

    CGRect frame = self.contentView.frame;
    [self configSeparatorWithLeft:20.f andRightOffset:20.f];
    UIImage* image = [_imgView image];
    
    [_imgView setFrame:CGRectMake(_separator.frame.origin.x, frame.size.height / 2 - image.size.height / 2  - 7.f, image.size.width, image.size.height)];
    
    [_textView setFrame:CGRectMake(_imgView.frame.origin.x + _imgView.frame.size.width + 15.f, -8.f , frame.size.width - 80.f, frame.size.height)];
    
    CGSize maximumLabelSize = CGSizeMake(960, FLT_MAX);
    CGSize expectedLabelSize = [_textView.text sizeWithFont:_textView.font constrainedToSize:maximumLabelSize lineBreakMode:_textView.lineBreakMode];
    
    
    CGRect newFrame = _textView.frame;
    newFrame.size.width = expectedLabelSize.width;
    _textView.frame = newFrame;
    
    [_detailView setFrame:CGRectMake(_textView.frame.origin.x + _textView.frame.size.width + 15.f, -8.f , frame.size.width - 80.f, frame.size.height)];
    
  
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    
}

#pragma mark - Public methods


- (UIImage *)getStateImg
{
    UIImage *img = nil;
    switch (_noticeState) {
        case NoticeStateFulfilled:
            img = [Settings image:ImageForNoticesIconFulfilled];
            break;
        case NoticeStateUnfulfilled:
            img = [Settings image:ImageForNoticesIconUnfulfilled];
            break;
        default:
            break;
    }
    return img;
}

#pragma mark - Private methods
- (void)configSeparatorWithLeft:(CGFloat)left andRightOffset:(CGFloat)rightOffset
{
 
    CGRect separatorFrame = self.separator.frame;
    separatorFrame.origin.x = left;
    separatorFrame.origin.y = self.frame.size.height - separatorFrame.size.height;
    separatorFrame.size.width = self.frame.size.width - separatorFrame.origin.x - rightOffset;
    separatorFrame.size.height = 0.5f;
    self.separator.frame = separatorFrame;
    
}
- (void)setupSeparator
{
    self.separator = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"separator.png"]];
    [self.contentView addSubview:self.separator];
}


@end
