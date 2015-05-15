//
//  BASOrderViewController.m
//  RestrauntSystem
//
//  Created by Sergey on 10.06.14.
//  Copyright (c) 2014 BestAppStudio. All rights reserved.
//

#import "BASOrderViewController.h"

#import "UMTableViewCell.h"
#import "BASPickerView.h"

@interface BASOrderViewController ()


@property (nonatomic,strong) NSArray* dishesContent;
@property (nonatomic,strong) UIButton* btAdd;
@property (nonatomic,strong) UIButton* btOrder;
@property (nonatomic,strong) UIButton* btCalc;
@property (nonatomic,strong) BASPickerView* pickerView;
@property (nonatomic,strong) NSArray *emptyList;
@property (nonatomic,strong) NSArray *orderList;
@property (nonatomic,strong) NSArray *waiterList;

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

    if(self.contentData != nil ){
  
        [self.tableView removeFromSuperview];
        self.tableView = nil;
       
        NSDictionary* order = (NSDictionary*)[_contentData objectForKey:@"order"];

        self.dishesContent = nil;
        self.dishesContent = [NSArray arrayWithArray:(NSArray*)[order objectForKey:@"order_items"]];

       
        
        if(_isMove){
            TheApp;
         
            app.isVirtual = YES;
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
   
    switch (_index)  {
        case 0:{
         //   UIAlertView *choiceAlertView = [[UIAlertView alloc]initWithTitle:@"" message:@"Переместить блюдо на стол:" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Новый",@"Виртуальный",@"Текущий",@"Отмена", nil];
          //  [choiceAlertView show];
            dict = @{
                      @"id_dish_virtual": (NSNumber*)[data objectForKey:@"id_dish_virtual"],
                      @"id_employee": (NSNumber*)[[[data objectForKey:@"order"] objectForKey:@"employee"] objectForKey:@"id_employee"],
                      @"id_table": (NSNumber*)[[data objectForKey:@"order"] objectForKey:@"id_table"],
                     };
            [manager getData:[manager formatRequest:@"MOVETOTABLE" withParam:dict] success:^(id responseObject) {
                
                NSLog(@"Response: %@",responseObject);
                NSArray* param = (NSArray*)[responseObject objectForKey:@"param"];
                
                if(param != nil && param.count > 0){
                    NSDictionary* dict = [param objectAtIndex:0];
                    NSDictionary* orderItems = [NSDictionary dictionaryWithObjectsAndKeys:[dict objectForKey:@"virtualTableElements"],@"order_items",nil];
                    NSDictionary* order = [NSDictionary dictionaryWithObjectsAndKeys:orderItems,@"order",nil];
                    self.contentData = order;

                    [self performSelector:@selector(updateData) withObject:nil afterDelay:1.0];
                }
                
                
            } failure:^(NSString *error) {
                [manager showAlertViewWithMess:ERROR_MESSAGE];
            }];

            
            break;
        }
        case 1:{
            dict = @{
                     @"id_dish_virtual": (NSNumber*)[data objectForKey:@"id_dish_virtual"],
                     };
            [manager getData:[manager formatRequest:@"REMOVEFROMVIRTUALTABLE" withParam:dict] success:^(id responseObject) {
                
                NSLog(@"Response: %@",responseObject);
                NSArray* param = (NSArray*)[responseObject objectForKey:@"param"];
                
                if(param != nil && param.count > 0){
                    NSDictionary* dict = [param objectAtIndex:0];
                    NSDictionary* orderItems = [NSDictionary dictionaryWithObjectsAndKeys:[dict objectForKey:@"virtualTableElements"],@"order_items",nil];
                    NSDictionary* order = [NSDictionary dictionaryWithObjectsAndKeys:orderItems,@"order",nil];
                    self.contentData = order;
                    self.dishesContent = [dict objectForKey:@"virtualTableElements"];
                    [self performSelector:@selector(updateData) withObject:nil afterDelay:1.0];
                }
                
                
            } failure:^(NSString *error) {
                [manager showAlertViewWithMess:ERROR_MESSAGE];
            }];

            break;
        }
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    TheApp;
    CGRect frame;
    NSMutableArray* result = [NSMutableArray new];
    NSMutableArray* tablesList = [NSMutableArray new];
    NSMutableArray* tablesNameList = [NSMutableArray new];
    NSMutableArray* waitersList = [NSMutableArray new];
    NSMutableArray* waitersNameList = [NSMutableArray new];
    NSNumber* cutTable = nil;
    BASManager* manager = [BASManager sharedInstance];
    [_pickerView removeFromSuperview];
    self.pickerView = nil;
    if(alertView.cancelButtonIndex != buttonIndex){
        switch (buttonIndex) {
            case 0:
                frame = CGRectMake(1024.f / 2 - 190.f, 768.f / 2 - 200.f, 470.f, 280.f);
                for(NSDictionary* obj in _emptyList){
                    NSArray* tables = (NSArray*)[obj objectForKey:@"tables"];
                    for(NSDictionary* tbl in tables){
                        NSDictionary* dict = @{@"id_table": (NSNumber*)[tbl objectForKey:@"id_table"],
                                               @"name_room": (NSString*)[obj objectForKey:@"name_room"]
                                               };
                        [tablesList addObject:dict];
                        NSNumber* number_table = (NSNumber*)[tbl objectForKey:@"number_table"];
                        [tablesNameList addObject:[NSString stringWithFormat:@"%d (%@)",[number_table intValue],(NSString*)[obj objectForKey:@"name_room"]]];
                    }
                    
                }
                self.emptyTemplate = [NSArray arrayWithArray:tablesList];
                [result addObject:tablesNameList];
                
                for(NSDictionary* obj in _waiterList){
                    NSDictionary* dict = @{@"id_employee": (NSNumber*)[obj objectForKey:@"id_employee"],
                                           @"first_name": (NSString*)[obj objectForKey:@"first_name"],
                                           @"surname": (NSString*)[obj objectForKey:@"surname"]
                                           };
                    [waitersList addObject:dict];
                    [waitersNameList addObject:[NSString stringWithFormat:@"%@",[dict objectForKey:@"surname"]]];
                    
                    
                }
                self.waiterTemplate = [NSArray arrayWithArray:waitersList];
                [result addObject:waitersNameList];
                self.pickerView = [[BASPickerView alloc]initWithFrame:frame withContent:[NSArray arrayWithArray:result] withDoneButton:YES withCancelButton:YES];
                self.pickerView.delegate = (id)self;
                [self.view addSubview:_pickerView];
                [self.view bringSubviewToFront:_pickerView];
                [_pickerView selectRow:0 inComponent:0];
                [_pickerView selectRow:0 inComponent:1];
                app.isBusy = YES;
                break;
            case 1:
                moveDict = @{
                             @"id_order": (NSNumber*)[moveDict objectForKey:@"id_order"],
                             @"id_dish_order": (NSNumber*)[moveDict objectForKey:@"id_dish_order"],
                             @"id_table": [NSNumber numberWithInt:-1],
                             @"id_employee": [NSNumber numberWithInt:-1],
                             };
                [self performSelector:@selector(showalertMessage) withObject:nil afterDelay:0.5];
                return;
                break;
            case 2:{
                if(tablesCount > 1){
                    frame = CGRectMake(1024.f / 2 - 125.f, 768.f / 2 - 200.f, 250.f, 260.f);
                    NSNumber* id_table = (NSNumber*)[moveDict objectForKey:@"id_table"];
                    for(NSDictionary* obj in _orderList){
                        NSNumber* cur_table = (NSNumber*)[obj objectForKey:@"id_table"];
                        if([id_table integerValue] != [cur_table integerValue]){
                            [tablesList addObject:obj];
                            NSNumber* number_table = (NSNumber*)[obj objectForKey:@"number_table"];
                            [tablesNameList addObject:[NSString stringWithFormat:@"%d (%@)",[number_table intValue],(NSString*)[obj objectForKey:@"name_room"]]];
                        }
                        
                    }
                    self.orderTemplate = [NSArray arrayWithArray:tablesList];
                    [result addObject:tablesNameList];
                    self.pickeView = [[BASPickerView alloc]initWithFrame:frame withContent:[NSArray arrayWithArray:result] withDoneButton:YES withCancelButton:NO];
                    self.pickeView.delegate = (id)self;
                    [self.view addSubview:_pickeView];
                    [self.view bringSubviewToFront:_pickeView];
                    [_pickeView selectRow:0 inComponent:0];
                } else
                    return;
            }

    
}
        
- (void)updateData{
    [self.tableView removeFromSuperview];
    self.tableView = nil;
    TheApp;
     app.isVirtual = YES;
    self.tableView = [[BASCustomTableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped withContent:_dishesContent withType:SWIPE withDelegate:self];
    _tableView.delegate = (id)self;
    [self.view addSubview:_tableView];
    [app.virtualView UpdateBadge];
}
@end
