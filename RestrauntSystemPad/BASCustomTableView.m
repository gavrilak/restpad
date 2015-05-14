//
//  BASCustomTableView.m
//  RestrauntSystem
//
//  Created by Sergey on 06.06.14.
//  Copyright (c) 2014 BestAppStudio. All rights reserved.
//

#import "BASCustomTableView.h"
#import "BASCategoryTableViewCell.h"
#import "BASSubCategoryTableViewCell.h"
#import "BASNoticeTableViewCell.h"
#import "BASOrdersHistoryTableViewCell.h"
#import "BASEmployeeTableViewCell.h"
#import "BASWarehouseTableViewCell.h"
#import "BASRoomTableViewCell.h"
#import "UMTableViewCell.h"

@interface BASCustomTableView()


@property (nonatomic, assign)id <RCSDishCellItemDelegate> delegateDish;


@end

@implementation BASCustomTableView



- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style withContent:(NSArray*) content withType:(TableType)type withDelegate:(id) delegate{
    
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        self.contentData = [NSArray arrayWithArray:content];
        self.typeTable = type;
        self.delegateDish = delegate;
        
        [self setBackgroundColor:[UIColor clearColor]];
        [self setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [self setShowsHorizontalScrollIndicator:NO];
        [self setShowsVerticalScrollIndicator:NO];
        [self setBackgroundView: nil];
        self.dataSource = (id)self;
        
    }
    return self;
}
#pragma mark -
#pragma mark Public methods

#pragma mark -
#pragma mark Table view methods
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0,0,tableView.frame.size.width,20)];
    [headerView setBackgroundColor:[UIColor clearColor]];
    
    return headerView;
    
}

