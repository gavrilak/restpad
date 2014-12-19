//
//  BASViewController.m
//  RestrauntSystemPad
//
//  Created by Sergey on 19.07.14.
//  Copyright (c) 2014 BestAppStudio. All rights reserved.
//

#import "BASTablesController.h"
#import "BASRoomView.h"
#import "BASCustomTableView.h"
#import "BASOrderViewController.h"
#import "BASTableView.h"


@interface BASTablesController (){
    NSInteger curIndex;
}
@property(nonatomic, strong) UIPopoverController *popover;
@property (nonatomic,strong) NSArray* rooms;
@property (nonatomic,strong) NSArray* views;
@property (nonatomic,strong) BASCustomTableView* tableView;
@property (nonatomic,strong) UIImageView* separatorView;
@property(nonatomic, strong) UILabel* nameCategory;


@end

@implementation BASTablesController

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    curIndex = 0;
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_all.png"]]];
    [self setupBtnLogout];
    self.title = @"Столы";
    
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    TheApp;
    [self.view addSubview:app.tabBar];
    [self getRooms];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    TheApp;
    [app.tabBar removeFromSuperview];
}
#pragma mark  - Private methods
- (UIView*)headerView{
    UIView* view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320.f, 40.f)];
    [view setBackgroundColor:[UIColor clearColor]];
    
    //UIImageView* imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"button_table.png"]];
    //[imgView setFrame:CGRectMake(160.f - 154.5, 80.f/ 2 - 53.5f / 2, 309.f, 53.5f)];
   // [view addSubview:imgView];

    
    return view;
}
- (UIView*)footerView{
    UIView* view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320.f, 36.f)];
    [view setBackgroundColor:[UIColor clearColor]];
    UIImageView* imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"halls_btn_edit.png"]];
    [imgView setFrame:CGRectMake(160.f - 173.f / 2, 36.f / 2 - 34.f / 2, 173.f, 34.f)];
    [view addSubview:imgView];
    
    return view;
}
- (void)clearView{
    if(self.views != nil){
        for(BASRoomView* obj in _views){
            [obj removeFromSuperview];
            
        }
    }
    self.views = nil;
    
}
- (void)prepareViews{
    
    [self clearView];
 
    CGRect frame = CGRectMake(10.f, 0, 320.f, 768.f -self.navigationController.navigationBar.frame.size.height - 76.f);
 
    [_separatorView removeFromSuperview];
    self.separatorView = nil;
    self.separatorView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"delimiter_long.png"]];
    [_separatorView setFrame:CGRectMake(_tableView.frame.size.width + 20.f, 0, 2.f, 768.f -self.navigationController.navigationBar.frame.size.height - 76.f)];
    [self.view addSubview:_separatorView];
    
    [_nameCategory removeFromSuperview];
    self.nameCategory = nil;
    self.nameCategory = [UILabel new];
    self.nameCategory.font = [UIFont fontWithName:@"Helvetica-Bold" size:28.f];
    self.nameCategory.textColor = [UIColor colorWithRed:142.0/255.0 green:215.0/255.0 blue:249.0/255.0 alpha:1.0];
    self.nameCategory.backgroundColor = [UIColor clearColor];
    [self.nameCategory setTextAlignment:NSTextAlignmentCenter];
    NSDictionary* dict = (NSDictionary*)[_rooms objectAtIndex:curIndex];
    [self.nameCategory setText:(NSString*)[dict objectForKey:@"name_room"]];
    [self.nameCategory setFrame:CGRectMake(_separatorView.frame.origin.x + _separatorView.frame.size.width, 15.f, 1024.f - ( _separatorView.frame.origin.x + _separatorView.frame.size.width), 45.f)];
    [self.view addSubview:self.nameCategory];
    
    NSMutableArray* temp = [[NSMutableArray alloc]init];
    frame = CGRectMake(_separatorView.frame.origin.x  +_separatorView.frame.size.width, _nameCategory.frame.size.height + 15.f, 1024.f - (_separatorView.frame.origin.x  +_separatorView.frame.size.width), 768.f - self.navigationController.navigationBar.frame.size.height - _nameCategory.frame.origin.y - _nameCategory.frame.size.height -76.f);

    RoomType type = FIRSTROOM;
    
    for (int i = 0; i < _rooms.count; i++) {
        switch (i) {
            case 0:
                type = FIRSTROOM;
                break;
            case 1:
                type = SECONDROOM;
                break;
            case 2:
                type = THIRDROOM;
                break;
            case 3:
                type = FOURTHROOM;
                break;
                
            default:
                break;
        }
        BASRoomView* view = [[BASRoomView alloc]initWithFrame:frame withContent:(NSDictionary*)[_rooms objectAtIndex:i] withIndex:i withType:type];
        [view createRoom];
        view.delegate = (id)self;
        [temp addObject:view];
    }
    self.views = [NSArray arrayWithArray:temp];
    
    [self.view addSubview:(BASRoomView*)[_views objectAtIndex:curIndex]];

  
    TheApp;
    [app.virtualView removeFromSuperview];
    app.virtualView = nil;
    app.virtualView = [[BASVirtualTableView alloc]initWithFrame:CGRectMake(1024.f - 125.5f, 768.f - 290.f, 125.5f, 168.f)];
    [self.view addSubview:app.virtualView];
    
}

