//
//  BASWarehouseTableViewCell.h
//  RestrauntSystemPad
//
//  Created by Sergey Bekker on 21.07.14.
//  Copyright (c) 2014 BestAppStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BASWarehouseTableViewCell : UITableViewCell

@property(nonatomic, assign) NSInteger index;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withContent:(NSDictionary*)contentData;


@end
