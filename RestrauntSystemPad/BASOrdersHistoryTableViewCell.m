//
//  BASOrdersHistoryTableViewCell.m
//  RestrauntSystem
//
//  Created by Sergey on 10.07.14.
//  Copyright (c) 2014 BestAppStudio. All rights reserved.
//

#import "BASOrdersHistoryTableViewCell.h"



@interface BASOrdersHistoryTableViewCell()



@end

@implementation BASOrdersHistoryTableViewCell

- (void)setStatus:(NSInteger)status{
    _status = status;
    
    UIImage *image = nil;
    switch (_status) {
        case 0:
            image = [UIImage imageNamed:@"table_expectation_lenta.png"];
            break;
        case 1:
            image = [UIImage imageNamed:@"table_busy_lenta.png"];
            break;
        case 2:
            image = [UIImage imageNamed:@"table_lenta_inactive.png"];
            break;
            
        default:
            break;
    }
    [_imgView setImage:image];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withContent:(NSDictionary*)contentData withType:(OrdersHistoryType)type
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentData = [NSDictionary dictionaryWithDictionary:contentData];
        self.type = type;
        [self setBackgroundColor:[UIColor clearColor]];
        
        UIImage* image = [[UIImage imageNamed:@"bg_inactive.png"]stretchableImageWithLeftCapWidth:15.f topCapHeight:0];
        if(_type == CURRENTTYPE){
            image = [[UIImage imageNamed:@"bg_active.png"]stretchableImageWithLeftCapWidth:15.f topCapHeight:0];;
        }
        self.bgView = [[UIImageView alloc]initWithImage:image];
        [self addSubview:_bgView];
        
        
        
        self.textView = [[UILabel alloc]init];
        [_textView setBackgroundColor:[UIColor clearColor]];
        _textView.font = [UIFont fontWithName:@"Helvetica-Light" size:26.f];
        _textView.textColor = [UIColor whiteColor];
        _textView.shadowColor = [UIColor blackColor];
        _textView.shadowOffset = CGSizeMake(0.0, 1.0);
        _textView.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_textView];
        
        self.imgView = [[UIImageView alloc]init];
        [self addSubview:_imgView];
        
        self.numberView = [[UILabel alloc]init];
        [_numberView setBackgroundColor:[UIColor clearColor]];
        _numberView.font = [UIFont fontWithName:@"Helvetica-Light" size:22.f];
        _numberView.textColor = [UIColor grayColor];
        _numberView.shadowColor = [UIColor blackColor];
        _numberView.shadowOffset = CGSizeMake(0.0, -1.0);
        _numberView.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_numberView];
        
         if(_type == ALLTYPE){
            self.timeView =  [[UILabel alloc]init];
            [_timeView setBackgroundColor:[UIColor clearColor]];
            _timeView.font = [UIFont fontWithName:@"Helvetica-Light" size:12.f];
            _timeView.textColor = [UIColor lightGrayColor];
            _timeView.textAlignment = NSTextAlignmentCenter;
            [self addSubview:_timeView];
            
            self.priceView =  [[UILabel alloc]init];
            [_priceView setBackgroundColor:[UIColor clearColor]];
            _priceView.font = [UIFont fontWithName:@"Helvetica-Light" size:12.f];
            _priceView.textColor = [UIColor blackColor];
            _priceView.textAlignment = NSTextAlignmentCenter;
            [self addSubview:_priceView];
            
            self.discountView =  [[UILabel alloc]init];
            [_discountView setBackgroundColor:[UIColor clearColor]];
            _discountView.font = [UIFont fontWithName:@"Helvetica-Light" size:12.f];
            _discountView.textColor = [UIColor whiteColor];
            _discountView.textAlignment = NSTextAlignmentCenter;
            [self addSubview:_discountView];
         }

    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect frame = self.contentView.frame;
    
    UIImage* image = [UIImage imageNamed:@"bg_inactive.png"];
    
    [_bgView setFrame:CGRectMake(0, 0, frame.size.width, image.size.height)];
    [_textView setFrame:CGRectMake(0, 8.f, frame.size.width, 40.f)];
    if(_type == ALLTYPE){
        [_textView setFrame:CGRectMake(0, 3.f, frame.size.width, 40.f)];
        [_timeView setFrame:CGRectMake(frame.size.width / 2 - frame.size.width / 8, _textView.frame.size.height - 2.f, frame.size.width / 4, 15.f)];
        [_priceView setFrame:CGRectMake(frame.size.width - 82.f, _textView.frame.size.height - 2.f, 25.f, 15.f)];
        [_discountView setFrame:CGRectMake(frame.size.width - 53.f, _textView.frame.size.height - 2.f, 49.f, 15.f)];
        
    }
    
    image = [UIImage imageNamed:@"table_expectation_lenta.png"];
    [_imgView setFrame:CGRectMake(_bgView.frame.origin.x + 7.f, _bgView.frame.size.height / 2 - image.size.height /2 - 6.f, image.size.width + 10.f, image.size.height + 10.f)];
    
    [_numberView setFrame:_imgView.frame];
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [super setSelected:selected animated:animated];

}

@end
