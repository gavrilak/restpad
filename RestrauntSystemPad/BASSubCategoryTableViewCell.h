//
//  BASSubCategoryTableViewCell.h
//  RestrauntSystem
//
//  Created by Sergey on 06.06.14.
//  Copyright (c) 2014 BestAppStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, DishCellSubviewPosition)
{
    DishCellSubviewPositionLeft,
    DishCellSubviewPositionRight,
};

typedef void (^SuccessBlock)();

@protocol RCSDishCellItemDelegate;

@interface BASSubCategoryTableViewCell : UITableViewCell

@property(nonatomic,strong)NSDictionary* contentData;
@property(nonatomic, assign) id<RCSDishCellItemDelegate> delegate;
@property(nonatomic, strong) NSString       *title;
@property(nonatomic, assign) NSString       *cost;
@property(nonatomic, assign) NSString       *weight;
@property(nonatomic, assign) NSUInteger     count;
@property(nonatomic, assign) NSUInteger     dishIdx;
@property(nonatomic, assign) NSUInteger     countDish;
@property(nonatomic, assign) BOOL           inactive;
@property(nonatomic, assign) BOOL           modsExist;
@property(nonatomic, assign) BOOL           isDishCount;
@property(nonatomic, assign) OrderItemState state;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withContent:(NSDictionary*)contentData;
@end

@protocol RCSDishCellItemDelegate <NSObject>

@required
- (void)plusOneDish:(NSUInteger)dishIdx success:(SuccessBlock)success;
- (void)minusOneDish:(NSUInteger)dishIdx success:(SuccessBlock)success;
- (void)modificationDish:(NSUInteger)dishIdx;

@end