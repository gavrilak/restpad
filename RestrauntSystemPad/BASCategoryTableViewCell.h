//
//  BASCategoryTableViewCell.h
//  RestrauntSystem
//
//  Created by Sergey on 06.06.14.
//  Copyright (c) 2014 BestAppStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BASCategoryTableViewCell : UITableViewCell

@property(nonatomic,strong)NSDictionary* contentData;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withContent:(NSDictionary*)contentData;

@end
