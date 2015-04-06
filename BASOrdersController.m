//
//  BASOrdersController.m
//  RestrauntSystemPad
//
//  Created by Sergey Bekker on 20.07.14.
//  Copyright (c) 2014 BestAppStudio. All rights reserved.
//

#import "BASOrdersController.h"
#import "BASCustomTableView.h"
#import "BASOrderViewController.h"
#import "UMTableViewCell.h"
#import "BASInfoView.h"
#import "BASSortView.h"
#import "BASPickerView.h"

@interface BASOrdersController (){
    NSInteger index;
    NSInteger choiceIndex;
    NSInteger tablesCount;
    NSDictionary* moveDict;
    NSDate* searchDate;
    NSString* table;
    NSString* waiter;
    NSInteger id_table;
    NSInteger id_waiter;
    SortState sortState;
    
    
}


@property (nonatomic,strong) NSMutableArray *contentData;
@property (nonatomic,strong) NSArray *subContentData;
@property (nonatomic,strong) NSArray *emptyList;
@property (nonatomic,strong) NSArray *orderList;
@property (nonatomic,strong) NSArray *waiterList;
@property (nonatomic,strong) NSArray *emptyTemplate;
@property (nonatomic,strong) NSArray *orderTemplate;
@property (nonatomic,strong) NSArray *waiterTemplate;
@property (nonatomic,strong) NSArray *tablePickerList;
@property (nonatomic,strong) NSArray *waiterPickerList;
@property (nonatomic,strong) BASCustomTableView* tableView;
@property (nonatomic,strong) UIImageView* separatorView;
@property (nonatomic, strong)  BASCustomTableView* contentTableView;
@property (nonatomic, strong) UILabel* nameCategory;
@property (nonatomic,strong) BASInfoView* infoView;
@property (nonatomic,strong) BASSortView* sortView;
@property (nonatomic,strong) UIAlertView *choiceAlertView;
@property (nonatomic,strong) BASPickerView* pickeView;
@property (nonatomic, strong)UIDatePicker *datePicker;
@property (nonatomic,strong) UIPickerView *pickerSort;
@property (nonatomic, assign) BOOL loadingData;

@end


