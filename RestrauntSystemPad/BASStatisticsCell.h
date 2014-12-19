//
//  BASStatisticsCell.h
//  RestrauntSystemPad
//
//  Created by Sergey on 03.11.14.
//  Copyright (c) 2014 BestAppStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BASStatisticsCell : UITableViewCell

@property (nonatomic,assign) NSInteger index;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withContent:(NSDictionary*)contentData withType:(StatisticsType)statType;

@end
