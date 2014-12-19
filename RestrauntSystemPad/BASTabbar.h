//
//  BASTabbar.h
//  RestrauntSystemPad
//
//  Created by Sergey on 19.07.14.
//  Copyright (c) 2014 BestAppStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BASTabbar : UIView

@property (nonatomic,assign)NSUInteger selectIndex;

- (void)showNoticesCount:(NSUInteger)noticesCnt;
@end
