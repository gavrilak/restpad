//
//  BASSalesrankingsView.m
//  RestrauntSystemPad
//
//  Created by Sergey on 03.11.14.
//  Copyright (c) 2014 BestAppStudio. All rights reserved.
//

#import "BASBaseSatatisticView.h"
#import "BASStatisticsCell.h"
#import "BASStatisticViewController.h"
#import "BASInfographView.h"

@interface BASBaseSatatisticView(){
    NSDate* fromDate;
    NSDate* toDate;
    NSInteger countList;
    NSNumber* valueAdd1;
    NSNumber* valueAdd2;
    BOOL isFromPicker;
    BOOL isToPicker;
    BOOL isAdd1;
    BOOL isAdd2;
    CGFloat orignY;
}
@property (nonatomic,strong) NSDictionary* globalData;
@property (nonatomic,strong) NSDictionary* contentData;
@property (nonatomic,strong) BASStatisticViewController* parent;
@property (nonatomic,strong) UITableView* mainTableView;
@property (nonatomic,assign) StatisticsType type;
@property (nonatomic,strong) UIDatePicker *datePickerFrom;
@property (nonatomic,strong) UIDatePicker *datePickerTo;
@property (nonatomic,strong) UIPickerView *pickerSort;
@property (nonatomic,strong) UILabel* costLabel;
@property (nonatomic,strong) UILabel* dataFromLabel;
@property (nonatomic,strong) UILabel* dataToLabel;
@property (nonatomic,strong) UILabel* searchLabel;
@property (nonatomic,strong) UILabel* add1Label;
@property (nonatomic,strong) UILabel* add2Label;
@property (nonatomic,strong) UILabel* countLabel;
@property (nonatomic,strong) UIButton* dataFromButton;
@property (nonatomic,strong) UIButton* dataToButton;
@property (nonatomic,strong) UIButton* add1Button;
@property (nonatomic,strong) UIButton* add2Button;
@property (nonatomic,strong) UIPickerView *picker1Add;
@property (nonatomic,strong) UIPickerView *picker2Add;
@property (nonatomic,strong) NSArray* totalRevenue;
@property (nonatomic,strong) NSArray* filterData;
@property (nonatomic, strong) UIScrollView *scrollview;
@end

@implementation BASBaseSatatisticView