@implementation BASOrdersController

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
    
    [self getSortPikerList];
    
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_all.png"]]];
    [self setupBtnLogout];
    self.title = @"Заказы";

    searchDate = [NSDate date];
    sortState = ALLORDERSBYTABLE;
    
    self.datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(5.f, 75.f, 380.f, 150.f)];
    [_datePicker addTarget:self action:@selector(pickerChanged:)forControlEvents:UIControlEventValueChanged];
    _datePicker.datePickerMode = UIDatePickerModeDate;
    [_datePicker setDate:searchDate];
    _datePicker.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_datePicker];
    [_datePicker setHidden:YES];
    
    self.pickerSort = [[UIPickerView alloc]initWithFrame:CGRectMake(5.f, 75.f, 380.f, 150.f)];
    
    self.pickerSort.dataSource = (id)self;
    self.pickerSort.delegate = (id)self;
    _pickerSort.backgroundColor = [UIColor whiteColor];
    [self.pickerSort setUserInteractionEnabled:YES];
    [self.view addSubview:_pickerSort];
    [_pickerSort setHidden:YES];
    
    [_sortView removeFromSuperview];
    self.sortView = nil;
    self.sortView = [[BASSortView alloc]initWithFrame:CGRectMake(5.f, 5.f, 390.f, 90.f)];
    _sortView.dateString = [self stringFromDate:searchDate withState:NO];
    _sortView.delegate = (id)self;
    [self.view addSubview:_sortView];
    [_sortView setHidden:YES];
    

    index = 0;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    TheApp;
    [self.view addSubview:app.tabBar];
    [_separatorView removeFromSuperview];
    self.separatorView = nil;
    self.separatorView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"delimiter_long.png"]];
    [_separatorView setFrame:CGRectMake(400.f, 0, 2.f, self.view.frame.size.height - 56.f)];
    [self.view addSubview:_separatorView];
    [self getPikerList];
    [self getData];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    TheApp;
    [app.tabBar removeFromSuperview];
    app.isOrder = NO;
}
#pragma mark - Private methods
- (void)getSortPikerList{
    
    BASManager* manager = [BASManager sharedInstance];
    
    
    [manager getData:[manager formatRequest:@"GETTABLELISTALL" withParam:nil] success:^(id responseObject) {
        
        NSLog(@"Response: %@",responseObject);
        NSArray* param = (NSArray*)[responseObject objectForKey:@"param"];
        NSDictionary* dict = (NSDictionary*)[param objectAtIndex:0];
        if(dict != nil){

            NSMutableArray* tablesList = [NSMutableArray new];
            NSMutableArray* waitersList = [NSMutableArray new];

            
            NSArray* emptyList = [NSArray arrayWithArray:(NSArray*)[dict objectForKey:@"tables"]];
            NSArray* waiterList = [NSArray arrayWithArray:(NSArray*)[dict objectForKey:@"waiters"]];
            
            for(NSDictionary* obj in emptyList){
                NSArray* tables = (NSArray*)[obj objectForKey:@"tables"];
                for(NSDictionary* tbl in tables){
                    NSDictionary* dict = @{@"id_table": (NSNumber*)[tbl objectForKey:@"id_table"],
                                           @"name_room": (NSString*)[obj objectForKey:@"name_room"],
                                           @"number_table": (NSNumber*)[tbl objectForKey:@"number_table"],
                                           @"id_room": (NSNumber*)[tbl objectForKey:@"id_room"]
                                           };
                    [tablesList addObject:dict];

                }
                
            }
            self.tablePickerList = [NSArray arrayWithArray:tablesList];
   
            
            for(NSDictionary* obj in waiterList){
                NSDictionary* dict = @{@"id_employee": (NSNumber*)[obj objectForKey:@"id_employee"],
                                       @"first_name": (NSString*)[obj objectForKey:@"first_name"],
                                       @"surname": (NSString*)[obj objectForKey:@"surname"]
                                       };
                [waitersList addObject:dict];
    
            }
            self.waiterPickerList = [NSArray arrayWithArray:waitersList];
 
        }
    } failure:^(NSString *error) {
        [manager showAlertViewWithMess:ERROR_MESSAGE];
    }];
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
            tablesCount = _orderList.count;
  
        }
    } failure:^(NSString *error) {
        [manager showAlertViewWithMess:ERROR_MESSAGE];
    }];
}

- (void)getData{
 
    TheApp;
    BASManager* manager = [BASManager sharedInstance];
    NSDictionary *params = nil;
    sortState = ALLORDERS;
    
    params =  [NSDictionary dictionaryWithObjectsAndKeys:
              [NSNumber numberWithInteger:0] ,@"offset",
              [NSNumber numberWithInteger:20] ,@"count",
              nil];
    
    [manager getData:[manager formatRequest:@"GETALLORDERS" withParam:params] success:^(id responseObject) {
        
       // NSLog(@"Response: %@",responseObject);
        NSArray* param = (NSArray*)[responseObject objectForKey:@"param"];
        
        if(param != nil && param.count > 0){
            self.contentData = [NSMutableArray arrayWithArray:param];
            [app.virtualView removeFromSuperview];
            app.virtualView = nil;
            app.virtualView = [[BASVirtualTableView alloc]initWithFrame:CGRectMake(1024.f - 125.5f, 768.f - 290.f, 125.5f, 168.f)];
            [self.view addSubview:app.virtualView];
            if(_contentData.count > 0){
                [self prepareView];
            }
        }
    } failure:^(NSString *error) {
        [manager showAlertViewWithMess:ERROR_MESSAGE];
    }];
}

