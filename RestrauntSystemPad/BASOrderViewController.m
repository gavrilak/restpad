//
//  BASOrderViewController.m
//  RestrauntSystem
//
//  Created by Sergey on 10.06.14.
//  Copyright (c) 2014 BestAppStudio. All rights reserved.
//

#import "BASOrderViewController.h"
#import "BASCustomTableView.h"
#import "UMTableViewCell.h"

@interface BASOrderViewController ()

@property (nonatomic,strong) BASCustomTableView* tableView;
@property (nonatomic,strong) NSArray* dishesContent;
@property (nonatomic,strong) UIButton* btAdd;
@property (nonatomic,strong) UIButton* btOrder;
@property (nonatomic,strong) UIButton* btCalc;

@end

@implementation BASOrderViewController


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

    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_all.png"]]];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    [self prepareView];

}
- (void)viewWillDisappear:(BOOL)animated{
    TheApp;
    app.isOrder = NO;
    [super viewWillDisappear:animated];
}
#pragma mark - Private methods
- (void)prepareView{

    if(self.contentData != nil){
  
        [self.tableView removeFromSuperview];
        self.tableView = nil;
       
        NSDictionary* order = (NSDictionary*)[_contentData objectForKey:@"order"];

        self.dishesContent = nil;
        self.dishesContent = [NSArray arrayWithArray:(NSArray*)[order objectForKey:@"order_items"]];

        
        if(_isMove){
            TheApp;
            app.isVirtual = NO;
            self.tableView = [[BASCustomTableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped withContent:_dishesContent withType:SWIPE withDelegate:self];
        } else {
            self.tableView = [[BASCustomTableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain withContent:_dishesContent withType:SUBCATEGORYTABLE withDelegate:nil];
        }
        _tableView.delegate = (id)self;
        
       
        [self.view addSubview:_tableView];
    }
  
}

#pragma mark -
#pragma mark Table delegate methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [_tableView hightCell:_tableView.typeTable];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}
#pragma mark - SWTableViewDelegate
- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)_index
{
    [cell hideUtilityButtonsAnimated:YES];
     BASManager* manager = [BASManager sharedInstance];
    
    NSDictionary* dict = [[NSDictionary alloc] init];
    NSDictionary* data = ((UMTableViewCell*)cell).contentData;

    dict = @{
             @"id_dish_virtual": (NSNumber*)[data objectForKey:@"id_dish_virtual"],
             };
    [manager getData:[manager formatRequest:@"REMOVEFROMVIRTUALTABLE" withParam:dict] success:^(id responseObject) {
        
        NSLog(@"Response: %@",responseObject);
        NSArray* param = (NSArray*)[responseObject objectForKey:@"param"];
        
        if(param != nil && param.count > 0){
            NSMutableArray * temp = [[NSMutableArray alloc]initWithCapacity:_dishesContent.count];
            [temp addObjectsFromArray:_dishesContent];
            [temp removeObjectAtIndex:_index];
            self.dishesContent = [NSArray arrayWithArray:temp];
            [self performSelector:@selector(updateData) withObject:nil afterDelay:1.0];
        }
        
        
    } failure:^(NSString *error) {
        [manager showAlertViewWithMess:ERROR_MESSAGE];
    }];
}
- (void)updateData{
    [self.tableView removeFromSuperview];
    self.tableView = nil;
    TheApp;
    app.isVirtual = NO;
    self.tableView = [[BASCustomTableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped withContent:_dishesContent withType:SWIPE withDelegate:self];
    _tableView.delegate = (id)self;
    [self.view addSubview:_tableView];
    [app.virtualView UpdateBadge];
}
@end