- (id)initWithFrame:(CGRect)frame withContent:(NSDictionary*)content withParrent:(BASBaseController*)obj withType:(StatisticsType)statType{
    TheApp;
    self = [super initWithFrame:frame];
    if(self){
        [self setBackgroundColor:[UIColor clearColor]];
        
        self.globalData = [NSDictionary dictionaryWithDictionary:content];
        self.contentData = [NSDictionary dictionaryWithDictionary:content];
        self.parent = (BASStatisticViewController*)obj;
        self.type = statType;
        NSDate * date = [NSDate date];
        toDate = date;
        NSDate *previous = [NSDate dateWithTimeIntervalSinceNow: -(60.0f*60.0f*48.0f)];
        if(_type == infograph)
            previous = [NSDate dateWithTimeIntervalSinceNow: -(60.0f*60.0f*336.f)];
        fromDate = previous;
        orignY = frame.size.height;
        isFromPicker = isToPicker = isAdd1 =  isAdd2 = YES;
        UIImage* image = nil;
       
       
    
        ////////////////////////////////
        
        image = [UIImage imageNamed:@"cell"];
        self.dataFromLabel = [[UILabel alloc]init];
        [_dataFromLabel setBackgroundColor:[UIColor clearColor]];
        _dataFromLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14.f];
        _dataFromLabel.textColor = [UIColor blackColor];
        _dataFromLabel.textAlignment = NSTextAlignmentCenter;
        _dataFromLabel.tag = 112;
        [_dataFromLabel setText:[_parent stringFromDate:previous withState:YES]];
        [_dataFromLabel setFrame:CGRectMake(0, 10.f, image.size.width, image.size.height)];
        [_dataFromLabel setBackgroundColor:[UIColor colorWithPatternImage:image]];

        
        self.dataFromButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_dataFromButton setBackgroundColor:[UIColor clearColor]];
        [_dataFromButton addTarget:self action:@selector(fromTap:) forControlEvents:UIControlEventTouchUpInside];
        [_dataFromButton setFrame:_dataFromLabel.frame];

        
        self.datePickerFrom = [[UIDatePicker alloc] initWithFrame:CGRectMake(_dataFromLabel.frame.origin.x - 50.f, _dataFromLabel.frame.origin.y + _dataFromLabel.frame.size.height, _dataFromLabel.frame.size.width + 100.f, 150.f)];
        [_datePickerFrom addTarget:self action:@selector(pickerChanged:)forControlEvents:UIControlEventValueChanged];
        _datePickerFrom.datePickerMode = UIDatePickerModeDate;
        [_datePickerFrom setDate:previous];
        _datePickerFrom.backgroundColor = [UIColor whiteColor];
        [_datePickerFrom setHidden:isFromPicker];

        
        //////////////////////////
        
        self.dataToLabel = [[UILabel alloc]init];
        [_dataToLabel setBackgroundColor:[UIColor clearColor]];
        _dataToLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14.f];
        _dataToLabel.textColor = [UIColor blackColor];
        _dataToLabel.textAlignment = NSTextAlignmentCenter;
        [_dataToLabel setText:[_parent stringFromDate:date withState:YES]];
        [_dataToLabel setFrame:CGRectMake(_dataFromLabel.frame.origin.x + _dataFromLabel.frame.size.width + 20.f, 10.f, image.size.width, image.size.height)];
        [_dataToLabel setBackgroundColor:[UIColor colorWithPatternImage:image]];
  
        
        self.dataToButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_dataToButton setBackgroundColor:[UIColor clearColor]];
        [_dataToButton addTarget:self action:@selector(toTap:) forControlEvents:UIControlEventTouchUpInside];
        [_dataToButton setFrame:_dataToLabel.frame];

        
        
        self.datePickerTo = [[UIDatePicker alloc] initWithFrame:CGRectMake(_dataToLabel.frame.origin.x - 50.f, _dataToLabel.frame.origin.y + _dataToLabel.frame.size.height, _dataToLabel.frame.size.width + 100.f, 150.f)];
        [_datePickerTo addTarget:self action:@selector(pickerChanged:)forControlEvents:UIControlEventValueChanged];
        _datePickerTo.datePickerMode = UIDatePickerModeDate;
        [_datePickerTo setDate:date];
        _datePickerTo.backgroundColor = [UIColor whiteColor];
        [_datePickerTo setHidden:isFromPicker];
        
        ///////////////////////
        image = [UIImage imageNamed:@"cell"];
        self.add1Label = [[UILabel alloc]init];
        [_add1Label setBackgroundColor:[UIColor clearColor]];
        _add1Label.font = [UIFont fontWithName:@"Helvetica-Bold" size:14.f];
        _add1Label.textColor = [UIColor blackColor];
        _add1Label.textAlignment = NSTextAlignmentCenter;
        [_add1Label setFrame:CGRectMake(_dataFromLabel.frame.origin.x,  10.f, image.size.width, image.size.height)];
        [_add1Label setBackgroundColor:[UIColor colorWithPatternImage:[image stretchableImageWithLeftCapWidth:10.f topCapHeight:0]]];

        
        self.add1Button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_add1Button setBackgroundColor:[UIColor clearColor]];
        [_add1Button addTarget:self action:@selector(add1Tap:) forControlEvents:UIControlEventTouchUpInside];
        
 
        
        
        self.picker1Add = [[UIPickerView alloc]initWithFrame:CGRectMake(_add1Label.frame.origin.x - 25.f, _add1Label.frame.origin.y + _add1Label.frame.size.height, _add1Label.frame.size.width + 50.f, 150.f)];
        self.picker1Add.dataSource = (id)self;
        self.picker1Add.delegate = (id)self;
        _picker1Add.backgroundColor = [UIColor whiteColor];
        [self.picker1Add setUserInteractionEnabled:YES];
        [_picker1Add setHidden:isAdd1];

        
        ///////////////////////
        image = [UIImage imageNamed:@"cell"];
        self.add2Label = [[UILabel alloc]init];
        [_add2Label setBackgroundColor:[UIColor clearColor]];
        _add2Label.font = [UIFont fontWithName:@"Helvetica-Bold" size:14.f];
        _add2Label.textColor = [UIColor blackColor];
        _add2Label.textAlignment = NSTextAlignmentCenter;
        [_add2Label setFrame:CGRectMake(_dataToLabel.frame.origin.x, 10.f, image.size.width, image.size.height)];
        [_add2Label setBackgroundColor:[UIColor colorWithPatternImage:[image stretchableImageWithLeftCapWidth:10.f topCapHeight:0]]];

        
        self.add2Button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_add2Button setBackgroundColor:[UIColor clearColor]];
        [_add2Button addTarget:self action:@selector(add2Tap:) forControlEvents:UIControlEventTouchUpInside];
 
        
        
        self.picker2Add = [[UIPickerView alloc]initWithFrame:CGRectMake((_add2Label.frame.origin.x + _add2Label.frame.size.width) / 2 - 70.f, _add2Label.frame.origin.y + _add1Label.frame.size.height, _add2Label.frame.size.width + 150.f, 150.f)];
        self.picker2Add.dataSource = (id)self;
        self.picker2Add.delegate = (id)self;
        _picker2Add.backgroundColor = [UIColor whiteColor];
        [self.pickerSort setUserInteractionEnabled:YES];
        [_picker2Add setHidden:isAdd2];

        
        
        
        if(_type == sales_rankings){
 
            [self addSubview:_dataFromLabel];
            [self addSubview:_dataFromButton];

            [self addSubview:_dataToLabel];
            [self addSubview:_dataToButton];

            [self addSubview:_add1Label];
            [self addSubview:_add1Button];
            
            [self addSubview:_datePickerFrom];
            [self addSubview:_datePickerTo];
            [self addSubview:_picker1Add];
       
            NSArray* param = (NSArray*)[_globalData objectForKey:@"items"];
            [_add1Label setText:[NSString stringWithFormat:@"№ %d",(int)param.count]];
            countList = param.count;
            [_add1Label setFrame:CGRectMake(_dataToLabel.frame.origin.x + _dataToLabel.frame.size.width + 20.f, 10.f, image.size.width, image.size.height)];
            [_add1Button setFrame:_add1Label.frame];
            [self.picker1Add setFrame:CGRectMake(_add1Label.frame.origin.x, _add1Label.frame.origin.y + _add1Label.frame.size.height, _add1Label.frame.size.width, 150.f)];
            
            orignY = _dataToLabel.frame.origin.y + _dataToLabel.frame.size.height + 10.f;
            
        } else if(_type == consumption_of_food){
           
            [self addSubview:_dataFromLabel];
            [self addSubview:_dataFromButton];
            
            
            [self addSubview:_dataToLabel];
            [self addSubview:_dataToButton];
            
            
            [self addSubview:_add1Label];
            [self addSubview:_add1Button];
            
            
            [self addSubview:_add2Label];
            [self addSubview:_add2Button];
           
            
            [self addSubview:_datePickerFrom];
            [self addSubview:_datePickerTo];
            [self addSubview:_picker1Add];
            [self addSubview:_picker2Add];
            
       
          
            NSDictionary* dict = (NSDictionary*)[app.menuList objectAtIndex:0];
            [_add1Label setText:(NSString*)[dict objectForKey:@"name_category"]];
            valueAdd1 = (NSNumber*)[dict objectForKey:@"id_category"];
            [_add1Label setFrame:CGRectMake(_dataFromLabel.frame.origin.x, _dataFromLabel.frame.origin.y + _dataFromLabel.frame.size.height + 10.f, image.size.width, image.size.height)];
            [_add1Button setFrame:_add1Label.frame];
    
            [self.picker1Add setFrame:CGRectMake(_add1Label.frame.origin.x - 25.f, _add1Label.frame.origin.y + _add1Label.frame.size.height, _add1Label.frame.size.width + 50.f, 150.f)];
            
            
        
            dict = (NSDictionary*)[app.dishesList objectAtIndex:0];
            [_add2Label setText:(NSString*)[dict objectForKey:@"name_dish"]];
             valueAdd2 = (NSNumber*)[dict objectForKey:@"id_dish"];
            [_add2Label setFrame:CGRectMake(_dataToLabel.frame.origin.x, _dataToLabel.frame.origin.y + _dataToLabel.frame.size.height + 10.f, image.size.width, image.size.height)];
            [_add2Button setFrame:_add2Label.frame];
            
            [self.picker2Add setFrame:CGRectMake((_add2Label.frame.origin.x + _add2Label.frame.size.width) / 2 - 70.f, _add2Label.frame.origin.y + _add2Label.frame.size.height, _add2Label.frame.size.width + 150.f, 150.f)];
            

          
            orignY = _add1Label.frame.origin.y + _add1Label.frame.size.height + 10.f;
        } else if(_type == revenue){
            [self addSubview:_dataFromLabel];
            [self addSubview:_dataFromButton];

            [self addSubview:_dataToLabel];
            [self addSubview:_dataToButton];
            [self addSubview:_datePickerFrom];
            [self addSubview:_datePickerTo];

            orignY = _dataToLabel.frame.origin.y + _dataToLabel.frame.size.height + 10.f;
        } else if(_type == list_of_staff){
            [self addSubview:_dataFromLabel];
            [self addSubview:_dataFromButton];
            
            [self addSubview:_add1Label];
            [self addSubview:_add1Button];
            
            [self addSubview:_add2Label];
            [self addSubview:_add2Button];
            
            [self addSubview:_datePickerFrom];
            [self addSubview:_picker1Add];
            [self addSubview:_picker2Add];
            
            NSDictionary* dict = (NSDictionary*)[app.jobsList objectAtIndex:0];
            [_add1Label setText:(NSString*)[dict objectForKey:@"name_job"]];
            valueAdd1 = (NSNumber*)[dict objectForKey:@"id_job"];
            [_add1Label setFrame:CGRectMake(_dataFromLabel.frame.origin.x + _dataFromLabel.frame.size.width + 20.f, 10.f, image.size.width, image.size.height)];
            [_add1Button setFrame:_add1Label.frame];
            
            [self.picker1Add setFrame:CGRectMake(_add1Label.frame.origin.x - 25.f, _add1Label.frame.origin.y + _add1Label.frame.size.height, _add1Label.frame.size.width + 50.f, 150.f)];
            
            dict = (NSDictionary*)[app.employeesList objectAtIndex:0];
            [_add2Label setText:(NSString*)[dict objectForKey:@"name"]];
            valueAdd2 = (NSNumber*)[dict objectForKey:@"id_employee"];
            [_add2Label setFrame:CGRectMake(_add1Label.frame.origin.x + _add1Label.frame.size.width + 20.f,  10.f, image.size.width, image.size.height)];
            [_add2Button setFrame:_add2Label.frame];
            
            [self.picker2Add setFrame:CGRectMake(_add2Label.frame.origin.x - 25.f, _add2Label.frame.origin.y + _add2Label.frame.size.height, _add2Label.frame.size.width + 50.f, 150.f)];
            
            orignY = _dataToLabel.frame.origin.y + _dataToLabel.frame.size.height + 10.f;

        } else if(_type == salary){
            [self addSubview:_dataFromLabel];
            [self addSubview:_dataFromButton];
            
            
            [self addSubview:_dataToLabel];
            [self addSubview:_dataToButton];
            
            
            [self addSubview:_add1Label];
            [self addSubview:_add1Button];
            
            
            [self addSubview:_add2Label];
            [self addSubview:_add2Button];
            
            
            [self addSubview:_datePickerFrom];
            [self addSubview:_datePickerTo];
            [self addSubview:_picker1Add];
            [self addSubview:_picker2Add];
            
            
            
            NSDictionary* dict = (NSDictionary*)[app.jobsList objectAtIndex:0];
            [_add1Label setText:(NSString*)[dict objectForKey:@"name_job"]];
            valueAdd1 = (NSNumber*)[dict objectForKey:@"id_job"];
            [_add1Label setFrame:CGRectMake(_dataFromLabel.frame.origin.x, _dataFromLabel.frame.origin.y + _dataFromLabel.frame.size.height + 10.f, image.size.width, image.size.height)];
            [_add1Button setFrame:_add1Label.frame];
            
            [self.picker1Add setFrame:CGRectMake(_add1Label.frame.origin.x - 25.f, _add1Label.frame.origin.y + _add1Label.frame.size.height, _add1Label.frame.size.width + 50.f, 150.f)];
            
            
            
            dict = (NSDictionary*)[app.employeesList objectAtIndex:0];
            [_add2Label setText:(NSString*)[dict objectForKey:@"name"]];
            valueAdd2 = (NSNumber*)[dict objectForKey:@"id_employee"];
            [_add2Label setFrame:CGRectMake(_dataToLabel.frame.origin.x, _dataToLabel.frame.origin.y + _dataToLabel.frame.size.height + 10.f, image.size.width, image.size.height)];
            [_add2Button setFrame:_add2Label.frame];
            
            [self.picker2Add setFrame:CGRectMake((_add2Label.frame.origin.x + _add2Label.frame.size.width) / 2 - 70.f, _add2Label.frame.origin.y + _add2Label.frame.size.height, _add2Label.frame.size.width + 150.f, 150.f)];
            
            
            
            orignY = _add1Label.frame.origin.y + _add1Label.frame.size.height + 10.f;
        }else if(_type == infograph){
  

            NSMutableArray* temp = [NSMutableArray new];
            NSDictionary* dict = @{@"name_filter":[NSString stringWithFormat:@"Сумма"],
                                   @"id_filter":[NSNumber numberWithInt:0]
                                   };
            [temp addObject:dict];
            dict = @{@"name_filter":[NSString stringWithFormat:@"Кол-во заказов"],
                     @"id_filter":[NSNumber numberWithInt:1]
                     };
            [temp addObject:dict];
            dict = @{@"name_filter":[NSString stringWithFormat:@"Кол-во блюд"],
                     @"id_filter":[NSNumber numberWithInt:2]
                     };
            [temp addObject:dict];
            
            self.filterData = [NSArray arrayWithArray:temp];
            
            [self addSubview:_dataFromLabel];
            [self addSubview:_dataFromButton];
            
            
            [self addSubview:_dataToLabel];
            [self addSubview:_dataToButton];
            
            
            [self addSubview:_add1Label];
            [self addSubview:_add1Button];
   
            [self addSubview:_datePickerFrom];
            [self addSubview:_datePickerTo];
            [self addSubview:_picker1Add];
            [self addSubview:_picker2Add];
            
            
            dict = (NSDictionary*)[_filterData objectAtIndex:0];
            [_add1Label setText:(NSString*)[dict objectForKey:@"name_filter"]];
            valueAdd1 = (NSNumber*)[dict objectForKey:@"id_filter"];
            [_add1Label setFrame:CGRectMake(_dataToLabel.frame.origin.x + _dataToLabel.frame.size.width + 20.f, _dataToLabel.frame.origin.y, image.size.width, image.size.height)];
            [_add1Button setFrame:_add1Label.frame];
            
            [self.picker1Add setFrame:CGRectMake(_add1Label.frame.origin.x - 25.f, _add1Label.frame.origin.y + _add1Label.frame.size.height, _add1Label.frame.size.width +50.f, 150.f)];
 
            
            orignY = _add1Label.frame.origin.y + _add1Label.frame.size.height + 10.f;
        }

        UIView* view = [self headerView];
        [self addSubview:view];
        [self sendSubviewToBack:view];
        orignY = view.frame.origin.y + view.frame.size.height;
        [self prepareView];
    }
    return self;
}
- (void)prepareView{
    
    if(_type != infograph){
        [_mainTableView removeFromSuperview];
        _mainTableView = nil;
        self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, orignY, [self widthWithType], self.frame.size.height - orignY) style:UITableViewStylePlain];
        _mainTableView.delegate = (id)_parent;
        _mainTableView.dataSource = (id) self;
        _mainTableView.backgroundColor = [UIColor clearColor];
        [_mainTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [_mainTableView setShowsHorizontalScrollIndicator:NO];
        [_mainTableView setShowsVerticalScrollIndicator:NO];
        [_mainTableView setBounces:NO];
        [_mainTableView setTableFooterView:[self footerView]];
        [self addSubview:_mainTableView];
        [self sendSubviewToBack:_mainTableView];
        [_mainTableView reloadData];
    } else {
        [_scrollview removeFromSuperview];
        _scrollview = nil;
        self.scrollview = [[UIScrollView alloc] init];
        _scrollview.showsHorizontalScrollIndicator = NO;
        _scrollview.showsHorizontalScrollIndicator = NO;
        [_scrollview setBounces:NO];
        [_scrollview setBackgroundColor:[UIColor clearColor]];
        [self addSubview: _scrollview];
        [self sendSubviewToBack:_scrollview];
        [_scrollview setFrame:CGRectMake(0, orignY, self.bounds.size.width, self.bounds.size.height - orignY)];
        UIImage* image = [UIImage imageNamed:@"data_infograph"];
        CGFloat posX = 0;
       
        /*for(int i = 0; i < 20; i++){
           int rand = random() % 35;
           int add = random() % 15;
           NSDictionary* obj = @{@"date":[NSString stringWithFormat:@"%@",[_parent stringFromDate:toDate withState:YES]],
                      @"breakfast":[NSNumber numberWithInt:rand],
                      @"lunch":[NSNumber numberWithInt:rand + add],
                      @"dinner":[NSNumber numberWithInt:rand + add],
                      @"max_count":[NSNumber numberWithInt:50],
                      };
 
            BASInfographView* infoGraphView = [[BASInfographView alloc]initWithFrame:CGRectMake(posX, orignY, image.size.width, _scrollview.frame.size.height - orignY) withContent:obj];
            [_scrollview addSubview:infoGraphView];
            posX += infoGraphView.frame.size.width;
        }*/
        NSArray* items = (NSArray*)[_contentData objectForKey:@"items"];
        for(NSDictionary* obj in items){
            BASInfographView* infoGraphView = [[BASInfographView alloc]initWithFrame:CGRectMake(posX, orignY, image.size.width, _scrollview.frame.size.height - orignY) withContent:obj];
            [_scrollview addSubview:infoGraphView];
            posX += infoGraphView.frame.size.width;
        }
        [_scrollview setBackgroundColor:[UIColor clearColor]];
        
        [_scrollview setContentSize:CGSizeMake(posX + 12.f, _scrollview.frame.size.height)];
    }
    
}
#pragma mark - UITableView DataSource
- (UIView*)headerView{
    
    UIView* view = [[UIView alloc]init];
    UIImage* image= [self headerWithType];
    [view setFrame:CGRectMake(0, orignY, image.size.width, image.size.height)];
    [view setBackgroundColor:[UIColor colorWithPatternImage:image]];
  
    return view;
}
- (UIView*)footerView{
    UIView* view = [[UIView alloc]init];
    UIImage* image= [self footerWithType];
    [view setFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    [view setBackgroundColor:[UIColor colorWithPatternImage:image]];
    
    if(_type == sales_rankings || _type == consumption_of_food){
        self.countLabel = [[UILabel alloc]init];
        [_countLabel setBackgroundColor:[UIColor clearColor]];
        _countLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:12.f];
        _countLabel.textColor = [UIColor blackColor];
        _countLabel.textAlignment = NSTextAlignmentCenter;
        NSNumber*  total_count = (NSNumber*)[_contentData objectForKey:@"total_count"];
        [_countLabel setText:[NSString stringWithFormat:@"%d",[total_count intValue]]];
        [_countLabel setFrame:CGRectMake(233.f, 0, 137.f, view.frame.size.height)];
        [view addSubview:_countLabel];
        
        self.costLabel = [[UILabel alloc]init];
        [_costLabel setBackgroundColor:[UIColor clearColor]];
        _costLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:12.f];
        _costLabel.textColor = [UIColor blackColor];
        NSNumber*  total_cost = (NSNumber*)[_contentData objectForKey:@"total_cost"];
        [_costLabel setText:[NSString stringWithFormat:@"%d",[total_cost intValue]]];
        [_costLabel setFrame:CGRectMake(374.f, 0, 141.f, view.frame.size.height)];
        _costLabel.textAlignment = NSTextAlignmentCenter;
        [view addSubview:_costLabel];
        
        if(_type == consumption_of_food){
            [_countLabel setFrame:CGRectMake(375.f, 0, 139.f, view.frame.size.height)];
            [_costLabel setFrame:CGRectMake(519.f, 0, 133.f, view.frame.size.height)];
        }
        
    } else if(_type == revenue){
        NSMutableArray* temp = [NSMutableArray new];
        for (int i = 0; i < 9; i++) {
            UILabel * lb = [[UILabel alloc]init];
            //[lb setBackgroundColor:[UIColor redColor]];
            [lb setBackgroundColor:[UIColor clearColor]];
            lb.font = [UIFont fontWithName:@"Helvetica-Light" size:12.f];
            lb.textColor = [UIColor blackColor];
            lb.textAlignment = NSTextAlignmentCenter;
            [temp addObject:lb];
            [view addSubview:lb];
        }
        self.totalRevenue = [NSArray arrayWithArray:temp];
       
        [((UILabel*)[temp objectAtIndex:0]) setFrame:CGRectMake(73.f, 0, 59.f, view.frame.size.height)];
        [((UILabel*)[temp objectAtIndex:1]) setFrame:CGRectMake(134.f, 0, 59.f, view.frame.size.height)];
        [((UILabel*)[temp objectAtIndex:2]) setFrame:CGRectMake(195.f, 0, 58.f, view.frame.size.height)];
        [((UILabel*)[temp objectAtIndex:3]) setFrame:CGRectMake(256.f, 0, 58.f, view.frame.size.height)];
        [((UILabel*)[temp objectAtIndex:4]) setFrame:CGRectMake(317.f, 0, 58.f, view.frame.size.height)];
        [((UILabel*)[temp objectAtIndex:5]) setFrame:CGRectMake(378.f, 0, 58.f, view.frame.size.height)];
        [((UILabel*)[temp objectAtIndex:6]) setFrame:CGRectMake(439.f, 0, 58.f, view.frame.size.height)];
        [((UILabel*)[temp objectAtIndex:7]) setFrame:CGRectMake(500.f, 0, 58.f, view.frame.size.height)];
        [((UILabel*)[temp objectAtIndex:8]) setFrame:CGRectMake(561.f, 0, 120.f, view.frame.size.height)];
        
        NSNumber*  total = (NSNumber*)[_contentData objectForKey:@"total_total"];
        [((UILabel*)[_totalRevenue objectAtIndex:0]) setText:[NSString stringWithFormat:@"%d",[total intValue]]];
        NSNumber*  cash = (NSNumber*)[_contentData objectForKey:@"total_cash"];
        [((UILabel*)[_totalRevenue objectAtIndex:1]) setText:[NSString stringWithFormat:@"%d",[cash intValue]]];
        NSNumber*  cashless = (NSNumber*)[_contentData objectForKey:@"total_cashless"];
        [((UILabel*)[_totalRevenue objectAtIndex:2]) setText:[NSString stringWithFormat:@"%d",[cashless intValue]]];
        NSNumber*  kitchen = (NSNumber*)[_contentData objectForKey:@"total_kitchen"];
        [((UILabel*)[_totalRevenue objectAtIndex:3]) setText:[NSString stringWithFormat:@"%d",[kitchen intValue]]];
        NSNumber*  bar = (NSNumber*)[_contentData objectForKey:@"total_bar"];
        [((UILabel*)[_totalRevenue objectAtIndex:4]) setText:[NSString stringWithFormat:@"%d",[bar intValue]]];
        NSNumber*  hookah = (NSNumber*)[_contentData objectForKey:@"total_hookah"];
        [((UILabel*)[_totalRevenue objectAtIndex:5]) setText:[NSString stringWithFormat:@"%d",[hookah intValue]]];
        NSNumber*  tax = (NSNumber*)[_contentData objectForKey:@"total_tax"];
        [((UILabel*)[_totalRevenue objectAtIndex:6]) setText:[NSString stringWithFormat:@"%d",[tax intValue]]];
        NSNumber*  discount = (NSNumber*)[_contentData objectForKey:@"total_discount"];
        [((UILabel*)[_totalRevenue objectAtIndex:7]) setText:[NSString stringWithFormat:@"%d",[discount intValue]]];
        NSNumber*  profit = (NSNumber*)[_contentData objectForKey:@"total_profit"];
        [((UILabel*)[_totalRevenue objectAtIndex:8]) setText:[NSString stringWithFormat:@"%d",[profit intValue]]];

        
    }
    
    return view;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)theTableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)section
{
 
    NSArray* param = (NSArray*)[_contentData objectForKey:@"items"];
    return param.count;

}

- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CellStat";
    
    NSArray* param = (NSArray*)[_contentData objectForKey:@"items"];
    param = (NSArray*)[_contentData objectForKey:@"items"];

    BASStatisticsCell *cell = [[BASStatisticsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier withContent:(NSDictionary*)[param objectAtIndex:[indexPath row]] withType:_type];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    cell.index = [indexPath row];

    return cell;
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
    TheApp;
    NSArray* param = nil;
     if(_type == sales_rankings){
         param = (NSArray*)[_globalData objectForKey:@"items"];
     } else  if(_type == consumption_of_food){
         if([pickerView isEqual:_picker1Add]){
             param = [NSArray arrayWithArray:app.menuList];
         } else {
            param = [NSArray arrayWithArray:app.dishesList];
         }
     } else  if(_type == list_of_staff || _type == salary){
         if([pickerView isEqual:_picker1Add]){
             param = [NSArray arrayWithArray:app.jobsList];
         } else {
             param = [NSArray arrayWithArray:app.employeesList];
         }
     }else  if(_type == infograph){
         param = [NSArray arrayWithArray:_filterData];
     }
    return param.count;
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    TheApp;
    if(_type == sales_rankings){
         return [NSString stringWithFormat:@"№ %d",(int)(row + 1)];
    } else  if(_type == consumption_of_food){
        if([pickerView isEqual:_picker1Add]){
            NSDictionary* dict = (NSDictionary*)[app.menuList objectAtIndex:row];
            return (NSString*)[dict objectForKey:@"name_category"];
        } else {
            NSDictionary* dict = (NSDictionary*)[app.dishesList objectAtIndex:row];
            return (NSString*)[dict objectForKey:@"name_dish"];
        }
    }else  if(_type == list_of_staff || _type == salary){
        if([pickerView isEqual:_picker1Add]){
            NSDictionary* dict = (NSDictionary*)[app.jobsList objectAtIndex:row];
            return (NSString*)[dict objectForKey:@"name_job"];
        } else {
            NSDictionary* dict = (NSDictionary*)[app.employeesList objectAtIndex:row];
            return (NSString*)[dict objectForKey:@"name"];
        }
    }else  if(_type == infograph){
        NSDictionary *dict = (NSDictionary*)[_filterData objectAtIndex:row];
        return (NSString*)[dict objectForKey:@"name_filter"];
    }
    
    

    return nil;

}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    TheApp;
    if(_type == sales_rankings){
        countList = row + 1;
    } else  if(_type == consumption_of_food){
        if([pickerView isEqual:_picker1Add]){
            NSDictionary* dict = (NSDictionary*)[app.menuList objectAtIndex:row];
            valueAdd1 = (NSNumber*)[dict objectForKey:@"id_category"];
            valueAdd2 = [NSNumber numberWithInt:-1];
            [_add1Label setText:(NSString*)[dict objectForKey:@"name_category"]];
            
        } else {
            NSDictionary* dict = (NSDictionary*)[app.dishesList objectAtIndex:row];
            valueAdd1 = [NSNumber numberWithInt:-1];
            valueAdd2 = (NSNumber*)[dict objectForKey:@"id_dish"];
            [_add2Label setText:(NSString*)[dict objectForKey:@"name_dish"]];
        }
    }else  if(_type == list_of_staff || _type == salary){
        if([pickerView isEqual:_picker1Add]){
            NSDictionary* dict = (NSDictionary*)[app.jobsList objectAtIndex:row];
            valueAdd1 = (NSNumber*)[dict objectForKey:@"id_job"];
            valueAdd2 = [NSNumber numberWithInt:-1];
            [_add1Label setText:(NSString*)[dict objectForKey:@"name_job"]];
            
        } else {
            NSDictionary* dict = (NSDictionary*)[app.employeesList objectAtIndex:row];
            valueAdd1 = [NSNumber numberWithInt:-1];
            valueAdd2 = (NSNumber*)[dict objectForKey:@"id_employee"];
            [_add2Label setText:(NSString*)[dict objectForKey:@"name"]];
        }
    }else  if(_type == infograph){
        NSDictionary *dict = (NSDictionary*)[_filterData objectAtIndex:row];
        [_add1Label setText:(NSString*)[dict objectForKey:@"name_filter"]];
        valueAdd1 = (NSNumber*)[dict objectForKey:@"id_filter"];
       
    }
    
    
}

