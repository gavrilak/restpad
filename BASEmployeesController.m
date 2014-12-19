//
//  BASEmployeesController.m
//  RestrauntSystemPad
//
//  Created by Sergey Bekker on 20.07.14.
//  Copyright (c) 2014 BestAppStudio. All rights reserved.
//

#import "BASEmployeesController.h"
#import "BASCustomTableView.h"
#import "BASPickerView.h"

@interface BASEmployeesController (){
    NSInteger id_employee;
    BOOL isSelect;
    NSInteger curRowJob;
    NSInteger curComponentJob;
    NSInteger curRowState;
    NSInteger curComponentState;
}

@property (nonatomic,strong) UIImageView* headerView;
@property (nonatomic,strong) NSArray *contentData;
@property (nonatomic,strong) NSArray *jobData;
@property (nonatomic,strong) NSArray *statusData;
@property (nonatomic,strong) BASCustomTableView* tableView;
@property (nonatomic,strong) UIAlertView* alertView1;
@property (nonatomic,strong) UIAlertView* alertView2;
@property (nonatomic,strong) UIButton* nameButton;
@property (nonatomic,strong) UIButton* jobButton;
@property (nonatomic,strong) UIButton* statusButton;
@property (nonatomic,strong) BASPickerView* pickeView;
@property (nonatomic,strong) NSArray *content;
@end

@implementation BASEmployeesController

