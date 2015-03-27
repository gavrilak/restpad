//
//  BASStatisticViewController.m
//  RestrauntSystemPad
//
//  Created by Sergey on 31.07.14.
//  Copyright (c) 2014 BestAppStudio. All rights reserved.
//

#import "BASStatisticViewController.h"
#import "BASBaseSatatisticView.h"

@interface BASStatisticViewController ()

@property (nonatomic,strong) UITableView* mainTableView;
@property (nonatomic,assign) StatisticsType type;
@property (nonatomic,strong) BASBaseSatatisticView* statView;
@property (nonatomic,strong) NSDictionary* contentData;
@property (nonatomic,strong) UIImageView *separatorView;
@property (nonatomic, strong) UIScrollView *scrollview;
@end

@implementation BASStatisticViewController

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
    [self setupBtnLogout];

    self.scrollview = [[UIScrollView alloc] init];
    _scrollview.showsHorizontalScrollIndicator = NO;
    _scrollview.showsHorizontalScrollIndicator = NO;
    [_scrollview setBounces:NO];
    [_scrollview setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview: _scrollview];


    self.separatorView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"delimiter_long.png"]];
    [_scrollview addSubview:_separatorView];
    
    
    
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectNull style:UITableViewStyleGrouped];
    _mainTableView.delegate = (id)self;
    _mainTableView.dataSource = (id)self;
    _mainTableView.backgroundColor = [UIColor clearColor];
    [_mainTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_mainTableView setShowsHorizontalScrollIndicator:NO];
    [_mainTableView setShowsVerticalScrollIndicator:NO];
    [_mainTableView setScrollEnabled:NO];
    [_scrollview addSubview:_mainTableView];
    [_mainTableView reloadData];
    [_mainTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
    
    self.type = sales_rankings;
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    TheApp;
    [self.view addSubview:app.tabBar];
    self.title = @"Статистика";
    UIImage *image = [UIImage imageNamed:@"button_customer_rating"];
    [_mainTableView setFrame:CGRectMake(2.f, 0, image.size.width - 4.f, 768.f - self.navigationController.navigationBar.frame.size.height - 76.f)];
    [_separatorView setFrame:CGRectMake(_mainTableView.frame.size.width + 6.f, 0, 2.f, 768.f - self.navigationController.navigationBar.frame.size.height - 76.f)];
    
    [_scrollview setFrame:CGRectMake(0,0,self.view.bounds.size.width, self.view.bounds.size.height)];
    
    
    [self getData];
    

    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];

}
- (void)getData{

    BASManager* manager = [BASManager sharedInstance];
    
    NSString* command = nil;
    NSDictionary* param = nil;
    NSDate * date = [NSDate date];
    NSDate *previous = [NSDate dateWithTimeIntervalSinceNow: -(60.0f*60.0f*48.0f)];
    
    if(_type == sales_rankings){
        command = @"GETSALESRANKINGS";
        param = @{@"date_from":[NSString stringWithFormat:@"%@",[self stringFromDate:previous withState:YES]],
                  @"date_to":[NSString stringWithFormat:@"%@",[self stringFromDate:date withState:YES]],
                  @"count":[NSNumber numberWithInt:-1]
                      };
    } else if(_type == consumption_of_food){
        command = @"GETSALESRANKINGS";
        param = @{@"date_from":[NSString stringWithFormat:@"%@",[self stringFromDate:previous withState:YES]],
                  @"date_to":[NSString stringWithFormat:@"%@",[self stringFromDate:date withState:YES]],
                  @"id_category":[NSNumber numberWithInt:-1],
                  @"id_dish":[NSNumber numberWithInt:-1],
                  };
    } else if(_type == revenue){
        command = @"GETPROCEEDSTATISTIC";
        param = @{@"date_from":[NSString stringWithFormat:@"%@",[self stringFromDate:previous withState:YES]],
                  @"date_to":[NSString stringWithFormat:@"%@",[self stringFromDate:date withState:YES]],
                  };
    } else if(_type == list_of_staff){
        command = @"GETEMPLOYEES";
        param = @{@"date_from":[NSString stringWithFormat:@"%@",[self stringFromDate:date withState:YES]],
                  @"date_to":[NSString stringWithFormat:@"%@",[self stringFromDate:date withState:YES]],
                  @"id_job":[NSNumber numberWithInt:-1],
                  @"id_employee":[NSNumber numberWithInt:-1],
                  };
    }else if(_type == salary){
        command = @"GETEMPLOYEES";
        param = @{@"date_from":[NSString stringWithFormat:@"%@",[self stringFromDate:previous withState:YES]],
                  @"date_to":[NSString stringWithFormat:@"%@",[self stringFromDate:date withState:YES]],
                  @"id_job":[NSNumber numberWithInt:-1],
                  @"id_employee":[NSNumber numberWithInt:-1]
                  };
   /* }else if(_type ==  customer_rating ){
        previous = [NSDate dateWithTimeIntervalSinceNow: -(60.0f*60.0f*720.f)];
        command = @"GETCLIENTSRANKINGS";
        param = @{@"date_from":[NSString stringWithFormat:@"%@",[self stringFromDate:previous withState:YES]],
                  @"date_to":[NSString stringWithFormat:@"%@",[self stringFromDate:date withState:YES]]
                  };
    }else if(_type ==  movement_of_customers ){
        previous = [NSDate dateWithTimeIntervalSinceNow: -(60.0f*60.0f*720.f)];
        command = @"GETCLIENTSFLOWS";
        param = @{@"date_from":[NSString stringWithFormat:@"%@",[self stringFromDate:previous withState:YES]],
                  @"date_to":[NSString stringWithFormat:@"%@",[self stringFromDate:date withState:YES]],
                  @"id_client":[NSNumber numberWithInt:-1]
                  };*/
        
    }else if(_type == infograph){
        previous = [NSDate dateWithTimeIntervalSinceNow: -(60.0f*60.0f*336.f)];
        command = @"GETINFOGRAPHICS";
        param = @{@"date_from":[NSString stringWithFormat:@"%@",[self stringFromDate:previous withState:YES]],
                  @"date_to":[NSString stringWithFormat:@"%@",[self stringFromDate:date withState:YES]],
                  @"filter":[NSNumber numberWithInt:0],
                  };

    }
    
    [manager getData:[manager formatRequest:command withParam:param] success:^(id responseObject) {
        
        NSLog(@"Response: %@",responseObject);
        NSArray* param = (NSArray*)[responseObject objectForKey:@"param"];
        NSDictionary* dict = (NSDictionary*)[param objectAtIndex:0];
        param = (NSArray*)[dict objectForKey:@"items"];
        
        if(param != nil){
            self.contentData = [NSDictionary dictionaryWithDictionary:dict];
            [self prepareView];
            

        }
    } failure:^(NSString *error) {
        [manager showAlertViewWithMess:ERROR_MESSAGE];
    }];
}
- (void)prepareView{
    
    
    [_statView removeFromSuperview];
    _statView = nil;
    self.statView = [[BASBaseSatatisticView alloc]initWithFrame:CGRectMake(_mainTableView.frame.size.width + 15.f, 0, 1024.f - _mainTableView.frame.size.width - 4.f, 768.f - self.navigationController.navigationBar.frame.size.height - 76.f) withContent:_contentData withParrent:self withType:_type];
    [_scrollview addSubview:_statView];
    [_scrollview setContentSize:CGSizeMake(_scrollview.frame.size.width, _scrollview.frame.size.height)];
    if(_type == revenue || _type == salary){
        [_scrollview setContentSize:CGSizeMake(_scrollview.frame.size.width + 20.f, _scrollview.frame.size.height)];
    }
   
    
}
#pragma mark - UITableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)theTableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)section
{
    if(theTableView == _mainTableView){
        if(section == 0)
            return 5;
        return 3;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"StatCell";
    
    
    UITableViewCell *cell = (UITableViewCell *)[theTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    UIImage* image = nil;
    UIImage* imageSelect = nil;
    if(theTableView == _mainTableView){
        if(indexPath.section == 0){
            switch (indexPath.row) {
                case 0:{
                    image = [UIImage imageNamed:@"button_sales_rankings"];
                    imageSelect = [UIImage imageNamed:@"button_sales_rankings_s"];
                }
                    break;
                case 1:{
                    image = [UIImage imageNamed:@"button_consumption_of_food"];
                    imageSelect = [UIImage imageNamed:@"button_consumption_of_food_s"];
                }
                    break;
                case 2:{
                    image = [UIImage imageNamed:@"button_revenue"];
                    imageSelect = [UIImage imageNamed:@"button_revenue_s"];
                }
                    break;
                case 3:{
                    image = [UIImage imageNamed:@"button_list_of_staff"];
                    imageSelect = [UIImage imageNamed:@"button_list_of_staff_s"];
                }
                    break;
                case 4:{
                    image = [UIImage imageNamed:@"button_salary"];
                    imageSelect = [UIImage imageNamed:@"button_salary_s"];
                }
                    break;
                    
                default:
                    break;
            }
        } else {
            switch (indexPath.row) {
                case 0:{
                    image = [UIImage imageNamed:@"button_customer_rating"];
                    imageSelect = [UIImage imageNamed:@"button_customer_rating_s"];
                }
                    break;
                case 1:{
                    image = [UIImage imageNamed:@"button_movement_of_customers"];
                    imageSelect = [UIImage imageNamed:@"button_movement_of_customers_s"];
                }
                    break;
                case 2:{
                    image = [UIImage imageNamed:@"button_infographics"];
                    imageSelect = [UIImage imageNamed:@"button_infographics_s"];
                }
                    break;
                    
                default:
                    break;
            }
        }
        UIView* normalView = [[UIView alloc]initWithFrame:cell.frame];
        [normalView setBackgroundColor:[UIColor colorWithPatternImage:image]];
        
        UIView* selectView = [[UIView alloc]initWithFrame:cell.frame];
        [selectView setBackgroundColor:[UIColor colorWithPatternImage:imageSelect]];
        
        [cell setBackgroundView:normalView];
        [cell setSelectedBackgroundView:selectView];
    }
   

    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)theTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UIImage *image = nil;
    if(theTableView == _mainTableView){
        image = [UIImage imageNamed:@"button_customer_rating"];
        return image.size.height;
    } else {
        return [self cellHightWithType];
    }
    
    return [theTableView rowHeight];
    
}
- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if(theTableView == _mainTableView){
        [_statView removeFromSuperview];
        _statView = nil;
        if(indexPath.section == 0){
            self.type = (StatisticsType)indexPath.row;
            [self getData];
        } else {
            self.type = (StatisticsType)indexPath.row + 5;
            [self getData];
        }
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
- (CGFloat)cellHightWithType{
    UIImage* image= nil;
    if(_type == sales_rankings){
        image = [UIImage imageNamed:@"BgS1"];
    } else if(_type == consumption_of_food){
        image = [UIImage imageNamed:@"BgS2"];
    } else if(_type == revenue){
        image = [UIImage imageNamed:@"BgS3"];
    } else if(_type == list_of_staff){
        image = [UIImage imageNamed:@"BgS4"];
    }else if(_type == salary){
        image = [UIImage imageNamed:@"BgS5"];
    }
    return  image.size.height;
}
- (CGFloat)widthWithType{
    UIImage* image= nil;
    if(_type == sales_rankings){
        image = [UIImage imageNamed:@"hd_selling_rating"];
    } else if(_type == consumption_of_food){
        image = [UIImage imageNamed:@"hd_food_consumption"];
    } else if(_type == revenue){
        image = [UIImage imageNamed:@"hd_revenue"];
    } else if(_type == list_of_staff){
        image = [UIImage imageNamed:@"hd_list_of_staff"];
    }else if(_type == salary){
        image = [UIImage imageNamed:@"hd_salary"];
    }
    return  image.size.width;
}
@end
