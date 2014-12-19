//
//  UMTableViewCell.h
//  SWTableViewCell
//
//  Created by Matt Bowman on 12/2/13.
//  Copyright (c) 2013 Chris Wendel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWTableViewCell.h"

/*
 *  Example of a custom cell built in Storyboard
 */
@interface UMTableViewCell : SWTableViewCell

@property(nonatomic,strong)  NSDictionary* contentData;
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
