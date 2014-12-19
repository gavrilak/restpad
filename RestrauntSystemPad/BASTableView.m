//
//  BASTableView.m
//  RestrauntSystem
//
//  Created by Sergey on 11.06.14.
//  Copyright (c) 2014 BestAppStudio. All rights reserved.
//

#import "BASTableView.h"

#define TBLSIZE 90.f

@interface BASTableView()

@property(nonatomic, strong) UIButton *btView;
@property(nonatomic, strong) UILabel *lblWaiterName;


@end

@implementation BASTableView

- (void)setWaiterName:(NSString *)waiterName{
    _waiterName = waiterName;
    
    [_lblWaiterName setText:_waiterName];
}
- (void)setTableState:(TableState)tableState{
    
    _tableState = tableState;
    
    [_btView setBackgroundImage:[self setTableNum:[NSString stringWithFormat:@"%d",_num_table] whenState:_tableState] forState:UIControlStateNormal];

    if(_tableState == TableStateFree)
        [_lblWaiterName setText:@""];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
  
        self.btView = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btView setBackgroundColor:[UIColor clearColor]];
        [_btView setFrame:CGRectMake(frame.size.width / 2 - TBLSIZE / 2, frame.size.height / 2 - TBLSIZE /2, TBLSIZE, TBLSIZE)];
        [self addSubview:_btView];
        
        self.lblWaiterName = [[UILabel alloc]initWithFrame:frame];
        [_lblWaiterName setBackgroundColor:[UIColor clearColor]];
        _lblWaiterName.textAlignment = NSTextAlignmentCenter;
        _lblWaiterName.shadowColor = [UIColor clearColor];
        _lblWaiterName.textColor = [UIColor blackColor];
        _lblWaiterName.numberOfLines = 1;
        _lblWaiterName.font = [UIFont systemFontOfSize:14.f];
        [_lblWaiterName setFrame:CGRectMake(_btView.frame.origin.x + 10.f, _btView.frame.origin.y + _btView.frame.size.height - 27.5f, TBLSIZE - 13.f, 15.f)];
        [self addSubview:_lblWaiterName];

        [_btView addTarget:self action:@selector(onClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

#pragma mark - Action methods

- (void) onClicked{
    if([_delegate respondsToSelector:@selector(onClicked:withIndexRoom:withIndexTable:)]){
        [_delegate onClicked:self withIndexRoom:_indexRoom withIndexTable:_indexTable];
    }
}
#pragma mark - Private methods

- (UIImage *)setTableNum:(NSString *)tableNum whenState:(TableState)tableState
{
    UIImage *tableImg = nil;
    switch (tableState) {
        case TableStateBusy:
            tableImg = [Settings image:ImageForHallsBtnTableBusy];
            break;
            
        case TableStatePreorder:
            tableImg = [Settings image:ImageForHallsBtnTableWait];
            break;
            
        default:
            tableImg = [Settings image:ImageForHallsBtnTable];
            break;
    }
 
    return [self drawTableNum:tableNum onImage:tableImg];
}




- (UIImage *)drawTableNum:(NSString *)tableNum onImage:(UIImage *)img
{
    UIGraphicsBeginImageContextWithOptions(img.size, NO, 0.0);

    [img drawInRect:CGRectMake(0.f, 0.f, img.size.width, img.size.height)];
    
    CGSize nameSize = [tableNum sizeWithAttributes:@{NSFontAttributeName: [Settings font:FontForOrdersTableNum]}];
    CGPoint drawNamePoint = CGPointMake((img.size.width - nameSize.width) / 2,
                                        (img.size.height - nameSize.height) / 2 - 3.f);
  
    NSDictionary *dictionary = @{ NSFontAttributeName: [Settings font:FontForOrdersTableNum],
                                  NSForegroundColorAttributeName: [UIColor colorWithRed:129.0/255.0 green:91.0/255.0 blue:39.0/255.0 alpha:1.0]};
    [tableNum drawAtPoint:drawNamePoint withAttributes:dictionary];
    
    img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}



@end
