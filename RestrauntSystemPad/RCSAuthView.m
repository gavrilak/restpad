//
//  RCSAuthView.m
//  RestaurantControlSystem
//
//  Created by Bogdan Stasjuk on 26/11/2013.
//  Copyright (c) 2013 BestApp Studio. All rights reserved.
//

#import "RCSAuthView.h"


@interface RCSAuthView () <UITextFieldDelegate>

@property(nonatomic, strong) UITextField                *textFieldLogin;
@property(nonatomic, strong) UITextField                *textFieldPass;
@property(nonatomic, strong) UIButton                   *btnEnter;
@property(nonatomic, strong) UILabel                    *lblError;
@property(nonatomic, strong) UIActivityIndicatorView    *activityIndicatorView;

@end


@implementation RCSAuthView

#pragma mark - Properties

#pragma mark - public

- (void)setError:(NSString *)error
{
    if (!self.lblError) {
        
        [self setupLblError];
    }
    
    self.lblError.text = error;
}

- (void)setActivityViewAnimated:(BOOL)activityViewAnimated
{
    _activityViewAnimated = activityViewAnimated;
    
    if (activityViewAnimated) {

        [self.activityIndicatorView startAnimating];

    } else {
        
        [self.activityIndicatorView stopAnimating];
    }
}


#pragma mark - Public methods

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(0, 0, 1024.f, 768.f)];
    if (self) {
        
        [self clearFields];
        [self setupTapGestureRecognizer];
        [self setupBgImg];
        [self setupTextFields];
        [self setupBtnEnter];
        [self setupActivityIndicatorView];
    }
    return self;
}

- (void)clearFields{
    self.textFieldLogin.text = @"";
    self.textFieldPass.text = @"";
}
#pragma mark - UITextFieldDelegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self hideKeyboard];
    
    return NO;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {

#if DEBUG
    //self.textFieldLogin.text = @"admin";
    //self.textFieldPass.text = @"admin";
#endif
    
    textField.layer.borderColor = [UIColor clearColor].CGColor;
    
    return YES;
}


#pragma mark - Actions

- (void) hideKeyboard {
    
    [self endEditing:YES];
}

- (void)btnEnterPressed
{
    BOOL fieldsFilled = YES;

   
    self.textFieldLogin.text = [self.textFieldLogin.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    self.textFieldPass.text = [self.textFieldPass.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ([self.textFieldLogin.text isEqualToString:EmptyString]) {
        
        self.textFieldLogin.layer.borderColor = [UIColor redColor].CGColor;
        fieldsFilled = NO;
    }
    if ([self.textFieldPass.text isEqualToString:EmptyString]) {
        
        self.textFieldPass.layer.borderColor = [UIColor redColor].CGColor;
        fieldsFilled = NO;
    }
    
    if (fieldsFilled && [self.delegate respondsToSelector:@selector(btnEnterPressedWithLogin:andPassword:)]) {
        
        [self.delegate btnEnterPressedWithLogin:self.textFieldLogin.text andPassword:self.textFieldPass.text];
    }
}


#pragma mark - Private methods

- (void)setupTextFields
{
    CGFloat textFieldHeight = [Settings image:ImageForAuthTfBg].size.height;
    CGFloat btnHeight = [Settings image:ImageForAuthBtnEnter].size.height;
    CGFloat distBetweenCntrls = [Settings floatValue:FloatValueForAuthCntrsDistVert];
    CGFloat top = (768.f - btnHeight) / 2 - textFieldHeight - distBetweenCntrls;
    
    self.textFieldLogin = [self setupTextFieldWithTop:top andPlaceholder:[Settings text:TextForAuthLoginCap] andTag:0 andSecured:NO];
    self.textFieldPass = [self setupTextFieldWithTop:top + textFieldHeight + distBetweenCntrls andPlaceholder:[Settings text:TextForAuthPassCap] andTag:1 andSecured:YES];
}

- (UITextField *)setupTextFieldWithTop:(CGFloat)top
                        andPlaceholder:(NSString *)placeholder
                                andTag:(NSUInteger)tag
                            andSecured:(BOOL)secured
{
    UIImage *bgImg = [Settings image:ImageForAuthTfBg];
    CGRect textFieldFrame = CGRectMake((1024.f - bgImg.size.width) / 2,
                                       top,
                                       bgImg.size.width,
                                       bgImg.size.height);
    UITextField *textField = [[UITextField alloc] initWithFrame:textFieldFrame];
    textField.borderStyle = UITextBorderStyleNone;
    textField.background = bgImg;
    textField.delegate = self;
    textField.tag = tag;
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    textField.secureTextEntry = secured;
    textField.placeholder = placeholder;
    textField.textAlignment = NSTextAlignmentCenter;
    
    [self setBorderOnView:textField];
    
    [self addSubview:textField];
    
    return textField;
}

- (void)setBorderOnView:(UIView *)view {
    
    view.layer.cornerRadius = 5.0f;
    view.layer.masksToBounds = YES;
    view.layer.borderColor = [[UIColor clearColor] CGColor];
    view.layer.borderWidth = 1.0f;
}

- (void)setupTapGestureRecognizer
{
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    gestureRecognizer.cancelsTouchesInView = NO; //so that action such as clear text field button can be pressed
    [self addGestureRecognizer:gestureRecognizer];
}

- (void)setupBgImg
{
    CGRect bgFrame = CGRectMake(0.f, 0.f, 1024.f, 768.f);
    UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:bgFrame];
    bgImgView.image = [Settings image:ImageForAuthBg];
    
    [self addSubview:bgImgView];
}

- (void)setupBtnEnter
{
    self.btnEnter = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *btnImg = [Settings image:ImageForAuthBtnEnter];
    self.btnEnter.frame = CGRectMake((1024.f - btnImg.size.width) / 2,
                           self.textFieldPass.frame.origin.y + self.textFieldPass.frame.size.height + [Settings floatValue:FloatValueForAuthCntrsDistVert],
                           btnImg.size.width,
                           btnImg.size.height);
    [self.btnEnter setImage:btnImg forState:UIControlStateNormal];
    [self.btnEnter addTarget:self action:@selector(btnEnterPressed) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.btnEnter];
}

- (void)setupLblError
{
    self.lblError = [[UILabel alloc] init];
    self.lblError.font = [Settings font:FontForAuthLblError];
    self.lblError.textColor = [Settings color:ColorForAuthLblError];
    self.lblError.textAlignment = NSTextAlignmentCenter;
    
    CGFloat lblHeight = [EmptyString sizeWithAttributes:@{NSFontAttributeName: self.lblError.font}].height;
    CGFloat lblTop = self.textFieldPass.frame.origin.y + self.textFieldLogin.frame.size.height + (self.textFieldPass.frame.origin.y - self.textFieldLogin.frame.origin.y - self.textFieldLogin.frame.size.height - lblHeight) / 2;
    self.lblError.frame = CGRectMake(0.f, lblTop, self.frame.size.width, lblHeight);
    
    [self addSubview:self.lblError];
}

- (void)setupActivityIndicatorView
{
    self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    CGRect activityIndicatorViewFrame = self.activityIndicatorView.frame;
    activityIndicatorViewFrame.size.width = 1024.f;
    activityIndicatorViewFrame.size.height = 768.f;
    self.activityIndicatorView.frame = activityIndicatorViewFrame;
    
    self.activityIndicatorView.backgroundColor = [UIColor colorWithRed:211.f green:211.f blue:211.f alpha:0.5f];
    self.activityIndicatorView.hidden = YES;
    
    [self addSubview:self.activityIndicatorView];
}

@end
