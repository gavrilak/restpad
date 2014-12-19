//
//  BASWarehouseController.m
//  RestrauntSystemPad
//
//  Created by Sergey Bekker on 20.07.14.
//  Copyright (c) 2014 BestAppStudio. All rights reserved.
//

#import "BASWarehouseController.h"
#import "BASCustomTableView.h"

@interface BASWarehouseController (){
    NSInteger curIndex;
}

@property (nonatomic,strong) UIImageView* headerViewContent;
@property (nonatomic,strong) NSArray *contentList;
@property (nonatomic,strong) NSArray *content;
@property (nonatomic,strong) UITableView* tableListView;
@property (nonatomic,strong) UITableView* tableContentView;
@property (nonatomic,strong) UIImageView* separatorView;
@property (nonatomic,strong) UILabel* emptyView;
@property (nonatomic,strong) UIImageView *vertseparator;
@end

@implementation BASWarehouseController

- (id)init
{
    self = [super init];
    if (self) {
        NSMutableArray* temp = [[NSMutableArray alloc]initWithCapacity:20];
        for(int i = 0; i < 8; i++){
            [temp addObject:[NSNull null]];
        }
        self.content = [NSArray arrayWithArray:temp];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
 
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_all.png"]]];
    [self setupBtnLogout];
    self.title = @"Склад";
    
    self.emptyView = [[UILabel alloc]init];
    [_emptyView setBackgroundColor:[UIColor clearColor]];
    _emptyView.font = [UIFont fontWithName:@"Helvetica-Bold" size:34.f];
    _emptyView.textColor = [UIColor whiteColor];
    _emptyView.shadowColor = [UIColor blackColor];
    _emptyView.shadowOffset = CGSizeMake(0.0, 1.0);
    _emptyView.textAlignment = NSTextAlignmentCenter;
    [_emptyView setText:@"Нет данных"];
    [self.view addSubview:_emptyView];
    [_emptyView setHidden:YES];
    
    

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    TheApp;
    [self.view addSubview:app.tabBar];
    [self getData];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    TheApp;
    [app.tabBar removeFromSuperview];
}
#pragma mark - Private methods


- (void)getData{
    
    BASManager* manager = [BASManager sharedInstance];

    
    [manager getData:[manager formatRequest:@"GETWAREHOUSE" withParam:nil] success:^(id responseObject) {
        
        if([responseObject isKindOfClass:[NSDictionary class]]){
            
            NSArray* param = (NSArray*)[responseObject objectForKey:@"param"];
            NSLog(@"Response: %@",param);
            
            if(param != nil && param.count > 0){
                NSMutableArray* temp = [NSMutableArray new];
                NSMutableArray* tempContent = [NSMutableArray new];
                for(NSDictionary* obj in param){
                    [temp addObject:(NSString*)[obj objectForKey:@"name_warehouse"]];
                    [tempContent addObject:(NSDictionary*)[obj objectForKey:@"warehouse"]];
                }
                self.contentList = [NSArray arrayWithArray:temp];
                self.content = [NSArray arrayWithArray:tempContent];
                curIndex = 0;
                [self prepareView];

                if(((NSArray*)[_content objectAtIndex:curIndex]).count == 0){
                    [_tableContentView setHidden:YES];
                    [_tableContentView setHidden:YES];
                    [_vertseparator setHidden:YES];
                    [_emptyView setHidden:NO];
                }
            }
            
        }
        
    } failure:^(NSString *error) {
        [manager showAlertViewWithMess:ERROR_MESSAGE];
    }];
}

- (void)prepareView{
    
    CGRect frame = CGRectMake(10.f, 0, 320.f, 768.f -self.navigationController.navigationBar.frame.size.height - 76.f);
    

    [_tableListView removeFromSuperview];
    self.tableListView = nil;
    self.tableListView = [[UITableView alloc]initWithFrame:frame style:UITableViewStylePlain];

    [_tableListView setBackgroundColor:[UIColor clearColor]];
    [_tableListView setTableHeaderView:[self headerView]];
    _tableListView.delegate = self;
    _tableListView.dataSource = self;
    [_tableListView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_tableListView setShowsHorizontalScrollIndicator:NO];
    [_tableListView setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:_tableListView];
    [_tableListView reloadData];
    
    
    
    
    [_separatorView removeFromSuperview];
    self.separatorView = nil;
    self.separatorView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"delimiter_long.png"]];
    [_separatorView setFrame:CGRectMake(_tableListView.frame.size.width + 20.f, 0, 2.f, 768.f -self.navigationController.navigationBar.frame.size.height - 76.f)];
    [self.view addSubview:_separatorView];
    
    [_headerViewContent removeFromSuperview];
    self.headerViewContent = nil;
    
    UIImage * image = [UIImage imageNamed:@"header_table.png"];
    self.headerViewContent = [[UIImageView alloc]initWithImage:image];
    [_headerViewContent setFrame:CGRectMake(_separatorView.frame.origin.x + _separatorView.frame.size.width + 5.f, 0, image.size.width , image.size.height)];
    [self.view addSubview:_headerViewContent];
    
    frame = CGRectMake(_headerViewContent.frame.origin.x +2.f ,  _headerViewContent.frame.size.height, _headerViewContent.frame.size.width - 4.f, 768.f - self.navigationController.navigationBar.frame.size.height - _headerViewContent.frame.size.height - 76.f);
    
    [_tableContentView removeFromSuperview];
    self.tableContentView = nil;
    self.tableContentView = [[UITableView alloc]initWithFrame:frame style:UITableViewStylePlain];
    _tableContentView.delegate = self;
    _tableContentView.dataSource = self;
    [_tableContentView setShowsHorizontalScrollIndicator:NO];
    [_tableContentView setShowsVerticalScrollIndicator:NO];
    [_tableContentView setSeparatorColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"separator_person.png"]]];
    if ([_tableContentView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableContentView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    [_tableContentView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:_tableContentView];
    
    self.vertseparator = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"razdelr_person.png"]];
    [_vertseparator setFrame:CGRectMake(_headerViewContent.frame.origin.x + 2.f + _headerViewContent.frame.size.width - 151.f, _headerViewContent.frame.size.height, 1.f, frame.size.height)];
    [self.view addSubview:_vertseparator];
    
    [_emptyView setFrame:CGRectMake(_separatorView.frame.origin.x + _separatorView.frame.size.width, 768.f / 2 - 80.f, 1024.f - _separatorView.frame.origin.x - _separatorView.frame.size.width, 40.f)];


}

