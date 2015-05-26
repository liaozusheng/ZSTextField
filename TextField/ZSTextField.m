//
//  ViewController.h
//  TextField
//
//  Created by Liao Zusheng on 15/5/26.
//  Copyright (c) 2015年 fyhulian All rights reserved.
//

#import "ZSTextField.h"

@implementation ZSTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)init
{
    self = [super init];
    if (self) {
        self.floatingLabelYPadding=0.0f;
        self.placeholderYPadding=0.0f;
        self.animateEvenIfNotFirstResponder=0;
        self.floatingLabelShowAnimationDuration=0.3f;
        self.floatingLabelHideAnimationDuration=0.3f;
        [self commonInit];
    }
    return self;
}
- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.floatingLabelYPadding=0.0f;
        self.placeholderYPadding=0.0f;
        self.animateEvenIfNotFirstResponder=0;
        self.floatingLabelShowAnimationDuration=0.3f;
        self.floatingLabelHideAnimationDuration=0.3f;
        [self commonInit];
    }
    return self;

}
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.floatingLabelYPadding=0.0f;
        self.placeholderYPadding=0.0f;
        self.animateEvenIfNotFirstResponder=0;
        self.floatingLabelShowAnimationDuration=0.3f;
        self.floatingLabelHideAnimationDuration=0.3f;
        [self commonInit];
    }
    return self;
}
#pragma mark - init
- (void)commonInit{
    self.floatingLabel = [[UILabel alloc]init];
    self.floatingLabel.alpha = 0.0;
    
    [self addSubview:self.floatingLabel];
    
    self.floatingLabelFont = [UIFont boldSystemFontOfSize:12.0];
    self.floatingLabel.font = self.floatingLabelFont;
    self.floatingLabel.textColor = self.floatingLabelTextColor;
    
    
    self.floatingLabelTextColor = [UIColor grayColor];
    self.floatingLabel.textColor = self.floatingLabelTextColor;
    self.floatingLabelActiveTextColor = self.tintColor;
    self.animateEvenIfNotFirstResponder = 0;
    
    [self setFloatingLabelText:self.placeholder];
}
#pragma mark -
- (void)setFloatingLabelText:(NSString *)text{
    self.floatingLabel.text = text;
    [self setNeedsLayout];
}
- (CGFloat)maxTopInset {
    
    CGFloat initialValue = 0.0f;
    return MAX(initialValue, floorl(self.bounds.size.height - self.font.lineHeight - 4.0)) ;
    
}

- (void)setLabelOriginForTextAlignment{
    
    CGRect textRect = [self textRectForBounds:self.bounds];
    CGFloat originX = textRect.origin.x;
    
    if (self.textAlignment == NSTextAlignmentCenter) {
        originX = textRect.origin.x + (textRect.size.width/2) - (self.floatingLabel.frame.size.width/2);
    }
    else if (self.textAlignment == NSTextAlignmentRight) {
        originX = textRect.origin.x + textRect.size.width - self.floatingLabel.frame.size.width;
    } else if (self.textAlignment == NSTextAlignmentNatural) {
        
        /*
         var baseDirection:JVTextDirection = self.floatingLabel.text!.getBaseDirection()
         if (baseDirection == JVTextDirection.JVTextDirectionRightToLeft) {
         originX = textRect.origin.x + textRect.size.width - self.floatingLabel.frame.size.width
         }*/
    }
    
    self.floatingLabel.frame = CGRectMake(originX, self.floatingLabel.frame.origin.y,
                                          self.floatingLabel.frame.size.width, self.floatingLabel.frame.size.height);
    
}
- (UIColor *)labelActiveColor{
    if(self.floatingLabelActiveTextColor != nil){
        return self.floatingLabelActiveTextColor;
        
    }else {
        UIWindow *window = [UIApplication sharedApplication ].keyWindow;
        if(window != nil){
            UIColor *color = window.tintColor;
            if(color != nil){
                return color;
            }
        }
    }
    return [UIColor lightGrayColor];
}

- (void)showFloatingLabel:(BOOL)animated{
    
    if (animated || self.animateEvenIfNotFirstResponder != 0){
        [UIView animateWithDuration:self.floatingLabelShowAnimationDuration delay:0.0f options:UIViewAnimationOptionCurveEaseOut|UIViewAnimationOptionBeginFromCurrentState animations:^(void){
            self.floatingLabel.alpha = 1.0;
            self.floatingLabel.frame = CGRectMake(self.floatingLabel.frame.origin.x, self.floatingLabelYPadding, self.floatingLabel.frame.size.width, self.floatingLabel.frame.size.height);
            
        } completion:nil];
        
    }else {
        self.floatingLabel.alpha = 1.0;
        self.floatingLabel.frame = CGRectMake(self.floatingLabel.frame.origin.x, self.floatingLabelYPadding, self.floatingLabel.frame.size.width, self.floatingLabel.frame.size.height);
        
    }
    
}


