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
    
    [self getData];
    
    
}

#pragma mark - Private methods
- (void)getData{
   
    BASManager* manager = [BASManager sharedInstance];
    NSDictionary* dict = @{
                           @"id_dish": (NSNumber*)[_contentData objectForKey:@"id_dish"],
                           };
    
    
    [manager getData:[manager formatRequest:[Settings text:TextForApiFuncMenuDishesFormat] withParam:dict] success:^(id responseObject) {
        

        if([responseObject isKindOfClass:[NSDictionary class]]){
            
            
            NSArray* param = (NSArray*)[responseObject objectForKey:@"param"];
            NSLog(@"Response: %@",param);
            NSDictionary* dict = (NSDictionary*)[param objectAtIndex:0];
           
            if(dict != nil){
                [self prepareView:dict];
            }

        }
    } failure:^(NSString *error) {
        [manager showAlertViewWithMess:ERROR_MESSAGE];
    }];
}

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
