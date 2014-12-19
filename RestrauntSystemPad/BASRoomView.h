//
//  BASRoomView.h
//  RestrauntSystem
//
//  Created by Sergey on 06.06.14.
//  Copyright (c) 2014 BestAppStudio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BASTableView.h"


@protocol BASRoomViewDelegate;

@interface BASRoomView : UIView

@property (nonatomic,assign)    id <BASRoomViewDelegate> delegate;
@property (nonatomic,strong)    NSDictionary* contentData;
@property (nonatomic, assign)   NSUInteger  indexRoom;

- (id)initWithFrame:(CGRect)frame withContent:(NSDictionary*)contentData withIndex:(NSInteger)index withType:(RoomType)typeRoom;
- (void)createRoom;
@end


@protocol BASRoomViewDelegate <NSObject>

@required
- (void)selectTable:(BASRoomView*)view withIndexRoom:(NSUInteger)indexRoom withTableRect:(CGRect)rect withIndexTable:(NSInteger)indexTable;

@end