-(float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return  20.0;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if(_typeTable == SWIPE || _typeTable == VIRTUALTABLE){
        return _contentData.count;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(_typeTable == SWIPE || _typeTable == VIRTUALTABLE){
        return 1;
    }
    return [_contentData count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    NSDictionary* obj = (NSDictionary*)[_contentData objectAtIndex:[indexPath row]];
    if(_typeTable == SWIPE || _typeTable == VIRTUALTABLE){
         obj = (NSDictionary*)[_contentData objectAtIndex:[indexPath section]];
         return [self cellClass:obj withIndex:(NSInteger)[indexPath section]];
    }
    return [self cellClass:obj withIndex:(NSInteger)[indexPath row]];
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
}

#pragma mark -
#pragma mark Private methods

- (CGFloat)hightCell:(TableType)type{
   
    switch (type) {
        case CATEGORYTABLE:
            return 70.f;
            break;
        case SUBCATEGORYTABLE:
             return 126.f;
            break;
        case NOTICETABLE:
             return 50.f;
            break;
        case ORDERSLIST:
            return 75.f;
            break;
        case EMPLOYEER:
            return 50.f;
            break;
        case WAREWHOUSE:
            return 74.f;
            break;
        case HALLS:
            return 90.f;
            break;
        case VIRTUALTABLE:
        case SWIPE:
            return 105.5f;
            break;
        default:
            break;
    }
    
    return 0;
}
- (UITableViewCell*)cellClass:(NSDictionary*)obj withIndex:(NSInteger)index{
  
    static NSString *CellIdentifier = @"CustomCell";
    UITableViewCell* Cell = nil;
    
    switch (_typeTable) {
        case CATEGORYTABLE:{

            BASCategoryTableViewCell* cell = [[BASCategoryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier withContent:obj];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                
     
            Cell = cell;
        }
            break;
        case SUBCATEGORYTABLE:{

            BASSubCategoryTableViewCell* cell = [[BASSubCategoryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier withContent:obj];
            cell.delegate = _delegateDish;
            NSDictionary* dish = [obj objectForKey:@"dish"];
            if (dish == nil) {
                dish = obj;
            }
            cell.title = (NSString*)[dish objectForKey:@"name_dish"];
            NSLog(@"name_dish: %@", cell.title);
            cell.weight = [NSString stringWithFormat:@"%@ %@", [dish objectForKey:@"weight"], [dish objectForKey:@"unit_weight"]] ;
            cell.cost = [NSString stringWithFormat:@"%@ %@",[dish objectForKey:@"price"], [dish objectForKey:@"unit_price"]] ;
            cell.dishIdx = index;
            NSNumber* count_dish = (NSNumber*)[obj objectForKey:@"count_dish"];
            cell.count = [count_dish integerValue];
            if(count_dish == nil)
                cell.count = 0;
            NSNumber* id_status = (NSNumber*)[obj objectForKey:@"status"];
            cell.state = (OrderItemState)[id_status integerValue];
        
            TheApp;
            cell.isDishCount = app.isOrder;
            NSNumber* max_dish = (NSNumber*)[obj objectForKey:@"max_dish"];
            if(max_dish != nil){
                cell.countDish = [max_dish integerValue];
            }
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
          
            Cell = cell;
        }
            break;
        case NOTICETABLE:{

            BASNoticeTableViewCell *cell = [[BASNoticeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier withContent:obj];

            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
            Cell = cell;
        }
            break;
        case ORDERSLIST:{

            OrdersHistoryType type = CURRENTTYPE;
     
            NSNumber* status = (NSNumber*)[obj objectForKey:@"status"];
            if([status integerValue] == 2)
                type = ALLTYPE;
            
            BASOrdersHistoryTableViewCell *cell = [[BASOrdersHistoryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier withContent:obj withType:type];
  
                
            NSNumber* cost ;
            if(type != ALLTYPE ) {
                cost = (NSNumber*)[obj objectForKey:@"cost"];
            } else {
                cost = (NSNumber*)[obj objectForKey:@"cost_discount"];
            }
            [cell.textView setText:[NSString stringWithFormat:@"%d грн",[cost integerValue]]];

            NSNumber* number_table = (NSNumber*)[obj objectForKey:@"number_table"];
            [cell.numberView setText:[NSString stringWithFormat:@"%d",[number_table integerValue]]];
            
            NSString* time = (NSString*)[obj objectForKey:@"finish_time"];
            if(type == ALLTYPE && time != nil){
                NSArray* sort = [time componentsSeparatedByString:@" "];
                time = [NSString stringWithFormat:@"%@",[sort objectAtIndex:1]];
                sort = [time componentsSeparatedByString:@":"];
                cell.timeView.text = [NSString stringWithFormat:@"%@:%@",[sort objectAtIndex:0],[sort objectAtIndex:1]];
                cell.priceView.text = [NSString stringWithFormat:@"%@%%",[[obj objectForKey:@"client"] objectForKey:@"discount"]];
                cell.discountView.text = [NSString stringWithFormat:@"%.2f грн",[[obj objectForKey:@"discount"] floatValue]];
            }
            
            
            cell.status = [status integerValue];
            
            
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

            Cell = cell;
        }
            break;
            
        case EMPLOYEER:{
                BASEmployeeTableViewCell *cell = [[BASEmployeeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier withContent:obj];
                cell.delegate = (id)_delegateDish;
                cell.index = index;
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                
                Cell = cell;

            }
            break;
        case WAREWHOUSE:{
            BASWarehouseTableViewCell *cell = [[BASWarehouseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier withContent:obj];
            cell.index = index;
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            
            Cell = cell;
            
        }
            break;
        case HALLS:{
            
            BASRoomTableViewCell* cell = [[BASRoomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier withContent:obj];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            
            
            Cell = cell;
        }
            break;
         
        case VIRTUALTABLE:
            obj = [obj objectForKey:@"dish"];
            
        case SWIPE:{
      
            UMTableViewCell* cell = [[UMTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier withContent:obj];
            cell.rightUtilityButtons = [self rightButtons];
            //[cell setRightUtilityButtons:[self rightButtons] WithButtonWidth:58.0f];
            
            cell.delegate = (id)_delegateDish;
            cell.title = (NSString*)[obj objectForKey:@"name_dish"];
            NSLog(@"name_dish: %@", cell.title);
            cell.weight = [NSString stringWithFormat:@"%@ %@", [obj objectForKey:@"weight"], [obj objectForKey:@"unit_weight"]] ;
            cell.cost = [NSString stringWithFormat:@"%@ %@",[obj objectForKey:@"price"], [obj objectForKey:@"unit_price"]] ;
            cell.dishIdx = index;
            NSNumber* count_dish = (NSNumber*)[obj objectForKey:@"count_dish"];
            cell.count = [count_dish integerValue];
            if(count_dish == nil)
                cell.count = 0;
            NSNumber* id_status = (NSNumber*)[obj objectForKey:@"status"];
            cell.state = (OrderItemState)[id_status integerValue];
            
            TheApp;
            cell.isDishCount = app.isOrder;
            NSNumber* max_dish = (NSNumber*)[obj objectForKey:@"max_dish"];
            if(max_dish != nil){
                cell.countDish = [max_dish integerValue];
            }
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
            
            
            Cell = cell;
        }
            break;
        default:
            break;
    }
    
    return Cell;
}
- (NSArray *)rightButtons
{
    TheApp;
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    if(app.isVirtual){
        [rightUtilityButtons sw_addUtilityButtonWithColor:
         [UIColor colorWithRed:0.78f green:0.78f blue:0.8f alpha:1.0]
                                                icon:[UIImage imageNamed:@"move.png"]];
    }
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:1.0f green:0.231f blue:0.188 alpha:1.0f]
                                                icon:[UIImage imageNamed:@"delete.png"]];
    
    return rightUtilityButtons;
}


@end
