//
//  BASSortView.m
//  RestrauntSystemPad
//
//  Created by Sergey on 25.07.14.
//  Copyright (c) 2014 BestAppStudio. All rights reserved.
//

#import "BASSortView.h"

@interface BASSortView(){
    UIButton* curTopButton;
    UIButton* curBottomButton;

}

@property (nonatomic, strong)UIButton* orderBt;
@property (nonatomic, strong)UIButton* orderBt1;
@property (nonatomic, strong)UIButton* dateBt;
@property (nonatomic, strong)UIButton* dateBt1;
@property (nonatomic, strong)UIButton* tableBt;
@property (nonatomic, strong)UIButton* tableBt1;
@property (nonatomic, strong)UIButton* waiterBt;
@property (nonatomic, strong)UIButton* waiterBt1;
@property (nonatomic, strong)UIButton* searchBt;
@property(nonatomic, strong) UITextField *textFieldSearch;

@end


@implementation BASSortView


- (void)setDateString:(NSString *)dateString{
    _dateString = dateString;
    [_dateBt1 setTitle:_dateString forState:UIControlStateNormal];
    [_dateBt1 setTitle:_dateString forState:UIControlStateHighlighted];
    [_dateBt1 setTitle:_dateString forState:UIControlStateSelected];
}
- (void)setTableString:(NSString *)tableString{
    _tableString = tableString;
    [_tableBt1 setTitle:_tableString forState:UIControlStateNormal];
    [_tableBt1 setTitle:_tableString forState:UIControlStateHighlighted];
    [_tableBt1 setTitle:_tableString forState:UIControlStateSelected];
}
-(void)setWaiterString:(NSString *)waiterString{
    _waiterString = waiterString;
    [_waiterBt1 setTitle:_waiterString forState:UIControlStateNormal];
    [_waiterBt1 setTitle:_waiterString forState:UIControlStateHighlighted];
    [_waiterBt1 setTitle:_waiterString forState:UIControlStateSelected];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGRect frame= self.frame;
        [self setBackgroundColor:[UIColor clearColor]];
        UIImage* image = [UIImage imageNamed:@"small_cell.png"];
        
        self.orderBt = [UIButton buttonWithType:UIButtonTypeCustom];
        [_orderBt setBackgroundColor:[UIColor clearColor]];
        [_orderBt setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_orderBt setTitleColor:[UIColor colorWithRed:142.0/255.0 green:215.0/255.0 blue:249.0/255.0 alpha:1.0] forState:UIControlStateHighlighted];
        [_orderBt setTitleColor:[UIColor colorWithRed:142.0/255.0 green:215.0/255.0 blue:249.0/255.0 alpha:1.0] forState:UIControlStateSelected];
        [_orderBt setTitle:@"Заказы" forState:UIControlStateNormal];
        [_orderBt setTitle:@"Заказы" forState:UIControlStateHighlighted];
        [_orderBt setTitle:@"Заказы" forState:UIControlStateSelected];
        [_orderBt addTarget:self action:@selector(clikedButton:) forControlEvents:UIControlEventTouchUpInside];
        [_orderBt setFrame:CGRectMake(1, 0, 70.f, 25.f)];
        [_orderBt setSelected:YES];
        curTopButton = _orderBt;
        [self addSubview:_orderBt];
        
        self.orderBt1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_orderBt1 setBackgroundColor:[UIColor clearColor]];
        [_orderBt1.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:14.f]];
        [_orderBt1 setBackgroundImage:image forState:UIControlStateNormal];
        [_orderBt1 setBackgroundImage:image forState:UIControlStateHighlighted];
        [_orderBt1 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_orderBt1 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        [_orderBt1 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateSelected];
        [_orderBt1 setTitle:@"Все" forState:UIControlStateNormal];
        [_orderBt1 setTitle:@"Все" forState:UIControlStateHighlighted];
        [_orderBt1 setTitle:@"Все" forState:UIControlStateSelected];
        [_orderBt1 addTarget:self action:@selector(clikedSubButton:) forControlEvents:UIControlEventTouchUpInside];
        [_orderBt1 setFrame:CGRectMake(_orderBt.frame.origin.x +  _orderBt.frame.size.width / 2 - image.size.width / 2, 25.f, image.size.width, image.size.height)];
        [self addSubview:_orderBt1];
        
        UIImageView* separator1= [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"delimiter_small.png"]];
        [separator1 setFrame:CGRectMake(71.f, 10.f, 5.5f, 38.f)];
        [self addSubview:separator1];
        
        self.dateBt = [UIButton buttonWithType:UIButtonTypeCustom];
        [_dateBt setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_dateBt setBackgroundColor:[UIColor clearColor]];
        [_dateBt setTitleColor:[UIColor colorWithRed:142.0/255.0 green:215.0/255.0 blue:249.0/255.0 alpha:1.0] forState:UIControlStateHighlighted];
        [_dateBt setTitleColor:[UIColor colorWithRed:142.0/255.0 green:215.0/255.0 blue:249.0/255.0 alpha:1.0] forState:UIControlStateSelected];
        [_dateBt setTitle:@"Дата" forState:UIControlStateNormal];
        [_dateBt setTitle:@"Дата" forState:UIControlStateHighlighted];
        [_dateBt setTitle:@"Дата" forState:UIControlStateSelected];
        [_dateBt addTarget:self action:@selector(clikedButton:) forControlEvents:UIControlEventTouchUpInside];
        [_dateBt setFrame:CGRectMake(75.5f, 0, 70.f, 25.f)];
        [self addSubview:_dateBt];
        
        self.dateBt1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_dateBt1 setBackgroundColor:[UIColor clearColor]];
        [_dateBt1.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:14.f]];
        [_dateBt1 setBackgroundImage:[image stretchableImageWithLeftCapWidth:5.f topCapHeight:0] forState:UIControlStateNormal];
        [_dateBt1 setBackgroundImage:[image stretchableImageWithLeftCapWidth:5.f topCapHeight:0] forState:UIControlStateHighlighted];
        [_dateBt1 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_dateBt1 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        [_dateBt1 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateSelected];
        [_dateBt1 setTitle:@"" forState:UIControlStateNormal];
        [_dateBt1 setTitle:@"" forState:UIControlStateHighlighted];
        [_dateBt1 setTitle:@"" forState:UIControlStateSelected];
        [_dateBt1 addTarget:self action:@selector(clikedSubButton:) forControlEvents:UIControlEventTouchUpInside];
        [_dateBt1 setFrame:CGRectMake(_dateBt.frame.origin.x +  _dateBt.frame.size.width / 2 - image.size.width / 2 - 5.f, 25.f, image.size.width + 10.f, image.size.height)];
        [self addSubview:_dateBt1];

        
        UIImageView* separator2= [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"delimiter_small.png"]];
        [separator2 setFrame:CGRectMake(145.f, 10.f, 5.5f, 38.f)];
        [self addSubview:separator2];
        
        
        self.tableBt = [UIButton buttonWithType:UIButtonTypeCustom];
        [_tableBt setBackgroundColor:[UIColor clearColor]];
        [_tableBt setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_tableBt setTitleColor:[UIColor colorWithRed:142.0/255.0 green:215.0/255.0 blue:249.0/255.0 alpha:1.0] forState:UIControlStateHighlighted];
        [_tableBt setTitleColor:[UIColor colorWithRed:142.0/255.0 green:215.0/255.0 blue:249.0/255.0 alpha:1.0] forState:UIControlStateSelected];
        [_tableBt setTitle:@"Столы" forState:UIControlStateNormal];
        [_tableBt setTitle:@"Столы" forState:UIControlStateHighlighted];
        [_tableBt setTitle:@"Столы" forState:UIControlStateSelected];
        [_tableBt addTarget:self action:@selector(clikedButton:) forControlEvents:UIControlEventTouchUpInside];
        [_tableBt setFrame:CGRectMake(149.f, 0, 66.f, 25.f)];
        [self addSubview:_tableBt];
        
        
        self.tableBt1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_tableBt1 setBackgroundColor:[UIColor clearColor]];
        [_tableBt1.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:14.f]];
        [_tableBt1 setBackgroundImage:image forState:UIControlStateNormal];
        [_tableBt1 setBackgroundImage:image forState:UIControlStateHighlighted];
        [_tableBt1 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_tableBt1 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        [_tableBt1 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateSelected];
        [_tableBt1 setTitle:@"Все" forState:UIControlStateNormal];
        [_tableBt1 setTitle:@"Все" forState:UIControlStateHighlighted];
        [_tableBt1 setTitle:@"Все" forState:UIControlStateSelected];
        [_tableBt1 addTarget:self action:@selector(clikedSubButton:) forControlEvents:UIControlEventTouchUpInside];
        [_tableBt1 setFrame:CGRectMake(_tableBt.frame.origin.x +  _tableBt.frame.size.width / 2 - image.size.width / 2, 25.f, image.size.width, image.size.height)];
        [self addSubview:_tableBt1];
        
        
        UIImageView* separator3= [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"delimiter_small.png"]];
        [separator3 setFrame:CGRectMake(215.f, 10.f, 5.5f, 38.f)];
        [self addSubview:separator3];
        
        
        self.waiterBt = [UIButton buttonWithType:UIButtonTypeCustom];
        [_waiterBt setBackgroundColor:[UIColor clearColor]];
        [_waiterBt setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_waiterBt setTitleColor:[UIColor colorWithRed:142.0/255.0 green:215.0/255.0 blue:249.0/255.0 alpha:1.0] forState:UIControlStateHighlighted];
        [_waiterBt setTitleColor:[UIColor colorWithRed:142.0/255.0 green:215.0/255.0 blue:249.0/255.0 alpha:1.0] forState:UIControlStateSelected];
        [_waiterBt setTitle:@"Официанты" forState:UIControlStateNormal];
        [_waiterBt setTitle:@"Официанты" forState:UIControlStateHighlighted];
        [_waiterBt setTitle:@"Официанты" forState:UIControlStateSelected];
        [_waiterBt addTarget:self action:@selector(clikedButton:) forControlEvents:UIControlEventTouchUpInside];
        [_waiterBt setFrame:CGRectMake(214.f, 0, frame.size.width - 221.f, 25.f)];
        [self addSubview:_waiterBt];
        
        self.waiterBt1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_waiterBt1 setBackgroundColor:[UIColor clearColor]];
        [_waiterBt1.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:14.f]];
        [_waiterBt1 setBackgroundImage:[image stretchableImageWithLeftCapWidth:5.f topCapHeight:0]  forState:UIControlStateNormal];
        [_waiterBt1 setBackgroundImage:[image stretchableImageWithLeftCapWidth:5.f topCapHeight:0] forState:UIControlStateHighlighted];
        [_waiterBt1 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_waiterBt1 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        [_waiterBt1 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateSelected];
        [_waiterBt1 setTitle:@"Все" forState:UIControlStateNormal];
        [_waiterBt1 setTitle:@"Все" forState:UIControlStateHighlighted];
        [_waiterBt1 setTitle:@"Все" forState:UIControlStateSelected];
        [_waiterBt1 addTarget:self action:@selector(clikedSubButton:) forControlEvents:UIControlEventTouchUpInside];
        [_waiterBt1 setFrame:CGRectMake(_waiterBt.frame.origin.x +  _waiterBt.frame.size.width / 2 - image.size.width / 2 - 20.f, 25.f, image.size.width +40.f, image.size.height)];
        [self addSubview:_waiterBt1];

        
        
        
       /* image = [UIImage imageNamed:@"search_s.png"];
        self.searchBt = [UIButton buttonWithType:UIButtonTypeCustom];
        [_searchBt setBackgroundColor:[UIColor clearColor]];
        [_searchBt setBackgroundImage:image forState:UIControlStateNormal];
        [_searchBt setBackgroundImage:[UIImage imageNamed:@"search_hover.png"] forState:UIControlStateHighlighted];
        [_searchBt setFrame:CGRectMake( frame.size.width / 2 - image.size.width / 2 - 3.f, frame.size.height - image.size.height - 10.f, image.size.width, image.size.height)];
        [self addSubview:_searchBt];
        
        CGRect rect = _searchBt.frame;
        self.textFieldSearch = [[UITextField alloc]initWithFrame:CGRectMake(rect.origin.x + 25.f, rect.origin.y, rect.size.width - 60.f, rect.size.height)];
        [_textFieldSearch setBackgroundColor:[UIColor clearColor]];
        _textFieldSearch.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textFieldSearch.delegate = (id)self;
        [self addSubview:_textFieldSearch];*/
        
        
    }
    return self;
}
- (void)clikedButton: (id)sender{

    
    
    UIButton* button = (UIButton*)sender;
    [_orderBt setSelected:NO];
    [_dateBt setSelected:NO];
    [_tableBt setSelected:NO];
    [_waiterBt setSelected:NO];
    [button setSelected:YES];
    curTopButton = button;
    
    SortState state = ALLORDERS;
    
    if(button == _orderBt){
        state = ALLORDERS;
    } else if(button == _dateBt){
        state = ALLORDERSBYDATE;
    } else if(button == _tableBt){
        state = ALLORDERSBYTABLE;
    } else if(button == _waiterBt){
        state = ALLORDERSBYEMPLOYEE;
    }

    if([_delegate respondsToSelector:@selector(closedatePicker:)]){
        [_delegate closedatePicker:self];
    }
 
    
    if([_delegate respondsToSelector:@selector(sortChoice:withType:)]){
        [_delegate sortChoice:self withType:state];
    }

}
- (void)clikedSubButton: (id)sender{
    
    UIButton* button = (UIButton*)sender;
    curBottomButton = button;
    if(button == _dateBt1 && [_dateBt isSelected]){
        if([_delegate respondsToSelector:@selector(closedatePicker:withType:)]){
            [_delegate closedatePicker:self withType:ALLORDERSBYDATE];
        }
    } else if(button == _tableBt1 && [_tableBt isSelected]){
        if([_delegate respondsToSelector:@selector(closedatePicker:withType:)]){
            [_delegate closedatePicker:self withType:ALLORDERSBYTABLE];
        }
    } else if(button == _waiterBt1 && [_waiterBt isSelected]){
        if([_delegate respondsToSelector:@selector(closedatePicker:withType:)]){
            [_delegate closedatePicker:self withType:ALLORDERSBYEMPLOYEE];
        }
    }
   /* SortState state = ALLORDERS;
    
    if(button == _orderBt1 && [_orderBt isSelected]){
        state = ALLORDERS;
    } else if(button == _dateBt1 && [_dateBt1 isSelected]){
        state = ALLORDERSBYDATE;
    } else if(button == _tableBt1 && [_tableBt isSelected]){
        state = ALLORDERSBYTABLE;
    } else if(button == _waiterBt1 && [_waiterBt isSelected]){
        state = ALLORDERSBYEMPLOYEE;
    }
    
    if([_delegate respondsToSelector:@selector(sortChoice:withType:)]){
        [_delegate sortChoice:self withType:state];
    }*/
        
    
}

#pragma mark - UITextFieldDelegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
#if DEBUG
    
#endif
    
    textField.layer.borderColor = [UIColor clearColor].CGColor;
    
    return YES;
}

@end
