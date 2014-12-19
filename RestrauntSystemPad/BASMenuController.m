//
//  BASMenuController.m
//  RestrauntSystem
//
//  Created by Sergey on 04.06.14.
//  Copyright (c) 2014 BestAppStudio. All rights reserved.
//

#import "BASMenuController.h"
#import "BASCustomTableView.h"
#import "BASDishViewController.h"

@interface BASMenuController (){
    NSInteger curIndex;
    
}

@property (nonatomic,strong) NSArray* contentData;
@property (nonatomic,strong) NSArray* leftContentData;
@property (nonatomic,strong) NSArray* rightContentData;
@property (nonatomic,strong) BASCustomTableView* tableView;
@property (nonatomic,strong) BASCustomTableView* tableLeftView;
@property (nonatomic,strong) BASCustomTableView* tableRightView;
@property (nonatomic,strong) UIImageView* separatorView;
@property(nonatomic, strong) UILabel* nameCategory;
@property(nonatomic, strong) NSString* categoryName;
@property(nonatomic, strong) UIPopoverController *popover;

@end

@implementation BASMenuController

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
 
    curIndex = 0;
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_all.png"]]];;
    [self setupBtnLogout];
    self.title = @"Меню";

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

#pragma mark -
#pragma mark Private methods
- (void)prepareView{
    
    CGRect frame = CGRectMake(0, 0, 320.f, self.view.frame.size.height - 56.f);
    
    [_tableView removeFromSuperview];
    _tableView = nil;
    self.tableView = [[BASCustomTableView alloc]initWithFrame:frame style:UITableViewStylePlain withContent:_contentData withType:CATEGORYTABLE withDelegate:nil];
    _tableView.delegate = (id)self;
    [_tableView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:_tableView];
    
    self.separatorView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"delimiter_long.png"]];
    [_separatorView setFrame:CGRectMake(_tableView.frame.size.width + 5.f, 0, 2.f, self.view.frame.size.height - 56.f)];
    [self.view addSubview:_separatorView];
    
    
    [_nameCategory removeFromSuperview];
    self.nameCategory = nil;
    self.nameCategory = [UILabel new];
    self.nameCategory.font = [UIFont fontWithName:@"Helvetica-Bold" size:28.f];
    self.nameCategory.textColor = [UIColor colorWithRed:142.0/255.0 green:215.0/255.0 blue:249.0/255.0 alpha:1.0];
    self.nameCategory.backgroundColor = [UIColor clearColor];
    [self.nameCategory setTextAlignment:NSTextAlignmentCenter];
    [self.nameCategory setText:self.categoryName];
    [self.nameCategory setFrame:CGRectMake(_separatorView.frame.origin.x + _separatorView.frame.size.width, 15.f, self.view.frame.size.width - ( _separatorView.frame.origin.x + _separatorView.frame.size.width), 45.f)];
    [self.view addSubview:self.nameCategory];
  
    
    frame = CGRectMake(_separatorView.frame.origin.x + _separatorView.frame.size.width + 25.f, 55.f, 320.f, self.view.frame.size.height - 56.f - 55.f);
    [_tableLeftView removeFromSuperview];
    _tableLeftView = nil;
    self.tableLeftView = [[BASCustomTableView alloc]initWithFrame:frame style:UITableViewStylePlain withContent:_leftContentData withType:SUBCATEGORYTABLE withDelegate:nil];
    _tableLeftView.delegate = (id)self;
    [_tableLeftView setBounces:NO];
    [_tableLeftView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:_tableLeftView];
    
    frame = CGRectMake(_tableLeftView.frame.origin.x + _tableLeftView.frame.size.width + 10.f, 55.f, 320.f, self.view.frame.size.height - 56.f - 55.f);
    [_tableRightView removeFromSuperview];
    _tableRightView = nil;
    self.tableRightView = [[BASCustomTableView alloc]initWithFrame:frame style:UITableViewStylePlain withContent:_rightContentData withType:SUBCATEGORYTABLE withDelegate:nil];
    [_tableRightView setBounces:NO];
    _tableRightView.delegate = (id)self;
    [_tableRightView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:_tableRightView];
    
    
    
}
- (void)getData{
    
 
    BASManager* manager = [BASManager sharedInstance];

    [manager getData:[manager formatRequest:[Settings text:TextForApiFuncMenuItemFormat] withParam:nil] success:^(id responseObject) {
  
        if([responseObject isKindOfClass:[NSDictionary class]]){
    
            NSArray* param = (NSArray*)[responseObject objectForKey:@"param"];
             NSLog(@"Response: %@",param);
            if(param != nil && param.count > 0){
                
                
                NSMutableArray* data = [[NSMutableArray alloc]initWithCapacity:param.count];
                
                for (NSDictionary* obj in param) {
                 
                    NSString* catName = (NSString*)[obj objectForKey:@"name_category"];
   
                    NSDictionary* dict = @{
                                           [Settings text:TextForApiKeyId]: (NSNumber*)[obj objectForKey:@"id_category"],
                                           [Settings text:TextForApiKeyTableState]: (NSNumber*)[obj objectForKey:@"load"],
                                           [Settings text:TextForApiKeyImage]: [Settings menuCatImgForId:catName],
                                           [Settings text:TextForApiKeyTitle]: [Settings menuCatTitleForId:catName],
                                           @"modificators":(NSArray*)[obj objectForKey:@"modificators"],
                                           };
                    
                    [data addObject:dict];
                    
                }
                self.contentData = [NSArray arrayWithArray:data];
                
                NSDictionary* dict = (NSDictionary*)[_contentData objectAtIndex:curIndex];
                self.categoryName = (NSString*)[dict objectForKey:@"title"];
                [self getSubData:dict];
            }
  
        }
        
        
    } failure:^(NSString *error) {
        [manager showAlertViewWithMess:ERROR_MESSAGE];
    }];
}
- (void)getSubData:(NSDictionary*)content{
    
    
    TheApp;
    
    BASManager* manager = [BASManager sharedInstance];
    
    NSDictionary* dict = @{
                           @"id_category": (NSNumber*)[content objectForKey:[Settings text:TextForApiKeyId]],
                           };
    
    
    [manager getData:[manager formatRequest:[Settings text:TextForApiFuncMenuCats] withParam:dict] success:^(id responseObject) {
        
        if([responseObject isKindOfClass:[NSDictionary class]]){
            
            NSArray* param = (NSArray*)[responseObject objectForKey:@"param"];
            NSLog(@"Response: %@",param);
            
            //if(param != nil && param.count > 0){
                
                NSMutableArray* data = [NSMutableArray new];
                
                
                for (int i = 0; i < param.count; i++) {
                    NSDictionary* dict = nil;
                    NSDictionary* obj = (NSDictionary*)[param objectAtIndex:i];
                    NSNumber* availability = (NSNumber*)[obj objectForKey:@"availability"];
                    if([availability intValue] == 1){
                        NSNumber* max_dish = (NSNumber*)[obj objectForKey:@"max_dish"];
                        if(max_dish != nil){
                            dict = @{
                                     @"id_dish": (NSNumber*)[obj objectForKey:@"id_dish"],
                                     @"name_dish": (NSNumber*)[obj objectForKey:@"name_dish"],
                                     @"price": (NSNumber*)[obj objectForKey:@"price"],
                                     @"weight": (NSNumber*)[obj objectForKey:@"weight"],
                                     @"availability": (NSNumber*)[obj objectForKey:@"availability"],
                                     @"max_dish": (NSNumber*)[obj objectForKey:@"max_dish"],
                                     };
                        } else {
                            dict = @{
                                     @"id_dish": (NSNumber*)[obj objectForKey:@"id_dish"],
                                     @"name_dish": (NSNumber*)[obj objectForKey:@"name_dish"],
                                     @"price": (NSNumber*)[obj objectForKey:@"price"],
                                     @"weight": (NSNumber*)[obj objectForKey:@"weight"],
                                     @"availability": (NSNumber*)[obj objectForKey:@"availability"],
                                     @"count_dish": (NSNumber*)[obj objectForKey:@"count_dish"],
                                     };
                        }
                        
                        if(app.orders != nil){
                            if(app.orders.count < i){
                                NSMutableDictionary *newDict = [[NSMutableDictionary alloc] init];
                                [newDict addEntriesFromDictionary:dict];
                                //[newDict setObject:[NSNumber numberWithInt:count] forKey:@"count_dish"];
                                
                                dict = [NSDictionary dictionaryWithDictionary:newDict];
                            }
                        }
                        
                        [data addObject:dict];
                    }
                }
                NSMutableArray* left = [NSMutableArray new];
                NSMutableArray* right = [NSMutableArray new];
                for(int i = 0; i < data.count; i++){
                    if(i % 2 == 0){
                        [left addObject:[data objectAtIndex:i]];
                    } else {
                        [right addObject:[data objectAtIndex:i]];
                    }
                }
                self.leftContentData = [NSArray arrayWithArray:left];
                self.rightContentData = [NSArray arrayWithArray:right];
                [self prepareView];
           // }
        }
    } failure:^(NSString *error) {
        [manager showAlertViewWithMess:ERROR_MESSAGE];
    }];
}
#pragma mark -
#pragma mark Table delegate methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == _tableView)
        return [_tableView hightCell:_tableView.typeTable];
    else
        return [_tableView hightCell:_tableLeftView.typeTable];
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
    NSDictionary* dict = nil;
    
    if(tableView == _tableView){
        curIndex = [indexPath row];
        dict = (NSDictionary*)[_contentData objectAtIndex:curIndex];
        self.categoryName = (NSString*)[dict objectForKey:@"title"];
        [self getSubData:dict];
    } else if(tableView == _tableLeftView){
        dict = (NSDictionary*)[_leftContentData objectAtIndex:[indexPath row]];
        BASDishViewController* controller = [BASDishViewController new];
        controller.contentData = dict;
        BASSubCategoryTableViewCell* cell = (BASSubCategoryTableViewCell*)[_tableLeftView cellForRowAtIndexPath:indexPath];
        if(!self.popover.popoverVisible){
            self.popover = nil;
            self.popover  = [[UIPopoverController alloc] initWithContentViewController:controller];
            [_popover setPopoverContentSize:CGSizeMake(320, 568)];
            [_popover presentPopoverFromRect:cell.bounds inView:cell permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        }
    }else if(tableView == _tableRightView){
        dict = (NSDictionary*)[_rightContentData objectAtIndex:[indexPath row]];
        BASDishViewController* controller = [BASDishViewController new];
        controller.contentData = dict;
        BASSubCategoryTableViewCell* cell = (BASSubCategoryTableViewCell*)[_tableRightView cellForRowAtIndexPath:indexPath];
        if(!self.popover.popoverVisible){
            self.popover = nil;
            self.popover  = [[UIPopoverController alloc] initWithContentViewController:controller];
            [_popover setPopoverContentSize:CGSizeMake(320, 568)];
            [_popover presentPopoverFromRect:cell.bounds inView:cell permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        }
    }
}


@end
