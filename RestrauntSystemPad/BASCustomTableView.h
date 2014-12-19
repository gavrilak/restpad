//
//  BASCustomTableView.h
//  RestrauntSystem
//
//  Created by Sergey on 06.06.14.
//  Copyright (c) 2014 BestAppStudio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BASSubCategoryTableViewCell.h"


@interface BASCustomTableView : UITableView <RCSDishCellItemDelegate>

@property (nonatomic,assign)TableType typeTable;

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style withContent:(NSArray*) content withType:(TableType)type withDelegate:(id) delegate;
- (CGFloat)hightCell:(TableType)type;

@end
