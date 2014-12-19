//
//  BASSortView.h
//  RestrauntSystemPad
//
//  Created by Sergey on 25.07.14.
//  Copyright (c) 2014 BestAppStudio. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol BASSortViewDelegate;


@interface BASSortView : UIView

@property (nonatomic, strong)NSString* dateString;
@property (nonatomic, strong)NSString* tableString;
@property (nonatomic, strong)NSString* waiterString;
@property(nonatomic, assign) id<BASSortViewDelegate> delegate;

@end


@protocol BASSortViewDelegate <NSObject>

@required
- (void)sortChoice:(BASSortView*)view withType:(SortState)type;
- (void)searchInData:(BASSortView*)view withData:(NSDictionary*)data;
- (void)closedatePicker:(BASSortView*)view withType:(SortState)type;
- (void)closedatePicker:(BASSortView*)view;
@end