//
//  BASDishViewController.m
//  RestrauntSystem
//
//  Created by Sergey on 10.06.14.
//  Copyright (c) 2014 BestAppStudio. All rights reserved.
//

#import "BASDishViewController.h"
#import "BASWaiterDishView.h"

@interface BASDishViewController ()

@property (nonatomic,strong) BASWaiterDishView* waiterDishView;
@property (nonatomic,strong) UIScrollView* scrollView;
@end

@implementation BASDishViewController

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupBackBtn];

    self.scrollView = [[UIScrollView alloc]init];
    [_scrollView setBackgroundColor:[UIColor clearColor]];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.delegate = (id)self;
    _scrollView.showsVerticalScrollIndicator = YES;
    [self.view addSubview:_scrollView];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_all.png"]]];;

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
   [self prepareView:self.contentData];
    
    
}

#pragma mark - Private methods


- (void)prepareView:(NSDictionary*)obj{
    
        CGRect rect = CGRectMake(0, 0, 320.f, 568.f);

        self.waiterDishView = [[BASWaiterDishView alloc]initWithFrame:rect withData:obj];
        [_scrollView addSubview:_waiterDishView];
        
        [_scrollView setFrame:rect];

        [_scrollView setContentSize:CGSizeMake(rect.size.width, rect.size.height)];

   
}
- (void)loadImage{
    [_waiterDishView loadImage];
}
@end
