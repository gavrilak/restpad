//
//  UMTableViewCell.m
//  SWTableViewCell
//
//  Created by Matt Bowman on 12/2/13.
//  Copyright (c) 2013 Chris Wendel. All rights reserved.
//

#import "UMTableViewCell.h"

@interface UMTableViewCell()


@property(nonatomic,strong)  UIImageView    *bgView;
@property(nonatomic, strong) UILabel        *lblTitle;
@property(nonatomic, strong) UILabel        *lblCost;
@property(nonatomic, strong) UILabel        *lblWeight;
@property(nonatomic, strong) UILabel        *lblCount;

@property(nonatomic, strong) UIButton       *btnPlus;
@property(nonatomic, strong) UIButton       *btnMinus;
@property(nonatomic, strong) UIButton       *btnPrepare;
@property(nonatomic, strong) UIButton       *btnModificat;

@property(nonatomic, strong) UIImageView    *imgViewBg;
@property(nonatomic, strong) UIImageView    *imgViewMods;
@property(nonatomic, strong) UIImageView    *imgViewState;
@end

@implementation UMTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withContent:(NSDictionary*)contentData{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentData = [NSDictionary dictionaryWithDictionary:contentData];
        
        [self setBackgroundColor:[UIColor clearColor]];
        
        [self setupBgView];

        
        
    }
    return self;
}
#pragma mark - Private methods
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    CGRect frame = self.contentView.frame;
    
    UIImage* img = (UIImage*)[Settings image:ImageForDishCellBg];
    [_bgView setFrame:CGRectMake(5.f, frame.size.height - img.size.height, frame.size.width - 10.f, img.size.height)];
 
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
}
- (void)setTitle:(NSString *)title
{
    _title = title;
    
    if (!self.lblTitle) {
        CGRect rect = CGRectMake(30.f,
                                 10.f,
                                 260.f,
                                 [Settings fontSize:FontForDishCellTitle] * 2 + [Settings correction:CorrectionForLblHeightFromFontSize]* 2);
        self.lblTitle = [self setupLabelWithFrame:rect
                                          andFont:[Settings font:FontForDishCellTitle]
                                     andTextColor:[Settings color:ColorForDishCellTitle]];
    }
    
    self.lblTitle.text = [NSString stringWithFormat:[Settings text:TextForDishCellTitleFormat], title];
     self.lblTitle.numberOfLines = 0;
     self.lblTitle.textAlignment = NSTextAlignmentCenter;
}

- (void)setWeight:(NSString*)weight
{
    _weight = weight;
    
    if (!self.lblWeight) {
        CGRect rect = CGRectMake(12.f,
                   75.5f,
                   50.f,
                [Settings fontSize:FontForDishCellWeight] + [Settings correction:CorrectionForLblHeightFromFontSize]);
        self.lblWeight = [self setupLabelWithFrame:rect
                                           andFont:[Settings font:FontForDishCellWeight]
                                      andTextColor:[Settings color:ColorForDishCellWeight]];
    }
    self.lblWeight.textAlignment = NSTextAlignmentLeft;
    self.lblWeight.text = _weight;
    //self.lblWeight.text = [NSString stringWithFormat:[Settings text:TextForDishCellWeightFormat], weight, [Settings text:TextForWeightUnit]];
}

- (void)setCost:(NSString*)cost
{
    _cost = cost;
    
    if (!self.lblCost) {
        CGRect rect = CGRectMake(75.f,
                                 60.f,
                                 190.f,
                                 [Settings fontSize:FontForDishCellCost] + [Settings correction:CorrectionForLblHeightFromFontSize]);
        self.lblCost = [self setupLabelWithFrame:rect
                                         andFont:[Settings font:FontForDishCellCost]
                                    andTextColor:[Settings color:ColorForDishCellCost]];
    }
    self.lblCost.text = _cost;
    //self.lblCost.text = [NSString stringWithFormat:[Settings text:TextForDishCellCostFormat], cost, [Settings text:TextForCurrency]];
}


- (void)setupBgView
{

    self.bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"button_blyudo_empty.png"]];

    [self.contentView addSubview:_bgView];
}

- (UILabel *)setupLabelWithFrame:(CGRect)frame andFont:(UIFont *)font andTextColor:(UIColor *)textColor
{
    UILabel *lbl = [[UILabel alloc] initWithFrame:frame];
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.backgroundColor = [Settings color:ColorForViewsBgDebug];
    lbl.numberOfLines = 1;
    lbl.font = font;
    lbl.textColor = textColor;
    
    [self.contentView addSubview:lbl];
    
    return lbl;
}
@end