- (id)init
{
    self = [super init];
    if (self) {
        NSMutableArray* temp = [[NSMutableArray alloc]initWithCapacity:20];
         for(int i = 0; i < 12; i++){
         [temp addObject:[NSNull null]];
         }
         self.contentData = [NSArray arrayWithArray:temp];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
  
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_all.png"]]];
    [self setupBtnLogout];
    self.title = @"Персонал";
    isSelect = NO;
    
    curComponentJob = 0;
    curRowJob = 0;
    curComponentState= 0;
    curRowState = 0;
    
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    TheApp;
    [self.view addSubview:app.tabBar];
    [self getJobList];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    TheApp;
    [app.tabBar removeFromSuperview];
}
#pragma mark - Private methods
- (void)getJobList{
    BASManager* manager = [BASManager sharedInstance];
    
    [manager getData:[manager formatRequest:@"GETJOBLIST" withParam:nil] success:^(id responseObject) {
        
        if([responseObject isKindOfClass:[NSDictionary class]]){
            
            NSArray* param = (NSArray*)[responseObject objectForKey:@"param"];
            NSLog(@"Response: %@",param);
            NSDictionary* dict = nil;
            NSMutableArray* temp = [NSMutableArray new];
            if(param != nil && param.count > 0){
                dict = @{@"id_job":[NSNumber numberWithInt:-1],
                         @"name_job":[NSString stringWithFormat:@"Все"]
                         };

                [temp addObject:dict];
                [temp addObjectsFromArray:[NSArray arrayWithArray:param]];
                self.jobData = [NSArray arrayWithArray:temp];
            }
            [temp removeAllObjects];
            dict = @{@"status":[NSNumber numberWithInt:-1],
                     @"name":[NSString stringWithFormat:@"Все"]
                     };
            [temp addObject:dict];
            dict = @{@"status":[NSNumber numberWithInt:0],
                                   @"name":[NSString stringWithFormat:@"отсутствует"]
                                   };
            [temp addObject:dict];
            dict = @{@"status":[NSNumber numberWithInt:1],
                     @"name":[NSString stringWithFormat:@"на работе"]
                     };
            [temp addObject:dict];
            self.statusData = [NSArray arrayWithArray:temp];
            [self getData:nil];
        }
    
    } failure:^(NSString *error) {
        [manager showAlertViewWithMess:ERROR_MESSAGE];
    }];
    

}
- (void)getData:(NSDictionary*)obj{
  
    BASManager* manager = [BASManager sharedInstance];
 
    [manager getData:[manager formatRequest:@"GETEMPLOYEES" withParam:obj] success:^(id responseObject) {
        
        if([responseObject isKindOfClass:[NSDictionary class]]){
            
            NSArray* param = (NSArray*)[responseObject objectForKey:@"param"];
            NSLog(@"Response: %@",param);
            
            if(param != nil && param.count > 0){
              
                NSMutableArray* temp = [NSMutableArray new];
       
                if(param.count < 12){
                    [temp addObjectsFromArray:param];
                    for (int i = param.count; i < 12; i++) {
                        [temp addObject:[NSNull null]];
                    }
                    self.contentData = [NSArray arrayWithArray:temp];
                } else
                    self.contentData = [NSArray arrayWithArray:param];
                [self prepareView];
                
                
            }
            
        }
        
    } failure:^(NSString *error) {
        [manager showAlertViewWithMess:ERROR_MESSAGE];
    }];
}
- (void)setTime:(BOOL)state{
    BASManager* manager = [BASManager sharedInstance];
    
    NSString* command = @"SETCOMINGEMPLOYEE";
    if(state)
        command = @"SETLEAVINGEMPLOYEE";
    
    NSDictionary* param = [NSDictionary dictionaryWithObjectsAndKeys:
                           [NSNumber numberWithInteger:id_employee] ,@"id_employee",
                           nil];

    
    [manager getData:[manager formatRequest:command withParam:param] success:^(id responseObject) {
        
        if([responseObject isKindOfClass:[NSDictionary class]]){
            
            NSArray* param = (NSArray*)[responseObject objectForKey:@"param"];
            NSLog(@"Response: %@",param);
            
            if(param != nil && param.count > 0){
                NSMutableArray* temp = [NSMutableArray new];
                if(param.count < 12){
                    [temp addObjectsFromArray:param];
                    for (int i = param.count; i < 12; i++) {
                        [temp addObject:[NSNull null]];
                    }
                    self.contentData = [NSArray arrayWithArray:temp];
                } else
                    self.contentData = [NSArray arrayWithArray:param];
                [self prepareView];
            }
            
        }
        
    } failure:^(NSString *error) {
        [manager showAlertViewWithMess:ERROR_MESSAGE];
    }];

}
- (void)prepareView{
    
    TheApp;
    
    
    [_headerView removeFromSuperview];
    self.headerView = nil;
    
    UIImage * image = [UIImage imageNamed:@"title_staff.png"];
    self.headerView = [[UIImageView alloc]initWithImage:image];
    [_headerView setFrame:CGRectMake(1024.f / 2 - image.size.width / 2, 0, image.size.width, image.size.height)];
    [self.view addSubview:_headerView];
    
    [_nameButton removeFromSuperview];
    self.nameButton = nil;
    self.nameButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_nameButton setBackgroundColor:[UIColor clearColor]];
    [_nameButton setFrame:CGRectMake(_headerView.frame.origin.x, _headerView.frame.origin.y, 210.f, _headerView.frame.size.height)];
    [_nameButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_nameButton];
    
    [_jobButton removeFromSuperview];
    self.jobButton = nil;
    self.jobButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_jobButton setBackgroundColor:[UIColor clearColor]];
    [_jobButton setFrame:CGRectMake(_headerView.frame.origin.x + 211.f, _headerView.frame.origin.y, 193.f, _headerView.frame.size.height)];
    [_jobButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_jobButton];
    
    [_statusButton removeFromSuperview];
    self.statusButton = nil;
    self.statusButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_statusButton setBackgroundColor:[UIColor clearColor]];
    [_statusButton setFrame:CGRectMake(_headerView.frame.origin.x + 404.f, _headerView.frame.origin.y, 207.f, _headerView.frame.size.height)];
    [_statusButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_statusButton];

    [_tableView removeFromSuperview];
    self.tableView = nil;
    
    CGRect frame = _headerView.frame;
    frame.origin.x += 3.f;
    frame.origin.y = _headerView.frame.size.height - 5.f;
    frame.size.width -= 6.f;
    frame.size.height = 768.f - app.tabBar.frame.size.height - 139.f;
    
    self.tableView = [[BASCustomTableView alloc]initWithFrame:frame style:UITableViewStylePlain withContent:_contentData withType:EMPLOYEER withDelegate:self];
    _tableView.delegate = (id)self;
    [_tableView setBounces:NO];
    [_tableView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:_tableView];

}
- (void)buttonClicked:(id)sender{
    
    UIButton* button = (UIButton*)sender;
    
    if(isSelect){
        [_pickeView removeFromSuperview];
        self.pickeView = nil;
    } else {
        NSMutableArray* result = [NSMutableArray new];
        NSMutableArray* temp = [NSMutableArray new];
       
        if(button == _nameButton){
            curComponentJob = 0;
            curRowJob = 0;
            curComponentState= 0;
            curRowState = 0;
            [self getData:nil];
        } else if(button == _jobButton){
            for (NSDictionary* obj in _jobData) {
                [temp addObject:(NSString*)[obj objectForKey:@"name_job"]];
            }
            [result addObject:temp];
            _content = _jobData;
            
            
            self.pickeView = [[BASPickerView alloc]initWithFrame:CGRectMake(_jobButton.frame.origin.x +1.f, _jobButton.frame.size.height - 5.f, _jobButton.frame.size.width - 1.f, 180.f) withContent:[NSArray arrayWithArray:result] withDoneButton:NO];
            self.pickeView.delegate = (id) self;
            [self.pickeView selectRow:curRowJob inComponent:curComponentJob];
            [self.view addSubview:_pickeView];
            [self.view bringSubviewToFront:_pickeView];
      
        } else if(button == _statusButton){
            for (NSDictionary* obj in _statusData) {
                [temp addObject:(NSString*)[obj objectForKey:@"name"]];
            }
            [result addObject:temp];
            _content = _statusData;
            
        
            self.pickeView = [[BASPickerView alloc]initWithFrame:CGRectMake(_statusButton.frame.origin.x, _statusButton.frame.size.height - 5.f, _statusButton.frame.size.width - 1.f, 180.f) withContent:[NSArray arrayWithArray:result] withDoneButton:NO];
            self.pickeView.delegate = (id) self;
            [self.pickeView selectRow:curRowState inComponent:curComponentState];
            [self.view addSubview:_pickeView];
            [self.view bringSubviewToFront:_pickeView];
           
        }
    }
    isSelect = !isSelect;
}
#pragma mark - BASPickerView delegate methods
- (void)didSelect:(BASPickerView*)view withRow:(NSInteger)row withComponent:(NSInteger)component{
    [_pickeView removeFromSuperview];
    self.pickeView = nil;
    isSelect = NO;
    NSDictionary* dict = nil;
    
    if(_content == _jobData){
        curRowJob = row;
        curComponentJob = component;
        dict = (NSDictionary*)[_jobData objectAtIndex:row];
        NSNumber* id_job = (NSNumber*)[dict objectForKey:@"id_job"];
        if([id_job integerValue] == -1){
           [self getData:nil];
            return;
        }
        else
            dict = @{@"id_job": [dict objectForKey:@"id_job"]
                             };
        
    } else {
        curRowState = row;
        curComponentState = component;
        dict = (NSDictionary*)[_statusData objectAtIndex:row];
        NSNumber* status = (NSNumber*)[dict objectForKey:@"status"];
        if([status integerValue] == -1){
            [self getData:nil];
             return;
        }
        else
            dict = @{@"status": [dict objectForKey:@"status"]
                 };
    }
    [self getData:dict];
}
#pragma mark - Table delegate methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat hight = [_tableView hightCell:_tableView.typeTable];
    
    return hight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}
#pragma mark - BASEmployeeTableViewCell delegate methods
- (void)clickedStartTime:(NSUInteger)index{
    
    id_employee = index;
    self.alertView1 = [[UIAlertView alloc]initWithTitle:@"Сообщение" message:@"Хотите установить время?" delegate:self cancelButtonTitle:@"Да" otherButtonTitles:@"Нет", nil];
    
    [_alertView1 show];
}
- (void)clickedFinishTime:(NSUInteger)index{
    id_employee = index;
    self.alertView2 = [[UIAlertView alloc]initWithTitle:@"Сообщение" message:@"Хотите установить время?" delegate:self cancelButtonTitle:@"Да" otherButtonTitles:@"Нет", nil];
    
    [_alertView2 show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView == _alertView1){
        if(alertView.cancelButtonIndex == buttonIndex){
            [self setTime:NO];
        }
    } else {
        if(alertView.cancelButtonIndex == buttonIndex){
            [self setTime:YES];
        }
    }
}
@end