- (void)hideFloatingLabel:(BOOL)animated{
    if (animated || self.animateEvenIfNotFirstResponder != 0){
        
        [UIView animateWithDuration:self.floatingLabelShowAnimationDuration delay:0.0f options:UIViewAnimationOptionCurveEaseIn|UIViewAnimationOptionBeginFromCurrentState animations:^(void){
            
            self.floatingLabel.alpha = 0.0;
            self.floatingLabel.frame = CGRectMake(self.floatingLabel.frame.origin.x, self.floatingLabel.font.lineHeight + self.floatingLabelYPadding, self.floatingLabel.frame.size.width, self.floatingLabel.frame.size.height);
            
        } completion:nil];
        
    }else {
        
        self.floatingLabel.alpha = 0.0;
        self.floatingLabel.frame = CGRectMake(self.floatingLabel.frame.origin.x, self.floatingLabel.font.lineHeight + self.floatingLabelYPadding, self.floatingLabel.frame.size.width, self.floatingLabel.frame.size.height);
        
    }
    
}


#pragma mark - override
- (void)layoutSubviews{
    [super layoutSubviews];
    [self setLabelOriginForTextAlignment];
    if((self.floatingLabelFont) != nil){
        self.floatingLabel.font = self.floatingLabelFont;
    }
    
    [self.floatingLabel sizeToFit];
    
    BOOL firstResponder = [self isFirstResponder];
    
    NSString *text = self.text;
    
    if(firstResponder && [text length] > 0 ){
        self.floatingLabel.textColor = [self labelActiveColor];
        
    }else {
        self.floatingLabel.textColor = [self floatingLabelTextColor];
    }
    
    
    if ([text length] == 0) {
        [self hideFloatingLabel:firstResponder];
    }
    else {
        
        [self showFloatingLabel:firstResponder];
    }

}
- (CGRect)textRectForBounds:(CGRect)bounds{
    CGRect rect = [super textRectForBounds:bounds];//super textRectForBounds(bounds) ]
    
//    let text = self.text!
    NSString *text = self.text;
    
    if ([text length] > 0) {
        
        CGFloat topInset =ceil(self.floatingLabel.font.lineHeight + self.placeholderYPadding);
        topInset = MIN(topInset, [self maxTopInset]);
        rect=UIEdgeInsetsInsetRect(rect,UIEdgeInsetsMake(topInset, 0.0, 0.0, 0.0) );
    }
    
    return CGRectIntegral(rect);
}
- (void)setPlaceholder:(NSString *)placeholder{
    [super setPlaceholder:placeholder];
    self.floatingLabel.text = placeholder;
    [self.floatingLabel sizeToFit];
}
- (void)setAttributedPlaceholder:(NSAttributedString *)attributedPlaceholder{
    [super placeholder];
    self.floatingLabel.text = attributedPlaceholder.string;
    [self.floatingLabel sizeToFit];
}
- (CGRect)editingRectForBounds:(CGRect)bounds{
    CGRect rect = [super editingRectForBounds:bounds];
    NSString *text = self.text;
    if ([text length] > 0) {
        
        CGFloat topInset =ceil(self.floatingLabel.font.lineHeight + self.placeholderYPadding);
        topInset = MIN(topInset, [self maxTopInset]);
        rect=UIEdgeInsetsInsetRect(rect,UIEdgeInsetsMake(topInset, 0.0, 0.0, 0.0) );
    }
    
    return CGRectIntegral(rect);
}
- (CGRect)clearButtonRectForBounds:(CGRect)bounds{
    CGRect rect = [super clearButtonRectForBounds:bounds];
    NSString *text = self.text;
    if ([text length]> 0) {
        CGFloat topInset =ceil(self.floatingLabel.font.lineHeight + self.placeholderYPadding);
        topInset = MIN(topInset, [self maxTopInset]);
        rect = CGRectMake(rect.origin.x, rect.origin.y + topInset / 2.0, rect.size.width, rect.size.height);
    }
    return CGRectIntegral(rect);

}
@end
