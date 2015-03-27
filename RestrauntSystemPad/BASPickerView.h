//
//  BASPickerView.h
//  RestrauntSystemPad
//
//  Created by Sergey on 28.07.14.
//  Copyright (c) 2014 BestAppStudio. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol BASPickerViewDelegate;


@interface BASPickerView : UIView <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic,strong)NSArray* content;

@property(nonatomic, assign) id<BASPickerViewDelegate> delegate;
- (id)initWithFrame:(CGRect)frame withContent:(NSArray*)content withDoneButton:(BOOL)state withCancelButton:(BOOL) cancel;
- (void)selectRow:(NSInteger)row inComponent:(NSInteger)component;
@end


@protocol BASPickerViewDelegate <NSObject>

@required
- (void)didSelect:(BASPickerView*)view withRow:(NSInteger)row withComponent:(NSInteger)component;
- (void)doneClicked:(BASPickerView*)view withData:(NSDictionary*)data;

@end