//
//  BASTableView.h
//  RestrauntSystem
//
//  Created by Sergey on 11.06.14.
//  Copyright (c) 2014 BestAppStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BASTableViewDelegate;

@interface BASTableView : UIView

@property(nonatomic, assign)    TableState  tableState;
@property(nonatomic, assign)    NSUInteger  id_table;
@property(nonatomic, strong)    NSString    *waiterName;
@property(nonatomic, assign)    NSUInteger  num_table;
@property(nonatomic, assign)    NSUInteger  indexTable;
@property(nonatomic, assign)    NSUInteger  indexRoom;
@property(nonatomic, assign)    id<BASTableViewDelegate> delegate;

@end

@protocol BASTableViewDelegate <NSObject>

@required
- (void)onClicked:(BASTableView*)view withIndexRoom:(NSInteger)indexRoom withIndexTable:(NSInteger)indexTable;


@end