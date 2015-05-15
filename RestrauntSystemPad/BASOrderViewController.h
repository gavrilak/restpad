//
//  BASOrderViewController.h
//  RestrauntSystem
//
//  Created by Sergey on 10.06.14.
//  Copyright (c) 2014 BestAppStudio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BASCustomTableView.h"

@interface BASOrderViewController : BASBaseController

@property(nonatomic,strong)NSDictionary* contentData;
@property(nonatomic,strong)NSDictionary* titleInfo;
@property (nonatomic,strong) BASCustomTableView* tableView;
@property(nonatomic,assign)BOOL isMove;

@end