- (void)addSortDataFromServer {
    
    BASManager* manager = [BASManager sharedInstance];
    
    if (self.loadingData != YES) {
        
        self.loadingData = YES;
        NSDictionary *params = nil;
        NSString* command = nil;
        switch (sortState){
                case ALLORDERS:
                command = @"GETALLORDERS";
                params =  [NSDictionary dictionaryWithObjectsAndKeys:
                           [NSNumber numberWithInteger:[self.contentData count]+1] ,@"offset",
                           [NSNumber numberWithInteger:20] ,@"count",
                           nil];
                break;
            case ALLORDERSBYDATE:
                command = @"GETALLORDERSBYDATE";
                params =  [NSDictionary dictionaryWithObjectsAndKeys:
                          [NSString stringWithFormat:@"%@",[self stringFromDate:searchDate withState:YES]] ,@"date",
                          [NSNumber numberWithInteger:[self.contentData count]+1] ,@"offset",
                          [NSNumber numberWithInteger:20] ,@"count",
                           nil];
                break;
            case ALLORDERSBYTABLE:
                command = @"GETALLORDERSBYTABLE";
                params =  [NSDictionary dictionaryWithObjectsAndKeys:
                          [NSNumber numberWithInteger:id_table] ,@"id_table",
                          [NSNumber numberWithInteger:[self.contentData count]+1] ,@"offset",
                          [NSNumber numberWithInteger:20] ,@"count",
                          nil];
                break;
            case ALLORDERSBYEMPLOYEE:
                command = @"GETALLORDERSBYEMPLOYEE";
                params =  [NSDictionary dictionaryWithObjectsAndKeys:
                          [NSNumber numberWithInteger:id_waiter] ,@"id_employee",
                          [NSNumber numberWithInteger:[self.contentData count]+1] ,@"offset",
                          [NSNumber numberWithInteger:20] ,@"count",
                         nil];
                break;
                
            default:
                break;
        }

        NSLog(@"@%lu, %@",(unsigned long)[self.contentData count], command);
        [manager getData:[manager formatRequest:command withParam:params] success:^(id responseObject) {
            
            NSArray* param = (NSArray*)[responseObject objectForKey:@"param"];
            if(param != nil && param.count > 0){
                
                [self.contentData   addObjectsFromArray:param];
                NSMutableArray* newPaths = [NSMutableArray array];
                for (int i = (int)[self.contentData count] - (int)[param count]; i < [self.contentData count]; i++) {
                    [newPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
                }
                self.tableView.contentData = self.contentData;
                [self.tableView beginUpdates];
                [self.tableView insertRowsAtIndexPaths:newPaths withRowAnimation:UITableViewRowAnimationNone];
                [self.tableView endUpdates];
                
               
            }
            self.loadingData = NO;
        } failure:^(NSString *error) {
            [manager showAlertViewWithMess:ERROR_MESSAGE];
            self.loadingData = NO;
        }];
        
        
    }
}


- (void)getSortData:(SortState)state{
    
    BASManager* manager = [BASManager sharedInstance];
    NSString* command = nil;
    NSDictionary* param =  nil;
    switch (state) {
        case ALLORDERSBYDATE:
            command = @"GETALLORDERSBYDATE";
            param =  [NSDictionary dictionaryWithObjectsAndKeys:
                         [NSString stringWithFormat:@"%@",[self stringFromDate:searchDate withState:YES]] ,@"date",
                      [NSNumber numberWithInteger:0] ,@"offset",
                      [NSNumber numberWithInteger:20] ,@"count",
                         nil];
            break;
        case ALLORDERSBYTABLE:
            command = @"GETALLORDERSBYTABLE";
            param =  [NSDictionary dictionaryWithObjectsAndKeys:
                      [NSNumber numberWithInteger:id_table] ,@"id_table",
                      [NSNumber numberWithInteger:0] ,@"offset",
                      [NSNumber numberWithInteger:20] ,@"count",
                      nil];
            break;
        case ALLORDERSBYEMPLOYEE:
            command = @"GETALLORDERSBYEMPLOYEE";
            param =  [NSDictionary dictionaryWithObjectsAndKeys:
                      [NSNumber numberWithInteger:id_waiter] ,@"id_employee",
                      [NSNumber numberWithInteger:0] ,@"offset",
                      [NSNumber numberWithInteger:20] ,@"count",
                      nil];
            break;
            
        default:
            break;
    }
    
    
    [manager getData:[manager formatRequest:command withParam:param] success:^(id responseObject) {
        
        NSLog(@"Response: %@",responseObject);
        NSArray* param = (NSArray*)[responseObject objectForKey:@"param"];
        
        if(param != nil && param.count > 0){
            self.contentData = [NSMutableArray arrayWithArray:param];
            if(_contentData.count > 0){
                [self prepareView];
            }
        } else {
            _sortView.dateString = @"Все";
            _sortView.tableString = @"Все";
            _sortView.waiterString = @"Все";
            [manager showAlertViewWithMess:@"По Вашему запросу ничего ненайдено!"];
        }
    } failure:^(NSString *error) {
        [manager showAlertViewWithMess:ERROR_MESSAGE];
    }];
}

- (void)prepareView{
    
    CGRect frame = CGRectMake(10.f, 75.f, 380.f, self.view.frame.size.height - 56.f - 75.f);
    
    [_sortView setHidden:NO];
    
    [_tableView removeFromSuperview];
    self.tableView = nil;
    self.tableView = [[BASCustomTableView alloc]initWithFrame:frame style:UITableViewStylePlain withContent:_contentData withType:ORDERSLIST withDelegate:nil];
    _tableView.delegate = (id)self;
    [_tableView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:_tableView];
    
    [self.view bringSubviewToFront:_datePicker];
    [self.view bringSubviewToFront:_pickerSort];

    NSDictionary*  dict = (NSDictionary*)[_contentData objectAtIndex:index];
    NSNumber* id_order = (NSNumber*)[dict objectForKey:@"id_order"];
    [self getOrderList:id_order];
    
}
- (void)getOrderList:(NSNumber*)ID{
  
    BASManager* manager = [BASManager sharedInstance];
    NSDictionary* dict = @{
                           @"id_order": ID,
                           };
    
    [manager getData:[manager formatRequest:@"GETORDER" withParam:dict] success:^(id responseObject) {
        
        NSLog(@"Response: %@",responseObject);
        NSArray* param = (NSArray*)[responseObject objectForKey:@"param"];
        
        if(param != nil && param.count > 0){
    
       
            NSDictionary* dict = (NSDictionary*)[param objectAtIndex:0];
            dict = (NSDictionary*)[dict objectForKey:@"order"];
            NSArray* content = (NSArray*)[dict objectForKey:@"order_items"];
            NSMutableArray* temp = [NSMutableArray new];
            
            for(NSDictionary* obj in content){
                NSNumber* count_dish = (NSNumber*)[obj objectForKey:@"count_dish"];
                for(int i = 0; i < [count_dish intValue]; i ++){
                    dict = @{
                             @"id_dish": (NSNumber*)[obj objectForKey:@"id_dish"],
                             @"id_table": (NSNumber*)[obj objectForKey:@"id_table"],
                             @"name_dish": (NSNumber*)[obj objectForKey:@"name_dish"],
                             @"price": (NSNumber*)[obj objectForKey:@"price"],
                             @"weight": (NSNumber*)[obj objectForKey:@"weight"],
                             @"id_order": (NSNumber*)[obj objectForKey:@"id_order"],
                             @"id_dish_order": (NSNumber*)[obj objectForKey:@"id_dish_order"],
                             };
                    [temp addObject:dict];
                }
                NSLog(@"count dish %d",count_dish.intValue);
            }
            self.subContentData = [NSArray arrayWithArray:temp];
            CGRect frame = CGRectMake(_separatorView.frame.origin.x + _separatorView.frame.size.width + 20.f, 20.f, 320.f, 768.f - 140.f);
            [_contentTableView removeFromSuperview];
            _contentTableView = nil;
            TheApp;
            app.isVirtual = YES;
            self.contentTableView = [[BASCustomTableView alloc]initWithFrame:frame style:UITableViewStyleGrouped withContent:_subContentData withType:SWIPE withDelegate:self];
            _contentTableView.delegate = (id)self;
            [_contentTableView setBackgroundColor:[UIColor clearColor]];
            [self.view addSubview:_contentTableView];
         //   NSLog(@"%@",_contentData);
            dict = (NSDictionary*)[_contentData objectAtIndex:index];
         //   NSLog(@"%@",dict);
            NSDictionary* employee = (NSDictionary*)[dict objectForKey:@"employee"];
            NSNumber* number_table = (NSNumber*)[dict objectForKey:@"number_table"];
            dict = (NSDictionary*)[param objectAtIndex:0];
            NSString* name_room = (NSString*)[dict objectForKey:@"name_room"];
            
            
            dict = @{
                     @"name": (NSString*)[employee objectForKey:@"surname"],
                     @"table": [NSString stringWithFormat:@"%d (%@)",[number_table intValue],name_room],
                     };
            [_infoView removeFromSuperview];
            self.infoView = nil;
            self.infoView = [[BASInfoView alloc]initWithFrame:CGRectMake(1024.f - 260.f, 55.f, 239.f, 176.f) withContent:dict];
            [self.view addSubview:_infoView];
            
        }

    }failure:^(NSString *error) {
        [manager showAlertViewWithMess:ERROR_MESSAGE];
    }];

    

}

#pragma mark - SWTableViewDelegate

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)_index
{
    [cell hideUtilityButtonsAnimated:YES];
    
    BASManager* manager = [BASManager sharedInstance];
    
    NSDictionary* dict = (NSDictionary*)[_contentData objectAtIndex:index];
    NSNumber* status = (NSNumber*)[dict objectForKey:@"status"];
    moveDict = ((UMTableViewCell*)cell).contentData;
    if([status intValue] == 0){
  
        [self getPikerList];
        switch (_index) {
            case 0:{
         
                self.choiceAlertView = nil;
                if(tablesCount > 1){
                    self.choiceAlertView = [[UIAlertView alloc]initWithTitle:@"" message:@"Переместить блюдо на стол:" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Новый",@"Виртуальный",@"Текущий",@"Отмена", nil];
                } else {
                    self.choiceAlertView = [[UIAlertView alloc]initWithTitle:@"" message:@"Переместить блюдо на стол:" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Новый",@"Виртуальный",@"Отмена", nil];
                }

                [_choiceAlertView show];
                return;

            }
                break;
            case 1:{
                UIAlertView* alert=  [[UIAlertView alloc]initWithTitle:@"" message:@"Удалить блюдо?" delegate:self cancelButtonTitle:@"Heт" otherButtonTitles :@"Да",nil];
                alert.tag = 101;
                [alert show];
                
                return;
            }
                break;
           
            default:
                break;
        }

        
    } else {
        [manager showAlertViewWithMess:@"Данная операция невозможна"];
    }

}
- (void)moveToTable{
    BASManager* manager = [BASManager sharedInstance];
    
    [manager getData:[manager formatRequest:@"MOVETOTABLE" withParam:moveDict] success:^(id responseObject) {
        
        NSLog(@"Response: %@",responseObject);
        NSArray* param = (NSArray*)[responseObject objectForKey:@"param"];
        
        if(param != nil && param.count > 0){
           
            [self getData];
        }
        
    } failure:^(NSString *error) {
        [manager showAlertViewWithMess:ERROR_MESSAGE];
    }];

}
- (void)showalertMessage{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Сообщение" message:@"Вы уверены что хотите переместить блюдо?" delegate:self cancelButtonTitle:@"Да" otherButtonTitles:@"Нет", nil];
    
    [alertView show];
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
    [_pickeView removeFromSuperview];
    self.pickeView = nil;
    
    if(alertView.tag ==  101) {
        if(alertView.cancelButtonIndex != buttonIndex){

            NSString* command = @"REMOVEORDERELEMENT";
            NSDictionary* dict = @{
                                   @"id_order": (NSNumber*)[moveDict objectForKey:@"id_order"],
                                   @"id_dish_order": (NSNumber*)[moveDict objectForKey:@"id_dish_order"],
                                   };
            [manager getData:[manager formatRequest:command withParam:dict] success:^(id responseObject) {
            
                //  NSLog(@"Response: %@",responseObject);
                NSArray* param = (NSArray*)[responseObject objectForKey:@"param"];
            
                if(param != nil && param.count > 0){
                    NSDictionary* dict = (NSDictionary*)[_contentData objectAtIndex:index];
                    NSNumber* id_order = (NSNumber*)[dict objectForKey:@"id_order"];
                    [self getOrderList:id_order];
                }
            
            
                } failure:^(NSString *error) {
                [manager showAlertViewWithMess:ERROR_MESSAGE];
                }];
            }

    } else {
        if(alertView == _choiceAlertView){
        choiceIndex = buttonIndex;
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
                    self.pickeView = [[BASPickerView alloc]initWithFrame:frame withContent:[NSArray arrayWithArray:result] withDoneButton:YES withCancelButton:YES];
                    self.pickeView.delegate = (id)self;
                    [self.view addSubview:_pickeView];
                    [self.view bringSubviewToFront:_pickeView];
                    [_pickeView selectRow:0 inComponent:0];
                    [_pickeView selectRow:0 inComponent:1];
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
                    break;
                    
                default:
                    break;
            }
            
            
            
            
        }
    } else {
        if(alertView.cancelButtonIndex == buttonIndex){
            [self moveToTable];
        }
    }
    }
}
#pragma mark - BASPickerView delegate methods
- (void)doneClicked:(BASPickerView*)view withData:(NSDictionary*)data{
    
    TheApp;
    app.isBusy = NO;
    [_pickeView removeFromSuperview];
    self.pickeView = nil;
    
    if(choiceIndex == 0){
        NSNumber* index1 = (NSNumber*)[data objectForKey:@"row1"];
        NSNumber* index2 = (NSNumber*)[data objectForKey:@"row2"];
        NSDictionary* empty = (NSDictionary*)[_emptyTemplate objectAtIndex:[index1 integerValue]];
        NSDictionary* waiter = (NSDictionary*)[_waiterTemplate objectAtIndex:[index2 integerValue]];
        moveDict = @{
                     @"id_order": (NSNumber*)[moveDict objectForKey:@"id_order"],
                     @"id_dish_order": (NSNumber*)[moveDict objectForKey:@"id_dish_order"],
                     @"id_table": (NSNumber*)[empty objectForKey:@"id_table"],
                     @"id_employee": (NSNumber*)[waiter objectForKey:@"id_employee"],
                     };
        [self showalertMessage];
    } else if(choiceIndex == 2){
        NSNumber* index1 = (NSNumber*)[data objectForKey:@"row1"];
        NSDictionary* order = (NSDictionary*)[_orderTemplate objectAtIndex:[index1 integerValue]];

        moveDict = @{
                     @"id_order": (NSNumber*)[moveDict objectForKey:@"id_order"],
                     @"id_dish_order": (NSNumber*)[moveDict objectForKey:@"id_dish_order"],
                     @"id_table": (NSNumber*)[order objectForKey:@"id_table"],
                     @"id_employee": [NSNumber numberWithInt:-1],
                     };

        [self showalertMessage];
    }
    
    
}

