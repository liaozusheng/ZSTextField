//
//  ViewController.h
//  TextField
//
//  Created by Liao Zusheng on 15/5/26.
//  Copyright (c) 2015年 fyhulian All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZSTextField : UITextField
@property UILabel *floatingLabel;
@property CGFloat floatingLabelYPadding;
@property CGFloat placeholderYPadding;
@property UIFont *floatingLabelFont;
@property UIColor *floatingLabelTextColor;
@property UIColor *floatingLabelActiveTextColor;
@property NSInteger *animateEvenIfNotFirstResponder;
@property CGFloat floatingLabelShowAnimationDuration;
@property CGFloat floatingLabelHideAnimationDuration;

@end