- (void)UpdateTablesView{
    [self getData:curIndex];
}
- (void)getRooms{
    
    TheApp;
    
    BASManager* manager = [BASManager sharedInstance];
    
    [manager getData:[manager formatRequest:@"GETROOMSALL" withParam:nil] success:^(id responseObject) {
        
        
        if([responseObject isKindOfClass:[NSDictionary class]]){
            NSArray* param = (NSArray*)[responseObject objectForKey:@"param"];
            NSLog(@"Response: %@",param);
            if(param != nil && param.count > 0){
                NSMutableArray* data = [[NSMutableArray alloc]initWithCapacity:param.count];
                NSMutableArray* tempTables = [[NSMutableArray alloc]initWithCapacity:param.count];
                for(NSDictionary* obj in param){
                    [data addObject:obj];
                    
                    NSArray* tables = (NSArray*)[obj objectForKey:@"tables"];
                    for(NSDictionary* obj1 in tables){
                        NSDictionary* dt = @{@"id_room": (NSNumber*)[obj1 objectForKey:@"id_room"],
                                             @"id_table": (NSNumber*)[obj1 objectForKey:@"id_table"],
                                             @"number_table": (NSNumber*)[obj1 objectForKey:@"number_table"]
                                             };
                        [tempTables addObject:dt];
                    }
                }
                self.rooms = [NSArray arrayWithArray:data];
                app.tableList = [NSArray arrayWithArray:tempTables];
                [data removeAllObjects];
                
                CGRect frame = CGRectMake(10.f, 0, 320.f, 768.f -self.navigationController.navigationBar.frame.size.height - 76.f);
                
                [_tableView removeFromSuperview];
                _tableView = nil;
                self.tableView = [[BASCustomTableView alloc]initWithFrame:frame style:UITableViewStylePlain withContent:_rooms withType:HALLS withDelegate:nil];
                _tableView.delegate = (id)self;
                [_tableView setBackgroundColor:[UIColor clearColor]];
                [_tableView setTableHeaderView:[self headerView]];
                //[_tableView setTableFooterView:[self footerView]];
                [self.view addSubview:_tableView];
                
                [self UpdateTablesView];
            }
        }
        
    } failure:^(NSString *error) {
        [manager showAlertViewWithMess:ERROR_MESSAGE];
    }];
    
}
- (void)getData:(NSInteger)index{
    
    
    BASManager* manager = [BASManager sharedInstance];
    
    NSDictionary* room = (NSDictionary*)[_rooms objectAtIndex:index];
    
    NSDictionary* param = [NSDictionary dictionaryWithObjectsAndKeys:
                           (NSNumber*)[room objectForKey:@"id_room"] ,@"id_room",
                           nil];
    
    [manager getData:[manager formatRequest:@"GETTABLES" withParam:param] success:^(id responseObject) {
        
        if([responseObject isKindOfClass:[NSDictionary class]]){
            
            NSArray* param = (NSArray*)[responseObject objectForKey:@"param"];
            NSLog(@"Response: %@",param);
            
            if(param != nil && param.count > 0){
                [self prepareViews];
                NSDictionary* data= (NSDictionary*)[param objectAtIndex:0];
                BASRoomView* view = (BASRoomView*)[_views objectAtIndex:curIndex];
                view.contentData = [NSDictionary dictionaryWithDictionary:data];
                
                
            }
            
        }
    } failure:^(NSString *error) {
        [manager showAlertViewWithMess:ERROR_MESSAGE];
    }];
}

#pragma mark  - BASRoomViewDelegate methods
- (void)selectTable:(BASRoomView*)view withIndexRoom:(NSUInteger)indexRoom withTableRect:(CGRect)frame withIndexTable:(NSInteger)indexTable{
    
   
    NSLog(@"indexRoom: %d",indexRoom);
    NSLog(@"indexTable: %d",indexTable);
    
    NSDictionary* roomContent = (NSDictionary*)[_rooms objectAtIndex:indexRoom];
    NSArray* tablesContent = (NSArray*)[roomContent objectForKey:@"tables"];
    NSDictionary* tblContent = (NSDictionary*)[tablesContent objectAtIndex:indexTable];
    TableState table_status = (TableState) [((NSNumber*)[tblContent objectForKey:@"table_status"])integerValue];

    if(table_status != TableStateFree){
 
        TheApp;
        app.isOrder = YES;
        BASOrderViewController* controller = [BASOrderViewController new];
        controller.isMove = NO;
        controller.contentData = tblContent;
 
        if(!self.popover.popoverVisible){
            self.popover = nil;
            self.popover  = [[UIPopoverController alloc] initWithContentViewController:controller];
            [_popover setPopoverContentSize:CGSizeMake(320, 568)];
            BASRoomView* view = (BASRoomView*)[_views objectAtIndex:curIndex];
            [_popover presentPopoverFromRect:frame inView:view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        }
    }
    
    
}

#pragma mark -
#pragma mark Table delegate methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return [_tableView hightCell:_tableView.typeTable];
   
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    curIndex = [indexPath row];
    [self UpdateTablesView];
}

@end