- (UIView*)headerView{
    UIView* view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320.f, 20.f)];
    [view setBackgroundColor:[UIColor clearColor]];

    
    return view;
}
#pragma mark -
#pragma mark Table view methods


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(tableView == _tableListView)
        return _contentList.count;
    
    NSArray* temp = (NSArray*)[_content objectAtIndex:curIndex];
    return temp.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellLisIdentifier = @"contentListCell";
    static NSString *CellIdentifier = @"contentCell";
    UITableViewCell* cell = nil;
    if(tableView == _tableListView){
        UIImage* image = [UIImage imageNamed:@"button_holl.png"];
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellLisIdentifier];
        UIImageView  *bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"button_holl.png"]];
        [bgView setFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
        [cell.contentView addSubview:bgView];
        
        UILabel* nameElement = [UILabel new];
        nameElement.font = [UIFont fontWithName:@"Helvetica-Bold" size:22.f];
        nameElement.textColor = [UIColor colorWithRed:90.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1.0];
        nameElement.shadowColor = [UIColor colorWithRed:188.0/255.0 green:188.0/255.0 blue:188.0/255.0 alpha:1.0];
        nameElement.shadowOffset = CGSizeMake(0.0, 1.0);
        nameElement.backgroundColor = [UIColor clearColor];
        [nameElement setTextAlignment:NSTextAlignmentCenter];
        [nameElement setNumberOfLines:2];
        [nameElement setLineBreakMode:NSLineBreakByWordWrapping];
        [nameElement setText:(NSString*)[_contentList objectAtIndex:[indexPath row]]];
        [nameElement setFrame:bgView.frame];
        [cell.contentView addSubview:nameElement];
    } else {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];

        CGRect frame = cell.contentView.frame;
        
        [cell.contentView setBackgroundColor:[UIColor whiteColor]];
   
        UIImageView *separator = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"separator_person.png"]];
        [separator setFrame:CGRectMake(0.f, frame.size.height - 0.5f, frame.size.width, 0.5f)];
        //[cell.contentView addSubview:separator];
        
       
        NSArray* temp = (NSArray*)[_content objectAtIndex:curIndex];
        
        if(temp != nil && temp.count > 0){

            NSDictionary* dict = (NSDictionary*)[temp objectAtIndex:[indexPath row]];
            
            UILabel* nameElement = [UILabel new];
            nameElement.font = [UIFont fontWithName:@"Helvetica-Bold" size:22.f];
            //nameElement.textColor = [UIColor colorWithRed:90.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1.0];
            nameElement.textColor = [UIColor blackColor];
            nameElement.shadowColor = [UIColor colorWithRed:188.0/255.0 green:188.0/255.0 blue:188.0/255.0 alpha:1.0];
            nameElement.shadowOffset = CGSizeMake(0.0, 1.0);
            nameElement.backgroundColor = [UIColor clearColor];
            [nameElement setTextAlignment:NSTextAlignmentCenter];
            [nameElement setLineBreakMode:NSLineBreakByWordWrapping];
            [nameElement setText:(NSString*)[dict objectForKey:@"name_element"]];
            [nameElement setFrame:CGRectMake(0.f, 0.f, _headerViewContent.frame.size.width - 151.f, frame.size.height)];
            [cell.contentView addSubview:nameElement];
  
            UILabel* amount = [UILabel new];
            amount.font = [UIFont fontWithName:@"Helvetica-Bold" size:22.f];
            amount.textColor = [UIColor blackColor];
            amount.backgroundColor = [UIColor clearColor];
            [amount setTextAlignment:NSTextAlignmentCenter];
            NSNumber* amountnum = (NSNumber*)[dict objectForKey:@"amount"];
            [amount setText:[NSString stringWithFormat:@"%d %@",[amountnum integerValue],(NSString*)[dict objectForKey:@"measure"]]];
            [amount setFrame:CGRectMake(_headerViewContent.frame.size.width - 151.f, 0.f, 151.f, frame.size.height)];
            [cell.contentView addSubview:amount];
        }
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
}
#pragma mark -
#pragma mark Table delegate methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
 
    if(tableView == _tableListView){
        return 90.f;
    }
    return 44.f;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(tableView == _tableListView){
        curIndex = [indexPath row];
        NSArray* temp = (NSArray*)[_content objectAtIndex:curIndex];
        if(temp.count == 0){
            [_tableContentView setHidden:YES];
            [_vertseparator setHidden:YES];
            [_emptyView setHidden:NO];
        } else{
            [_emptyView setHidden:YES];
            [_tableContentView setHidden:NO];
            [_vertseparator setHidden:NO];
            [_tableContentView reloadData];
        }
    }
    
}


@end
