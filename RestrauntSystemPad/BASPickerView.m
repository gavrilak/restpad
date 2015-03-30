//
//  BASPickerView.m
//  RestrauntSystemPad
//
//  Created by Sergey on 28.07.14.
//  Copyright (c) 2014 BestAppStudio. All rights reserved.
//

#import "BASPickerView.h"

@interface BASPickerView(){
    BOOL state;
    NSInteger curRow;
    NSInteger curComponent;

}

@property (nonatomic,strong) UIPickerView *picker;
@property (nonatomic, strong)UIButton* doneButton;
@property (nonatomic, strong)UIButton* cancelButton;
@end

@implementation BASPickerView 

- (id)initWithFrame:(CGRect)frame  withContent:(NSArray*)content withDoneButton:(BOOL)_state withCancelButton:(BOOL) cancel
{
    self = [super initWithFrame:frame];
    if (self) {
        curRow = 0;
        curComponent = 0;
        state = _state;
       
        
        self.content = [NSArray arrayWithArray:content];
        
        CGRect rect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        if (cancel) {
            [self setBackgroundColor:[UIColor colorWithRed:150.0/255.0 green:150.0/255.0 blue:150.0/255.0 alpha:1.0]];
            UIImage* image = [UIImage imageNamed:@"btn_confirm.png"];
            self.doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [_doneButton setBackgroundColor:[UIColor clearColor]];
            [_doneButton setBackgroundImage:image forState:UIControlStateNormal];
            [_doneButton setFrame:CGRectMake(self.frame.size.width / 2 , self.frame.size.height - image.size.height - 20.f, image.size.width, image.size.height)];
            [_doneButton addTarget:self action:@selector(clikedButton:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:_doneButton];
            
            [self setBackgroundColor:[UIColor colorWithRed:150.0/255.0 green:150.0/255.0 blue:150.0/255.0 alpha:1.0]];
            image = [UIImage imageNamed:@"btn_cancellation.png"];
            self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [_cancelButton setBackgroundColor:[UIColor clearColor]];
            [_cancelButton setBackgroundImage:image forState:UIControlStateNormal];
            [_cancelButton setFrame:CGRectMake(5 , self.frame.size.height - image.size.height - 20.f, image.size.width, image.size.height)];
            [_cancelButton addTarget:self action:@selector(clikedCancelButton:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:_cancelButton];
        }
        else {
            if(state){
                [self setBackgroundColor:[UIColor colorWithRed:150.0/255.0 green:150.0/255.0 blue:150.0/255.0 alpha:1.0]];
                UIImage* image = [UIImage imageNamed:@"btn_confirm.png"];
                self.doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
                [_doneButton setBackgroundColor:[UIColor clearColor]];
                [_doneButton setBackgroundImage:image forState:UIControlStateNormal];
                [_doneButton setFrame:CGRectMake(self.frame.size.width / 2 - image.size.width / 2 - 3.f, self.frame.size.height - image.size.height - 20.f, image.size.width, image.size.height)];
                [_doneButton addTarget:self action:@selector(clikedButton:) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:_doneButton];
            
                rect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - image.size.height - 10.f);
            } else {
                [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_all.png"]]];
            }
        }
        self.picker = [[UIPickerView alloc]initWithFrame:rect];
        
        self.picker.dataSource = self;
        self.picker.delegate = self;
        [self.picker setUserInteractionEnabled:YES];
        
        [self addSubview:_picker];
   
    }
    return self;
}
- (void)selectRow:(NSInteger)row inComponent:(NSInteger)component{
    [_picker reloadAllComponents];
    [_picker selectRow:row inComponent:component animated:YES];
}
- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(!state){
        NSArray* data = (NSArray*)[_content objectAtIndex:component];
        NSString *title = (NSString*)[data objectAtIndex:row];
        NSAttributedString *attString = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:142.0/255.0 green:215.0/255.0 blue:249.0/255.0 alpha:1.0]}];
        
        
        return attString;
    }
    return  nil;
    
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return _content.count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return ((NSArray*)[_content objectAtIndex:component]).count;
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [((NSArray*)[_content objectAtIndex:component]) objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(component == 0){
        curRow = row;
    } else {
        curComponent = row;
    }
    if([self.delegate respondsToSelector:@selector(didSelect:withRow:withComponent:)]){
        [_delegate didSelect:self withRow:row withComponent:component];
    }
}
-(void)clikedButton:(id)sender{
    NSDictionary* dict = @{@"row1": [NSNumber numberWithInteger:curRow],
                           @"row2": [NSNumber numberWithInteger:curComponent]
                           };
    if([self.delegate respondsToSelector:@selector(doneClicked:withData:)]){
        [_delegate doneClicked:self withData:dict];
    }
}


-(void) clikedCancelButton:(id)sender{
    
   
    if([self.delegate respondsToSelector:@selector(cancelClicked:)]){
        [_delegate cancelClicked:self ];
    }
}
@end
