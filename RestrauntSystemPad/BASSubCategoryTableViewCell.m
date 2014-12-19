//
//  BASSubCategoryTableViewCell.m
//  RestrauntSystem
//
//  Created by Sergey on 06.06.14.
//  Copyright (c) 2014 BestAppStudio. All rights reserved.
//

#import "BASSubCategoryTableViewCell.h"

#define MAXCOUNT 5

@interface BASSubCategoryTableViewCell()

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

@implementation BASSubCategoryTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withContent:(NSDictionary*)contentData{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentData = [NSDictionary dictionaryWithDictionary:contentData];
        
        [self setBackgroundColor:[UIColor clearColor]];
        
        [self setupBgView];


        TheApp;
        if(app.isOrder){
            self.imgViewState = [[UIImageView alloc]init];
            [_imgViewState setBackgroundColor:[UIColor clearColor]];
            [self addSubview:_imgViewState];

        }

    }
    return self;
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    CGRect frame = self.contentView.frame;
    
    UIImage* img = (UIImage*)[Settings image:ImageForDishCellBg];
    [_bgView setFrame:CGRectMake(5.f, frame.size.height - img.size.height, frame.size.width - 10.f, img.size.height)];
    [_imgViewState setFrame:CGRectMake(12.f, 55.f, 33.f, 28.5f)];
    

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}
- (void)setTitle:(NSString *)title
{
    _title = title;
    
    if (!self.lblTitle) {
        
        self.lblTitle = [self setupLabelWithFrame:[Settings rect:RectForDishCellTitle]
                                          andFont:[Settings font:FontForDishCellTitle]
                                     andTextColor:[Settings color:ColorForDishCellTitle]];
    }
    
    self.lblTitle.text = [NSString stringWithFormat:[Settings text:TextForDishCellTitleFormat], title];
}

- (void)setWeight:(NSString*)weight
{
    _weight = weight;
    
    if (!self.lblWeight) {
        
        self.lblWeight = [self setupLabelWithFrame:[Settings rect:RectForDishCellWeight]
                                           andFont:[Settings font:FontForDishCellWeight]
                                      andTextColor:[Settings color:ColorForDishCellWeight]];
    }
    self.lblWeight.text = _weight;
    //self.lblWeight.text = [NSString stringWithFormat:[Settings text:TextForDishCellWeightFormat], weight, [Settings text:TextForWeightUnit]];
}

- (void)setCost:(NSString*)cost
{
    _cost = cost;
    
    if (!self.lblCost) {
        
        self.lblCost = [self setupLabelWithFrame:[Settings rect:RectForDishCellCost]
                                         andFont:[Settings font:FontForDishCellCost]
                                    andTextColor:[Settings color:ColorForDishCellCost]];
    }
    self.lblCost.text = _cost;
    //self.lblCost.text = [NSString stringWithFormat:[Settings text:TextForDishCellCostFormat], cost, [Settings text:TextForCurrency]];
}

- (void)setCount:(NSUInteger)count
{
    _count = count;
    
    if (!self.lblCount) {
        
        self.lblCount = [self setupLabelWithFrame:[Settings rect:RectForDishCellCount]
                                          andFont:[Settings font:FontForDishCellCount]
                                     andTextColor:[Settings color:ColorForDishCellCount]];
    }
    self.lblCount.text = @"";
    if(_count > 0)
        self.lblCount.text = [NSString stringWithFormat:@"%lu", (unsigned long)self.count];
}

- (void)setModsExist:(BOOL)modsExist
{
    _modsExist = modsExist;
    
    self.imgViewMods.hidden = !modsExist;
}

- (void)setState:(OrderItemState)dishState
{
    _state = dishState;
    
    UIImage *img = nil;
    
    switch (_state) {
        case 0:
            img =  [UIImage imageNamed:@"buttton_ozhudaniye"];
            break;
        case 1:
            img = [UIImage imageNamed:@"buttton_gotovo"];
            break;
        case 2:
            img = [UIImage imageNamed:@"buttton_podano"];
            break;
        default:
            break;
    }
    
    [_imgViewState setImage:img];
}

#pragma mark -Private properties

- (UIImageView *)imgViewMods
{
    if (!_imgViewMods) {
        
        _imgViewMods = [[UIImageView alloc] initWithImage:[Settings image:ImageForDishCellModif]];
        _imgViewMods.frame = CGRectMake([Settings floatValue:FloatValueForDishCellIconShift],
                                        [Settings floatValue:FloatValueForDishCellIconShift],
                                        _imgViewMods.frame.size.width,
                                        _imgViewMods.frame.size.height);
        [self addSubview:_imgViewMods];
    }
    
    return _imgViewMods;
}



#pragma mark - Public methods

- (id)initWithViewPosition:(DishCellSubviewPosition)subviewPosition
{
    UIImage *bgImg = [Settings image:ImageForDishCellBg];
    CGFloat left = (subviewPosition == DishCellSubviewPositionLeft) ? 0 : bgImg.size.width + [Settings floatValue:FloatValueForDishCellDistBtwViews];
    CGRect frame = CGRectMake(left, 0.f, bgImg.size.width, bgImg.size.height);
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupBgView];
    }
    return self;
}


#pragma mark - Actions
- (void)modificatClicked{
    if ([self.delegate respondsToSelector:@selector(modificationDish:)]) {
        
        [self.delegate modificationDish:self.dishIdx];
    }
}
- (void)prepareClicked{
    
    BASManager* manager = [BASManager sharedInstance];
    NSDictionary* dict = @{
                           @"id_order": (NSNumber*)[_contentData objectForKey:@"id_order"],
                           @"id_dish": (NSNumber*)[_contentData objectForKey:@"id_dish"],
                           };
    
    [manager getData:[manager formatRequest:@"SETDISHDELIVERED" withParam:dict] success:^(NSDictionary* responseObject) {
  
        
        NSArray* param = (NSArray*)[responseObject objectForKey:@"param"];
        NSLog(@"Response: %@",param);
        
        if(param != nil && param.count > 0){
            NSDictionary* dict = (NSDictionary*)[param objectAtIndex:0];
            NSNumber *result = (NSNumber*)[dict objectForKey:@"result"];
            if([result integerValue] == 1){
                [_btnPrepare removeFromSuperview];
                [self addSubview:_imgViewState];
                self.state = OrderItemStateGaveAway;
            }
        }
        
        
    } failure:^(NSString *error) {
        [manager showAlertViewWithMess:ERROR_MESSAGE];
    }];
}
- (void)btnPlusPressed:(UIButton *)btn
{
    
    
    if(_count < _countDish){
        if ([self.delegate respondsToSelector:@selector(plusOneDish:success:)]) {

            [self.delegate plusOneDish:self.dishIdx success:^{
                
                self.count++;
            }];
        }
    }else
        self.count = _countDish;

}

- (void)btnMinusPressed:(UIButton *)btn
{
    if(_count > 0){
        if (self.count > 0 && [self.delegate respondsToSelector:@selector(minusOneDish:success:)]) {
            
            //        NSUInteger dishId = btn.tag;
            
            [self.delegate minusOneDish:self.dishIdx success:^{
                
                self.count--;
            }];
        }
    } else
        self.count = 0;
}


#pragma mark - Private methods

- (void)setupBgView
{

    
    self.bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"button_blyudo_empty.png"]];
    TheApp;
    if(app.isOrder){
        self.bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell_blyudo.png"]];
    }
    
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
