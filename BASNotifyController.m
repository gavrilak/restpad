//
//  BASNotifyController.m
//  RestrauntSystemPad
//
//  Created by Sergey Bekker on 20.07.14.
//  Copyright (c) 2014 BestAppStudio. All rights reserved.
//

#import "BASNotifyController.h"
#import "BASCustomTableView.h"

@interface BASNotifyController ()

@property (nonatomic,strong) NSArray *contentData;
@property (nonatomic,strong) BASCustomTableView* tableView;
@property (nonatomic,strong) UIImageView *bgView;

@end

@implementation BASNotifyController

- (id)init
{
    self = [super init];
    if (self) {
        
        
        NSMutableArray *temp = [NSMutableArray new];
        
        NSDictionary* dict = [NSDictionary dictionaryWithObjectsAndKeys:
                              @"А ну быстро работать",@"message",
                              [NSNumber numberWithInt:NoticeStateUnfulfilled],@"message_status",
                              [NSNumber numberWithInt:NoticeTypeAdmin],@"message_type",
                              nil];
        
        [temp addObject:dict];
        
        dict = [NSDictionary dictionaryWithObjectsAndKeys:
                @"Это просто пипец",@"message",
                [NSNumber numberWithInt:NoticeStateUnfulfilled],@"message_status",
                [NSNumber numberWithInt:NoticeTypeKitchen],@"message_type",
                nil];
        
        [temp addObject:dict];
        
        dict = [NSDictionary dictionaryWithObjectsAndKeys:
                @"Бухают сегодня круто",@"message",
                [NSNumber numberWithInt:NoticeStateUnfulfilled],@"message_status",
                [NSNumber numberWithInt:NoticeTypeBar],@"message_type",
                nil];
        
        [temp addObject:dict];
        
        
        self.contentData = [NSArray arrayWithArray:temp];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_all.png"]]];
    [self setupBtnLogout];
    self.title = @"Уведомления";
    
    UIImage* image = [[UIImage imageNamed:@"notice_bg.png"]stretchableImageWithLeftCapWidth:15.f topCapHeight:15.f];
    self.bgView = [[UIImageView alloc]initWithImage:image];
    [_bgView setFrame:CGRectMake(20.f, 20.f, 984.f, 600.f)];
    [self.view addSubview: _bgView];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    TheApp;
    [self.view addSubview:app.tabBar];
    [self getData];
    //[self prepareView];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    TheApp;
    [app.tabBar removeFromSuperview];
}
- (void)updateNotifyData{
    [self getData];
}
#pragma mark - Private methods

- (void)getData{
    
    TheApp;
    
    BASManager* manager = [BASManager sharedInstance];

    
    
    [manager getData:[manager formatRequest:[Settings text:TextForApiFuncGetNotifies] withParam:nil] success:^(id responseObject) {

        if([responseObject isKindOfClass:[NSDictionary class]]){
   
            NSArray* param = (NSArray*)[responseObject objectForKey:@"param"];
            NSLog(@"Response: %@",param);
            
            if(param != nil && param.count > 0){
                self.contentData = [NSArray arrayWithArray:param];
                [self prepareView];
            }

        }
  
    } failure:^(NSString *error) {
        [manager showAlertViewWithMess:ERROR_MESSAGE];
    }];
}

- (void)prepareView{
    
    [_tableView removeFromSuperview];
    self.tableView = nil;


    self.tableView = [[BASCustomTableView alloc]initWithFrame:_bgView.frame style:UITableViewStylePlain withContent:_contentData withType:NOTICETABLE withDelegate:nil];
    _tableView.delegate = (id)self;
    [_tableView setBackgroundColor:[UIColor clearColor]];
    UIView* headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _bgView.frame.size.width, 10.f)];
    [headerView setBackgroundColor:[UIColor clearColor]];
    [_tableView setTableHeaderView:headerView];
    
    [self.view addSubview:_tableView];
    
    
}


#pragma mark - Table delegate methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat hight = [_tableView hightCell:_tableView.typeTable];
    
    return hight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 
    
}

@end