- (void)cancelClicked:(BASPickerView*)view {
    
    TheApp;
    app.isBusy = NO;
    [_pickeView removeFromSuperview];
    
}

#pragma mark -
#pragma mark BASSortView delegate methods
- (void)sortChoice:(BASSortView*)view withType:(SortState)type{
    [_pickeView removeFromSuperview];
    self.pickeView = nil;
    
    
    if(type == ALLORDERS){
        [self getData];
        _sortView.dateString = [self stringFromDate:[NSDate date] withState:NO];
        _sortView.tableString = @"Все";
        _sortView.waiterString = @"Все";
    } else if(type == ALLORDERSBYDATE){
        [_tableView setScrollEnabled:NO];
        [_datePicker setHidden:NO];

    } else if(type == ALLORDERSBYTABLE){
        sortState = type;
        [_pickerSort reloadAllComponents];
        [_tableView setScrollEnabled:NO];
        [_pickerSort setHidden:NO];

    } else if(type == ALLORDERSBYEMPLOYEE){
        sortState = type;
        [_pickerSort reloadAllComponents];
        [_tableView setScrollEnabled:NO];
        [_pickerSort setHidden:NO];
    }
    
}
- (void)closedatePicker:(BASSortView*)view{
    [_tableView setScrollEnabled:YES];
    [_datePicker setHidden:YES];
    [_pickerSort setHidden:YES];
}
- (void)closedatePicker:(BASSortView*)view withType:(SortState)type{
    [_tableView setScrollEnabled:YES];
    
    _sortView.dateString = @"Все";
    _sortView.tableString = @"Все";
    _sortView.waiterString = @"Все";
    if(type == ALLORDERSBYDATE){
        [_datePicker setHidden:YES];
        _sortView.dateString = [self stringFromDate:searchDate withState:NO];
    } else if(type == ALLORDERSBYTABLE){
        [_pickerSort setHidden:YES];
        _sortView.tableString = table;
    } else if(type == ALLORDERSBYEMPLOYEE){
        [_pickerSort setHidden:YES];
        _sortView.waiterString = waiter;
    }
     [self getSortData:type];
   
}
- (void)pickerChanged:(id)sender{
    NSLog(@"value: %@",[sender date]);
    searchDate = [sender date];
   
}
#pragma mark -
#pragma mark Table delegate methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == _tableView)
        return [_tableView hightCell:_tableView.typeTable];

    return [_contentTableView hightCell:_contentTableView.typeTable];
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TheApp;
    if(!app.isBusy){
        if(tableView == _tableView){
            [_pickeView removeFromSuperview];
            self.pickeView = nil;
            index = [indexPath row];
            NSDictionary* dict = (NSDictionary*)[_contentData objectAtIndex:[indexPath row]];
            NSNumber* id_order = (NSNumber*)[dict objectForKey:@"id_order"];
            [self getOrderList:id_order];
        }
    }
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.tableView){
        if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= self.tableView.contentSize.height - scrollView.frame.size.height/2) {
            if (!self.loadingData) {
                [self addSortDataFromServer];
                NSLog(@"%f , %f,  %f",scrollView.contentOffset.y,scrollView.frame.size.height , self.tableView.contentSize.height);
            }
        }
    }
}
#pragma mark -
#pragma mark UIPickerView  methods
- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    return  nil;
    
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(sortState == ALLORDERSBYTABLE)
        return _tablePickerList.count;
    
    return _waiterPickerList.count;
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{

    NSDictionary* dict = nil;
    
    if(sortState == ALLORDERSBYTABLE){
        dict = (NSDictionary*)[_tablePickerList objectAtIndex:row];
        NSNumber* number_table = (NSNumber*)[dict objectForKey:@"number_table"];
         return [NSString stringWithFormat:@"%d (%@)",[number_table intValue],(NSString*)[dict objectForKey:@"name_room"]];
    } else if(sortState == ALLORDERSBYEMPLOYEE){
        if(row < _waiterPickerList.count){
            dict = (NSDictionary*)[_waiterPickerList objectAtIndex:row];

            return [NSString stringWithFormat:@"%@",[dict objectForKey:@"surname"]];
        }
    }
    
    return  nil;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
     NSDictionary* dict = nil;
    if(sortState == ALLORDERSBYTABLE){
        dict = (NSDictionary*)[_tablePickerList objectAtIndex:row];
        table = [NSString stringWithFormat:@"%d (%d)",((NSNumber*)[dict objectForKey:@"number_table"]).integerValue,((NSNumber*)[dict objectForKey:@"id_room"]).integerValue];
        id_table = ((NSNumber*)[dict objectForKey:@"id_table"]).integerValue;
    } else if(sortState == ALLORDERSBYEMPLOYEE){
        dict = (NSDictionary*)[_waiterPickerList objectAtIndex:row];
        waiter = [NSString stringWithFormat:@"%@",[dict objectForKey:@"surname"]];
        id_waiter = ((NSNumber*)[dict objectForKey:@"id_employee"]).integerValue;
    }
}
#pragma mark -
#pragma mark Service  methods
- (NSString*)stringFromDate:(NSDate*)date withState:(BOOL)state{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    
    [format setDateFormat:@"dd.MM.yy"];
    if(state)
        [format setDateFormat:@"dd.MM.yyyy"];
    NSString *string = [format stringFromDate:date];
    NSLog(@"%@", string);
    return string;
}

@end
