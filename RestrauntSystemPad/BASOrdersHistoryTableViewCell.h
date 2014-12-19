//
//  BASOrdersHistoryTableViewCell.h
//  RestrauntSystem
//
//  Created by Sergey on 10.07.14.
//  Copyright (c) 2014 BestAppStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BASOrdersHistoryTableViewCell : UITableViewCell

@property (nonatomic,strong) NSDictionary* contentData;
@property (nonatomic,assign) OrdersHistoryType type;
@property (nonatomic,strong) UIImageView* bgView;
@property (nonatomic,strong) UIImageView* imgView;
@property (nonatomic,strong) UILabel* numberView;
@property (nonatomic,strong) UILabel* textView;
@property (nonatomic,strong) UILabel* priceView;
@property (nonatomic,strong) UILabel* discountView;
@property (nonatomic,strong) UILabel* timeView;
@property (nonatomic,assign) NSInteger status;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withContent:(NSDictionary*)contentData withType:(OrdersHistoryType)type;
@end
