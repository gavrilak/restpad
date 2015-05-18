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
#import "CustomIOSAlertView.h"

@interface BASOrderViewController () <UIAlertViewDelegate >


@property (nonatomic,strong) NSArray* dishesContent;
@property (nonatomic,strong) UIButton* btAdd;
@property (nonatomic,strong) UIButton* btOrder;
@property (nonatomic,strong) UIButton* btCalc;
@property (nonatomic,strong) BASPickerView* pickerView;
@property (nonatomic,strong) NSArray *emptyList;
@property (nonatomic,strong) NSArray *orderList;
@property (nonatomic,strong) NSArray *waiterList;
@property (nonatomic,strong) NSArray *emptyTemplate;
@property (nonatomic,strong) NSArray *orderTemplate;
@property (nonatomic,strong) NSArray *waiterTemplate;
@property (nonatomic,strong) NSDictionary *moveDict;
@property (nonatomic,assign) NSInteger choiceIndex;
@property (nonatomic,strong) CustomIOSAlertView* customAlert;

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
    self.moveDict = data;
    switch (_index)  {
        case 0:{
            [self getPikerList];
            UIAlertView *choiceAlertView = [[UIAlertView alloc]initWithTitle:@"" message:@"Переместить блюдо на стол:" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Новый",@"Текущий",@"Отмена", nil];
            [choiceAlertView show];
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

- (void)updateData{
    TheApp;
    [self.tableView removeFromSuperview];
    self.tableView = nil;
    app.isVirtual = YES;
    self.tableView = [[BASCustomTableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped withContent:_dishesContent withType:SWIPE withDelegate:self];
    _tableView.delegate = (id)self;
    [self.view addSubview:_tableView];
    [app.virtualView UpdateBadge];
}
- (void)getPikerList{
    
    BASManager* manager = [BASManager sharedInstance];
    
    
    [manager getData:[manager formatRequest:@"GETTABLELIST" withParam:nil] success:^(id responseObject) {
        
        NSLog(@"Response: %@",responseObject);
        NSArray* param = (NSArray*)[responseObject objectForKey:@"param"];
        NSDictionary* dict = (NSDictionary*)[param objectAtIndex:0];
        if(dict != nil){
            self.emptyList = [NSArray arrayWithArray:(NSArray*)[dict objectForKey:@"empty"]];
            self.orderList = [NSArray arrayWithArray:(NSArray*)[dict objectForKey:@"orders"]];
            self.waiterList = [NSArray arrayWithArray:(NSArray*)[dict objectForKey:@"waiters"]];
            
        }
    } failure:^(NSString *error) {
        [manager showAlertViewWithMess:ERROR_MESSAGE];
    }];
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    TheApp;
    CGRect frame;
    NSMutableArray* result = [NSMutableArray new];
    NSMutableArray* tablesList = [NSMutableArray new];
    NSMutableArray* tablesNameList = [NSMutableArray new];
    NSMutableArray* waitersList = [NSMutableArray new];
    NSMutableArray* waitersNameList = [NSMutableArray new];
    [_pickerView removeFromSuperview];
    self.pickerView = nil;
    self.choiceIndex = buttonIndex;
    if(alertView.cancelButtonIndex != buttonIndex){
        switch (buttonIndex) {
            case 0:{
                frame = CGRectMake(0,0,470,280);
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
                [_pickerView selectRow:0 inComponent:0];
                [_pickerView selectRow:0 inComponent:1];
                
                self.customAlert = [[CustomIOSAlertView alloc] init];
            
                [self.customAlert setContainerView:self.pickerView];
                [self.customAlert setButtonTitles:nil];
                [self.customAlert setUseMotionEffects:true];
                [self.customAlert show];

                break;
        }
            case 1:{
                if([self.orderList count] > 1){
                    frame = CGRectMake(0,0,250,260);
                    for(NSDictionary* obj in _orderList){
                        [tablesList addObject:obj];
                        NSNumber* number_table = (NSNumber*)[obj objectForKey:@"number_table"];
                        [tablesNameList addObject:[NSString stringWithFormat:@"%d (%@)",[number_table intValue],(NSString*)[obj objectForKey:@"name_room"]]];
                    }
                    self.orderTemplate = [NSArray arrayWithArray:tablesList];
                    [result addObject:tablesNameList];
                    self.pickerView = [[BASPickerView alloc]initWithFrame:frame withContent:[NSArray arrayWithArray:result] withDoneButton:YES withCancelButton:NO];
                    self.pickerView.delegate = (id)self;
                    [_pickerView selectRow:0 inComponent:0];
                    
                    self.customAlert = [[CustomIOSAlertView alloc] init];
                    [self.customAlert setContainerView:self.pickerView];
                    [self.customAlert setButtonTitles:nil];
                    [self.customAlert setUseMotionEffects:true];
                    [self.customAlert show];
                }
            }
        }
    }
}


#pragma mark - BASPickerView delegate methods
- (void)doneClicked:(BASPickerView*)view withData:(NSDictionary*)data{
    
   BASManager* manager = [BASManager sharedInstance];
    [self.customAlert close];
    [_pickerView removeFromSuperview];
    self.pickerView = nil;
    NSDictionary *dict ;
    
    if(self.choiceIndex == 0){
        NSNumber* index1 = (NSNumber*)[data objectForKey:@"row1"];
        NSNumber* index2 = (NSNumber*)[data objectForKey:@"row2"];
        NSDictionary* empty = (NSDictionary*)[_emptyTemplate objectAtIndex:[index1 integerValue]];
        NSDictionary* waiter = (NSDictionary*)[_waiterTemplate objectAtIndex:[index2 integerValue]];
        dict = @{
                     @"id_dish_virtual": (NSNumber*)[self.moveDict objectForKey:@"id_dish_virtual"],
                     @"id_table": (NSNumber*)[empty objectForKey:@"id_table"],
                     @"id_employee": (NSNumber*)[waiter objectForKey:@"id_employee"],
                     };
      
    } else if(self.choiceIndex == 1){
        NSNumber* index1 = (NSNumber*)[data objectForKey:@"row1"];
        NSDictionary* order = (NSDictionary*)[_orderTemplate objectAtIndex:[index1 integerValue]];
        
         dict = @{
                    @"id_dish_virtual": (NSNumber*)[self.moveDict objectForKey:@"id_dish_virtual"],
                     @"id_table": (NSNumber*)[order objectForKey:@"id_table"],
                     @"id_employee": [NSNumber numberWithInt:-1],
                     };
    }
    
    [manager getData:[manager formatRequest:@"MOVETOTABLE" withParam:dict] success:^(id responseObject) {
        
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
    

    
}

- (void)cancelClicked:(BASPickerView*)view {
    
    [self.customAlert close];
    [_pickerView removeFromSuperview];
    
}

@end
