//
//  RCSAuthView.h
//  RestaurantControlSystem
//
//  Created by Bogdan Stasjuk on 26/11/2013.
//  Copyright (c) 2013 BestApp Studio. All rights reserved.
//

@protocol RCSAuthViewDelegate;

@interface RCSAuthView : UIView

@property(nonatomic, strong) id<RCSAuthViewDelegate> delegate;

@property(nonatomic, strong) NSString   *error;
@property(nonatomic, assign) BOOL       activityViewAnimated;

// not available methods
- (id)init __attribute__((unavailable("init not available")));
- (id)initWithCoder:(NSCoder *)aDecoder __attribute__((unavailable("initWithCoder: not available")));
- (void)clearFields;
@end


@protocol RCSAuthViewDelegate <NSObject>

@required
- (void)btnEnterPressedWithLogin:(NSString *)login andPassword:(NSString *)pass;

@end