#pragma mark - DatePicker Private Methods
- (void)pickerChanged:(id)sender{
    NSLog(@"value: %@",[sender date]);
    
    if((UIDatePicker*)sender == _datePickerFrom){
        fromDate = [sender date];
        [_datePickerFrom setDate:fromDate];
        [_dataFromLabel setText:[_parent stringFromDate:fromDate withState:YES]];
    } else if((UIDatePicker*)sender == _datePickerTo){
         toDate = [sender date];
        [_datePickerTo setDate:toDate];
        [_dataToLabel setText:[_parent stringFromDate:toDate withState:YES]];
    }
    
}
#pragma mark -  Private Methods
- (UIImage*)headerWithType{
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
    return  image;
}
- (UIImage*)footerWithType{
    UIImage* image= nil;
    if(_type == sales_rankings){
        image = [UIImage imageNamed:@"BgAll1"];
    } else if(_type == consumption_of_food){
        image = [UIImage imageNamed:@"BgAll2"];
    } else if(_type == revenue){
        image = [UIImage imageNamed:@"BgAll3"];
    } else if(_type == list_of_staff){
        image = nil;
    }else if(_type == salary){
        image = nil;
    }
    return  image;
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
- (void)fromTap:(id)sender{
    isFromPicker = !isFromPicker;
    
    
    [_datePickerFrom setHidden:isFromPicker];
    [_datePickerTo setHidden:YES];
    [_picker1Add setHidden:YES];
    [_picker2Add setHidden:YES];
    
    [_dataToButton setEnabled:isFromPicker];
    [_add1Button setEnabled:isFromPicker];
    [_add2Button setEnabled:isFromPicker];

    if(isFromPicker)
        [self getData];
    
}
- (void)toTap:(id)sender{
    isToPicker = !isToPicker;
    
    [_datePickerFrom setHidden:YES];
    [_datePickerTo setHidden:isToPicker];
    [_picker1Add setHidden:YES];
    [_picker2Add setHidden:YES];
    
    [_dataFromButton setEnabled:isToPicker];
    [_add1Button setEnabled:isToPicker];
    [_add2Button setEnabled:isToPicker];
    
    if(isToPicker)
        [self getData];
}
- (void)add1Tap:(id)sender{
    TheApp;
    isAdd1 = !isAdd1;
    [_datePickerFrom setHidden:YES];
    [_datePickerTo setHidden:YES];
    [_picker1Add setHidden:isAdd1];
    [_picker2Add setHidden:YES];
    
    [_dataToButton setEnabled:isAdd1];
    [_dataFromButton setEnabled:isAdd1];
    [_add2Button setEnabled:isAdd1];
    if(_type == consumption_of_food){
        NSDictionary* dict = (NSDictionary*)[app.dishesList objectAtIndex:0];
        [_add2Label setText:(NSString*)[dict objectForKey:@"name_dish"]];
    } else if (_type == list_of_staff || _type == salary){
        NSDictionary* dict = (NSDictionary*)[app.employeesList objectAtIndex:0];
        [_add2Label setText:(NSString*)[dict objectForKey:@"name"]];
    }
        
    if(isAdd1){
        [self getData];
    }
}
- (void)add2Tap:(id)sender{
    TheApp;
    isAdd2 = !isAdd2;
    [_datePickerFrom setHidden:YES];
    [_datePickerTo setHidden:YES];
    [_picker1Add setHidden:YES];
    [_picker2Add setHidden:isAdd2];
    
    [_dataToButton setEnabled:isAdd2];
    [_dataFromButton setEnabled:isAdd2];
    [_add1Button setEnabled:isAdd2];
    
    if(_type == consumption_of_food){
        NSDictionary* dict = (NSDictionary*)[app.menuList objectAtIndex:0];
        [_add1Label setText:(NSString*)[dict objectForKey:@"name_category"]];
    }else if (_type == list_of_staff || _type == salary){
        NSDictionary* dict = (NSDictionary*)[app.jobsList objectAtIndex:0];
        [_add1Label setText:(NSString*)[dict objectForKey:@"name_job"]];
    }
    if(isAdd2)
        [self getData];
}

- (void)getData{
    
    BASManager* manager = [BASManager sharedInstance];
    
    NSString* command = nil;
    NSDictionary* param = nil;

    
    if(_type == sales_rankings){
        [_add1Label setText:[NSString stringWithFormat:@"№ %d",(int)countList]];
        command = @"GETSALESRANKINGS";
        param = @{@"date_from":[NSString stringWithFormat:@"%@",[_parent stringFromDate:fromDate withState:YES]],
                  @"date_to":[NSString stringWithFormat:@"%@",[_parent stringFromDate:toDate withState:YES]],
                  @"count":[NSNumber numberWithInteger:countList]
                  };
    } else if(_type == consumption_of_food){
        
        command = @"GETSALESRANKINGS";
        param = @{@"date_from":[NSString stringWithFormat:@"%@",[_parent stringFromDate:fromDate withState:YES]],
                  @"date_to":[NSString stringWithFormat:@"%@",[_parent stringFromDate:toDate withState:YES]],
                  @"id_category":valueAdd1,
                  @"id_dish":valueAdd2,
                  };

    } else if(_type == revenue){
        command = @"GETPROCEEDSTATISTIC";
        param = @{@"date_from":[NSString stringWithFormat:@"%@",[_parent stringFromDate:fromDate withState:YES]],
                  @"date_to":[NSString stringWithFormat:@"%@",[_parent stringFromDate:toDate withState:YES]],
                  };
    } else if(_type == list_of_staff){
        command = @"GETEMPLOYEES";
        param = @{@"date_from":[NSString stringWithFormat:@"%@",[_parent stringFromDate:fromDate withState:YES]],
                  @"date_to":[NSString stringWithFormat:@"%@",[_parent stringFromDate:fromDate withState:YES]],
                  @"id_job":valueAdd1,
                  @"id_employee":valueAdd2,
                  };
    }else if(_type == salary){
        command = @"GETEMPLOYEES";
        param = @{@"date_from":[NSString stringWithFormat:@"%@",[_parent stringFromDate:fromDate withState:YES]],
                  @"date_to":[NSString stringWithFormat:@"%@",[_parent stringFromDate:toDate withState:YES]],
                  @"id_job":valueAdd1,
                  @"id_employee":valueAdd2
                  };
    }else if(_type == infograph){
        command = @"GETINFOGRAPHICS";
        param = @{@"date_from":[NSString stringWithFormat:@"%@",[_parent stringFromDate:fromDate withState:YES]],
                  @"date_to":[NSString stringWithFormat:@"%@",[_parent stringFromDate:toDate withState:YES]],
                  @"filter":valueAdd1,
                  };
    }
   

    
    [manager getData:[manager formatRequest:command withParam:param] success:^(id responseObject) {
        
        NSLog(@"Response: %@",responseObject);
        
        NSArray* param = (NSArray*)[responseObject objectForKey:@"param"];
        NSDictionary* dict = (NSDictionary*)[param objectAtIndex:0];
        param = (NSArray*)[dict objectForKey:@"items"];
        
        if(param != nil){
            self.contentData = [NSDictionary dictionaryWithDictionary:dict];
            if(_type == sales_rankings || _type == consumption_of_food){
                NSNumber*  total_count = (NSNumber*)[_contentData objectForKey:@"total_count"];
                [_countLabel setText:[NSString stringWithFormat:@"%d",[total_count intValue]]];
                NSNumber*  total_cost = (NSNumber*)[_contentData objectForKey:@"total_cost"];
                [_costLabel setText:[NSString stringWithFormat:@"%d",[total_cost intValue]]];
            }else if(_type == revenue){

                NSNumber*  total = (NSNumber*)[_contentData objectForKey:@"total_total"];
                [((UILabel*)[_totalRevenue objectAtIndex:0]) setText:[NSString stringWithFormat:@"%d",[total intValue]]];
                
               
                NSNumber*  cash = (NSNumber*)[_contentData objectForKey:@"total_cash"];
                [((UILabel*)[_totalRevenue objectAtIndex:1]) setText:[NSString stringWithFormat:@"%d",[cash intValue]]];
                
               
                NSNumber*  cashless = (NSNumber*)[_contentData objectForKey:@"total_cashless"];
                [((UILabel*)[_totalRevenue objectAtIndex:2]) setText:[NSString stringWithFormat:@"%d",[cashless intValue]]];
                
             
                NSNumber*  kitchen = (NSNumber*)[_contentData objectForKey:@"total_kitchen"];
                [((UILabel*)[_totalRevenue objectAtIndex:3]) setText:[NSString stringWithFormat:@"%d",[kitchen intValue]]];
                
        
                NSNumber*  bar = (NSNumber*)[_contentData objectForKey:@"total_bar"];
                [((UILabel*)[_totalRevenue objectAtIndex:4]) setText:[NSString stringWithFormat:@"%d",[bar intValue]]];
                
           
                NSNumber*  hookah = (NSNumber*)[_contentData objectForKey:@"total_hookah"];
                [((UILabel*)[_totalRevenue objectAtIndex:5]) setText:[NSString stringWithFormat:@"%d",[hookah intValue]]];
                
             
                NSNumber*  tax = (NSNumber*)[_contentData objectForKey:@"total_tax"];
                [((UILabel*)[_totalRevenue objectAtIndex:6]) setText:[NSString stringWithFormat:@"%d",[tax intValue]]];
                
            
                NSNumber*  discount = (NSNumber*)[_contentData objectForKey:@"total_discount"];
                [((UILabel*)[_totalRevenue objectAtIndex:7]) setText:[NSString stringWithFormat:@"%d",[discount intValue]]];
                
              
                NSNumber*  profit = (NSNumber*)[_contentData objectForKey:@"total_profit"];
                [((UILabel*)[_totalRevenue objectAtIndex:8]) setText:[NSString stringWithFormat:@"%d",[profit intValue]]];
            }
            [self prepareView];
        }
    } failure:^(NSString *error) {
        [manager showAlertViewWithMess:ERROR_MESSAGE];
    }];
}

@end
