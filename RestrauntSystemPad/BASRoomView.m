//
//  BASRoomView.m
//  RestrauntSystem
//
//  Created by Sergey on 06.06.14.
//  Copyright (c) 2014 BestAppStudio. All rights reserved.
//

#import "BASRoomView.h"


#define MAXTABLES 12
#define TABLERECT CGRectMake(0, 0, 150.f, 150.f)

@interface BASRoomView()

@property (nonatomic,strong)NSArray* tables;
@property (nonatomic,strong)NSArray* tablesRect;
@property (nonatomic,strong)UIView* roomView;
@property (nonatomic,assign)RoomType type;
@property(nonatomic ,strong) UIScrollView* scrollView;
@end

@implementation BASRoomView


@synthesize delegate = _delegate;
@synthesize contentData = _contentData;
@synthesize indexRoom = _indexRoom;

- (void)setContentData:(NSDictionary *)contentData{
    _contentData = nil;
    _contentData = contentData;
    
    if(self.roomView != nil){
        [self clearRoom];
        [self createRoom];
    }
}
- (id)initWithFrame:(CGRect)frame withContent:(NSDictionary*)contentData withIndex:(NSInteger)index withType:(RoomType)typeRoom
{
    self = [super initWithFrame:frame];
    if (self) {
        self.type = typeRoom;
        self.tables = nil;
        self.indexRoom = index;
        self.contentData = [NSDictionary dictionaryWithDictionary:contentData];

        [self setBackgroundColor:[UIColor clearColor]];
        //[self setBackground];
        self.scrollView = [UIScrollView new];
        _scrollView.showsVerticalScrollIndicator=NO;
        _scrollView.scrollEnabled=YES;
        _scrollView.userInteractionEnabled=YES;
        [_scrollView setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [_scrollView setBackgroundColor:[UIColor clearColor]];
        [self addSubview:_scrollView];
        
    }
    return self;
}

#pragma mark - Public methods
- (void)createRoom{
    if(_contentData != nil){
        self.roomView = [self initRoom];
        [_scrollView addSubview:_roomView];
    }
}
#pragma mark - Private methods
- (void)clearRoom{
    [self.roomView removeFromSuperview];
    self.roomView = nil;
    self.tables = nil;
    
}
- (void)setBackground{
    [self setBackgroundColor:[UIColor clearColor]];
    UIImageView *bgImg = [[UIImageView alloc] initWithImage:[Settings image:ImageForControllerViewBg]];
    CGFloat bgImgTop = -20;
    bgImg.frame = CGRectMake(bgImg.frame.origin.x,
                             bgImgTop,
                             [Settings screenWidth],
                             [Settings screenHeight] - [Settings image:ImageForNavBarBg].size.height - [Settings image:ImageForTabBarBg].size.height);
    
    [self addSubview:bgImg];
}


- (UIView*)initRoom{
    
    UIView* contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 677.f, 548.f)];
    [contentView setBackgroundColor:[UIColor clearColor]];
    
    CGRect rect = TABLERECT;
    
    CGFloat posX = 40.f;
    CGFloat posY = -10.f;
    
    if(_contentData != nil){
        NSInteger tablesCount = [((NSNumber*)[_contentData objectForKey:@"tables_count"]) integerValue];
        NSMutableArray* tbls = [NSMutableArray new];
        NSMutableArray* tblsRect = [NSMutableArray new];
    
        if(_type ==  FIRSTROOM){
            for (int i = 0; i < tablesCount; i++) {
                if(i % 3 == 0 && i > 0){
                    posX = 40.f;
                    posY += rect.size.height;
                }
                BASTableView *obj = [[BASTableView alloc]initWithFrame:TABLERECT];
                [obj setFrame:CGRectMake(posX, posY, rect.size.width, rect.size.height)];
                [tblsRect addObject:[NSValue valueWithCGRect:CGRectMake(posX, posY, rect.size.width, rect.size.height)]];
                obj.delegate = (id<BASTableViewDelegate>)self;
                obj.indexTable = i;
                obj.num_table = i+1;
                obj.indexRoom = _indexRoom;
                obj.tableState = TableStateFree;
                if(i < tablesCount){
                    NSArray* tables = (NSArray*)[_contentData objectForKey:@"tables"];
                    NSDictionary* dict = (NSDictionary*)[tables objectAtIndex:i];
                    NSNumber* tablStatus = (NSNumber*)[dict objectForKey:@"table_status"];
                    obj.tableState = (TableState)[tablStatus integerValue];
                    if(obj.tableState != TableStateFree){
                        NSDictionary* employee = (NSDictionary*)[dict objectForKey:@"employee"];
                        obj.waiterName = (NSString*)[employee objectForKey:@"surname"];
                    }
                }
                
                [contentView addSubview:obj];

                posX += rect.size.width + 30.f;
                
                [tbls addObject:contentView];
                
                
                
            }
            UIImage* img = [Settings image:ImageForHallsBar];
            
            CGFloat centerX = (rect.size.width * 2) + rect.size.width / 2 + 16.f;
            CGFloat centerY = posY + rect.size.height;
            posX = centerX - img.size.width / 2 + 85.f;
            posY = centerY - 145.f;
            
            UIImageView* barImageView = [[UIImageView alloc]initWithImage:img];
            [barImageView setFrame:CGRectMake(posX, posY, img.size.width, img.size.height)];
            [self addSubview:barImageView];
            
            
            img = [Settings image:ImageForHallsDoor];
            UIImageView* doorImageView = [[UIImageView alloc]initWithImage:img];
            [doorImageView setFrame:CGRectMake(150.f, self.frame.size.height - img.size.height, img.size.width, img.size.height)];
            [self addSubview:doorImageView];

        }else if(_type ==  SECONDROOM){
            
            for (int i = 0; i < tablesCount; i++) {
                if(i == 5 || i == 8){
                    posX = 40.f;
                    posY += rect.size.height;
                }
                BASTableView *obj = [[BASTableView alloc]initWithFrame:TABLERECT];
                [obj setFrame:CGRectMake(posX, posY, rect.size.width, rect.size.height)];
                [tblsRect addObject:[NSValue valueWithCGRect:CGRectMake(posX, posY, rect.size.width, rect.size.height)]];
                obj.delegate = (id<BASTableViewDelegate>)self;
                obj.indexTable = i;
                obj.num_table = i+1;
                obj.indexRoom = _indexRoom;
                obj.tableState = TableStateFree;
                if(i < tablesCount){
                    NSArray* tables = (NSArray*)[_contentData objectForKey:@"tables"];
                    NSDictionary* dict = (NSDictionary*)[tables objectAtIndex:i];
                    NSNumber* tablStatus = (NSNumber*)[dict objectForKey:@"table_status"];
                    obj.tableState = (TableState)[tablStatus integerValue];
                    if(obj.tableState != TableStateFree){
                        NSDictionary* employee = (NSDictionary*)[dict objectForKey:@"employee"];
                        obj.waiterName = (NSString*)[employee objectForKey:@"surname"];
                    }
                }
                
                [contentView addSubview:obj];
                
                if(i == 0){
                    posX += 2* (rect.size.width + 30.f);
                }
                else if(i == 1){
                    posX = 40.f;
                    posY += rect.size.height;
                }
                else
                    posX += rect.size.width + 30.f;
                
                [tbls addObject:contentView];
                
                
                
            }
        
            
            
            UIImage* img = [UIImage imageNamed:@"door_vert.png"];
            UIImageView* doorImageView = [[UIImageView alloc]initWithImage:img];
            
            [doorImageView setFrame:CGRectMake(self.frame.size.width - img.size.width, self.frame.size.height - img.size.height - 190.f, img.size.width, img.size.height)];
            [self addSubview:doorImageView];
        } else if(_type ==  THIRDROOM){
            
            NSInteger j = -1;
            BOOL key = YES;
            
            
            for (int i = 0; i < tablesCount; i++) {
                if(i % 3 == 0 && i > 0 && key){
                    posX = 40.f;
                    posY += rect.size.height;
                }
                if(i == 13){
                    key = NO;
                    posX = 40.f;
                    posY += rect.size.height;
                    j++;
                }
                if(i > 13){
                    j++;
                }
                if(j % 3 == 0  && !key && j > 0){
                    posX = 40.f;
                    posY += rect.size.height;
                }

                BASTableView *obj = [[BASTableView alloc]initWithFrame:TABLERECT];
                [obj setFrame:CGRectMake(posX, posY, rect.size.width, rect.size.height)];
                [tblsRect addObject:[NSValue valueWithCGRect:CGRectMake(posX, posY, rect.size.width, rect.size.height)]];
                obj.delegate = (id<BASTableViewDelegate>)self;
                obj.indexTable = i;
                obj.num_table = i+1;
                obj.indexRoom = _indexRoom;
                obj.tableState = TableStateFree;
                if(i < tablesCount){
                    NSArray* tables = (NSArray*)[_contentData objectForKey:@"tables"];
                    NSDictionary* dict = (NSDictionary*)[tables objectAtIndex:i];
                    NSNumber* tablStatus = (NSNumber*)[dict objectForKey:@"table_status"];
                    obj.tableState = (TableState)[tablStatus integerValue];
                    if(obj.tableState != TableStateFree){
                        NSDictionary* employee = (NSDictionary*)[dict objectForKey:@"employee"];
                        obj.waiterName = (NSString*)[employee objectForKey:@"surname"];
                    }
                }
                
                [contentView addSubview:obj];
                
                posX += rect.size.width + 30.f;
                
                [tbls addObject:contentView];
                
                UIImage* img = [UIImage imageNamed:@"door_vert.png"];
                UIImageView* doorImageView = [[UIImageView alloc]initWithImage:img];
                
                [doorImageView setFrame:CGRectMake(self.frame.size.width - img.size.width, self.frame.size.height - img.size.height - 280.f, img.size.width, img.size.height)];
                [self addSubview:doorImageView];
                 [_scrollView setContentSize:CGSizeMake(self.frame.size.width,  posY + 150.f)];
                
            }

        }else if(_type ==  FOURTHROOM){
            NSInteger j = -1;
            BOOL key = YES;
            for (int i = 0; i < tablesCount; i++) {
                
                if(i == 2){
                    posX = 40.f;
                    posY += rect.size.height;
                }
                if(i == 4){
                    key = NO;
                    posX = 40.f;
                    posY += rect.size.height;
                    j++;
                }
                if(i > 4){
                    j++;
                }
                if(j % 3 == 0  && !key && j > 0){
                    posX = 40.f;
                    posY += rect.size.height;
                }
                
                BASTableView *obj = [[BASTableView alloc]initWithFrame:TABLERECT];
                [obj setFrame:CGRectMake(posX, posY, rect.size.width, rect.size.height)];
                obj.delegate = (id<BASTableViewDelegate>)self;
                obj.indexTable = i;
                obj.num_table = i+1;
                obj.indexRoom = _indexRoom;
                obj.tableState = TableStateFree;
                if(i < tablesCount){
                    NSArray* tables = (NSArray*)[_contentData objectForKey:@"tables"];
                    NSDictionary* dict = (NSDictionary*)[tables objectAtIndex:i];
                    NSNumber* tablStatus = (NSNumber*)[dict objectForKey:@"table_status"];
                    obj.tableState = (TableState)[tablStatus integerValue];
                    if(obj.tableState != TableStateFree){
                        NSDictionary* employee = (NSDictionary*)[dict objectForKey:@"employee"];
                        obj.waiterName = (NSString*)[employee objectForKey:@"surname"];
                    }
                }
                
                [contentView addSubview:obj];
                
                posX += rect.size.width + 30.f;
                [tbls addObject:contentView];
                [tblsRect addObject:[NSValue valueWithCGRect:CGRectMake(posX, posY, rect.size.width, rect.size.height)]];
            }
            
            UIImage* img = [Settings image:ImageForHallsDoor];
            UIImageView* doorImageView = [[UIImageView alloc]initWithImage:img];
            [doorImageView setFrame:CGRectMake(self.frame.size.width - 249.f, self.frame.size.height - img.size.height, img.size.width, img.size.height)];
            [self addSubview:doorImageView];
            
            img = [Settings image:ImageForHallsBar];
       
            
            UIImageView* barImageView = [[UIImageView alloc]initWithImage:img];
            [barImageView setFrame:CGRectMake(self.frame.size.width  - img.size.width - 40.f, self.frame.size.height - img.size.height - 200.f, img.size.width, img.size.height)];
            [self addSubview:barImageView];
            
            
            [self addSubview:doorImageView];
            [_scrollView setContentSize:CGSizeMake(self.frame.size.width,  posY + 150.f)];
        }

        
        
        
        self.tablesRect = [NSArray arrayWithArray:tblsRect];
        self.tables = [NSArray arrayWithArray:tbls];
    }

    
    
    return  contentView;
}
#pragma mark - BASTableViewDelegate methods
- (void)onClicked:(BASTableView*)view withIndexRoom:(NSInteger)indexRoom withIndexTable:(NSInteger)indexTable{
    if([_delegate respondsToSelector:@selector(selectTable:withIndexRoom:withTableRect:withIndexTable:)]){
        CGRect rect = [[_tablesRect objectAtIndex:indexTable] CGRectValue];
        [_delegate selectTable:self withIndexRoom:indexRoom withTableRect:rect withIndexTable:indexTable];
    }
}

@end
