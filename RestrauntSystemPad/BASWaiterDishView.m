//
//  BASWaiterDishView.m
//  RestrauntSystem
//
//  Created by Sergey on 10.06.14.
//  Copyright (c) 2014 BestAppStudio. All rights reserved.
//

#import "BASWaiterDishView.h"
#import "SDWebImage/UIImageView+WebCache.h"


@interface BASWaiterDishView()

@property (nonatomic,strong) UIScrollView* scrollView;
@property (nonatomic,strong) UIImageView* imageView;
@property (nonatomic,strong) UILabel* wieghtView;
@property (nonatomic,strong) UILabel* timeView;
@property (nonatomic,strong) UILabel* noteView;
@property (nonatomic,strong) UIImageView* modBgView;
@property (nonatomic,strong) NSDictionary* contentData;


@end


@implementation BASWaiterDishView

- (id)initWithFrame:(CGRect)frame withData:(NSDictionary*)contentData
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        self.contentData = [NSDictionary dictionaryWithDictionary:contentData];
        self.scrollView = [[UIScrollView alloc]initWithFrame:frame];
        [_scrollView setBackgroundColor:[UIColor clearColor]];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = (id)self;
        _scrollView.showsVerticalScrollIndicator = YES;
        [_scrollView setContentOffset:CGPointMake(0, 0)];
        
        [self addSubview:_scrollView];
        
        UIView* bgImg = [UIView new];
        UIImage* image = [Settings image:ImageForDetailPicDecor];
        [bgImg setBackgroundColor:[UIColor colorWithPatternImage:image]];
        [bgImg setFrame:CGRectMake(frame.size.width / 2 - image.size.width /2, 20.f, image.size.width, image.size.height)];
        
        self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(bgImg.frame.origin.x + 5.f, bgImg.frame.origin.y + 5.f, bgImg.frame.size.width - 10.f, bgImg.frame.size.height - 10.f)];
        [_imageView setBackgroundColor:[UIColor clearColor]];

        NSString* link = [contentData objectForKey:@"descr_link"];
        [_imageView setImageWithURL:[NSURL URLWithString:link] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
        [_scrollView addSubview:_imageView];
        [_scrollView addSubview:bgImg];
        
        self.wieghtView = [[UILabel alloc] initWithFrame:CGRectMake(bgImg.frame.origin.x, bgImg.frame.origin.y + bgImg.frame.size.height + 20.f, frame.size.width - 2 * bgImg.frame.origin.x, 20.f)];
        _wieghtView.backgroundColor = [UIColor clearColor];
        _wieghtView.font = [UIFont boldSystemFontOfSize:18.0];
        _wieghtView.shadowColor = [Settings color:ColorForNavBarTitleShadow];
        _wieghtView.shadowOffset = [Settings offset:OffsetForNavBarTitleShadow];
        _wieghtView.textAlignment = NSTextAlignmentLeft;
        _wieghtView.textColor = [Settings color:ColorForNavBarTitle];
        _wieghtView.text = [NSString stringWithFormat:@"Вес: %@",(NSString*)[contentData objectForKey:@"weight"]];
        [_scrollView addSubview:_wieghtView];
        
        self.timeView = [[UILabel alloc] initWithFrame:CGRectMake(bgImg.frame.origin.x, bgImg.frame.origin.y + bgImg.frame.size.height + 50.f, frame.size.width - 2 * bgImg.frame.origin.x, 20.f)];
        _timeView.backgroundColor = [UIColor clearColor];
        _timeView.font = [UIFont boldSystemFontOfSize:18.0];
        _timeView.shadowColor = [Settings color:ColorForNavBarTitleShadow];
        _timeView.shadowOffset = [Settings offset:OffsetForNavBarTitleShadow];
        _timeView.textAlignment = NSTextAlignmentLeft;
        _timeView.textColor = [Settings color:ColorForNavBarTitle];
        _timeView.text = [NSString stringWithFormat:@"Время приготовления: %@",(NSString*)[contentData objectForKey:@"time_prepare"]];
        [_scrollView addSubview:_timeView];
        
        UILabel* about = [[UILabel alloc] initWithFrame:CGRectMake(bgImg.frame.origin.x, bgImg.frame.origin.y + bgImg.frame.size.height + 80.f, frame.size.width - 2 * bgImg.frame.origin.x, 20.f)];
        about.backgroundColor = [UIColor clearColor];
        about.font = [UIFont boldSystemFontOfSize:18.0];
        about.shadowColor = [Settings color:ColorForNavBarTitleShadow];
        about.shadowOffset = [Settings offset:OffsetForNavBarTitleShadow];
        about.textAlignment = NSTextAlignmentLeft;
        about.textColor = [Settings color:ColorForNavBarTitle];
        about.text = @"Описание:";
        [_scrollView addSubview:about];
        
        self.noteView = [[UILabel alloc] initWithFrame:CGRectMake(bgImg.frame.origin.x, bgImg.frame.origin.y + bgImg.frame.size.height + 110.f, frame.size.width - 2 * bgImg.frame.origin.x, 20.f)];
        _noteView.backgroundColor = [UIColor clearColor];
        _noteView.font = [UIFont boldSystemFontOfSize:16.0];
        _noteView.shadowColor = [Settings color:ColorForNavBarTitleShadow];
        _noteView.shadowOffset = [Settings offset:OffsetForNavBarTitleShadow];
        _noteView.textAlignment = NSTextAlignmentLeft;
        _noteView.textColor = [Settings color:ColorForNavBarTitle];
        _noteView.numberOfLines = 10;
        _noteView.text = (NSString*)[contentData objectForKey:@"description"];
        [_scrollView addSubview:_noteView];

        
        
        CGSize maximumLabelSize = CGSizeMake(296, FLT_MAX);
        CGSize expectedLabelSize = [_noteView.text sizeWithFont:_noteView.font constrainedToSize:maximumLabelSize lineBreakMode:_noteView.lineBreakMode];
   
        
        CGRect newFrame = _noteView.frame;
        newFrame.size.height = expectedLabelSize.height;
        _noteView.frame = newFrame;
        [_scrollView setContentSize:CGSizeMake(frame.size.width, _noteView.frame.size.height)];
        TheApp;
        NSArray* mod = (NSArray*)[_contentData objectForKey:@"mod"];
        if(app.isOrder && mod.count > 0){
            self.modBgView = [[UIImageView alloc]initWithFrame:CGRectMake(_noteView.frame.origin.x + 5.f, _noteView.frame.origin.y + 5.f, _noteView.frame.size.width - 10.f, _noteView.frame.size.height - 10.f)];
            [_modBgView setBackgroundColor:[UIColor colorWithPatternImage:[[UIImage imageNamed:@"cell_modifiers_x3.png"]stretchableImageWithLeftCapWidth:10.f topCapHeight:10.f]]];
            [_scrollView addSubview:_modBgView];
            
            [_scrollView setContentSize:CGSizeMake(frame.size.width, _modBgView.frame.size.height)];
        }
        
  
    }
    return self;
}

- (void)loadImage{
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        NSArray* buffer = (NSArray*)[_contentData objectForKey:@"descr_link"];
        
        unsigned c = buffer.count;
        uint8_t *bytes = malloc(sizeof(*bytes) * c);
        
        unsigned i;
        for (i = 0; i < c; i++)
        {
            NSString *str = [buffer objectAtIndex:i];
            int byte = [str intValue];
            bytes[i] = (uint8_t)byte;
        }
        
        NSData *datos = [NSData dataWithBytes:bytes length:c];
        UIImage *image = [UIImage imageWithData:datos];
        dispatch_async(dispatch_get_main_queue(), ^{
            _imageView.image = image;
        });
    });
}


@end
