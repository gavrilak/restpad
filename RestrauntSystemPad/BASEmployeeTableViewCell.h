//
//  BASEmployeeTableViewCell.h
//  RestrauntSystemPad
//
//  Created by Sergey Bekker on 20.07.14.
//  Copyright (c) 2014 BestAppStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BASEmployeeTableViewCellDelegate;

@interface BASEmployeeTableViewCell : UITableViewCell


@property(nonatomic, assign) NSInteger index;
@property(nonatomic, assign) id<BASEmployeeTableViewCellDelegate> delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withContent:(NSDictionary*)contentData;

@end

@protocol BASEmployeeTableViewCellDelegate <NSObject>

@optional
- (void)clickedStartTime:(NSUInteger)index;
- (void)clickedFinishTime:(NSUInteger)index;

@end