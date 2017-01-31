//
//  DNPullDownMenu.h
//  DNPullDownMenu
//
//  Created by dawnnnnn on 15/12/18.
//  Copyright © 2015年 dawnnnnn. All rights reserved.
//

#import "DNPullDownMenu.h"
#import "UIButton+HighlightBg.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

static CGFloat const kItemViewHeight    = 44.f;
static CGFloat const kNavBarHeight      = 64.f;
static CGFloat const kCommonPaddingLRTB = 15.f;

@interface DNPullDownMenu ()

@property (nonatomic, strong) UIView *menuView;

@property (nonatomic, copy) NSArray *items;

@end

@implementation DNPullDownMenu

- (id)initWithItems:(NSArray *)items {
    self = [self init];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.3f];
        
        self.items = items;
        
        [self viewAddSubviews];
    }
    return self;
}

- (void)viewAddSubviews {
    
    [self addSubview:self.menuView];
    
    for (int i = 0; i < self.items.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(0, kNavBarHeight + i * kItemViewHeight, self.menuView.frame.size.width, kItemViewHeight)];
        button.tag = 2000+i;
        [button setBackgroundColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(buttonSelected:) forControlEvents:UIControlEventTouchUpInside];
        [self.menuView addSubview:button];
        
        UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(kCommonPaddingLRTB, kNavBarHeight + i * kItemViewHeight, self.menuView.frame.size.width-kCommonPaddingLRTB, 0.5)];
        line.backgroundColor = [UIColor lightGrayColor];
        [self.menuView addSubview:line];
        
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(kCommonPaddingLRTB, kNavBarHeight + i * kItemViewHeight, self.menuView.frame.size.width - 50, kItemViewHeight)];
        title.text = self.items[i];
        title.textColor = [UIColor darkGrayColor];
        title.font = [UIFont systemFontOfSize:17];
        [self.menuView addSubview:title];
        
        UIImageView *selectImg = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - kCommonPaddingLRTB * 2, kNavBarHeight + i * kItemViewHeight + kCommonPaddingLRTB, 19, kCommonPaddingLRTB)];
        selectImg.image = [UIImage imageNamed:@"pullmenu_select.png"];
        selectImg.tag = 2100 + i;
        selectImg.hidden = i == 0 ? NO : YES;
        [self.menuView addSubview:selectImg];

    }
}

- (void)open:(UIView *)views {
    BOOL isHave = NO;
    for (id obj in [views subviews]) {
        if ([obj isKindOfClass:[DNPullDownMenu class]] ) {
            isHave = YES;
            break;
        }
    }
    if (isHave == NO) {
        [views addSubview:self];
    }
    self.menuView.transform = CGAffineTransformMakeTranslation(0.f, -kItemViewHeight * self.items.count);
    self.alpha = 0;
    //    self.menuView.alpha = 0;
    
    self.isOpen = YES;
    [UIView animateWithDuration:.7f delay:0.f usingSpringWithDamping:.7f initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.menuView.transform = CGAffineTransformMakeTranslation(0.f, -kNavBarHeight);
        //        self.menuView.alpha = 1.0;
        self.alpha = 1.0;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.3f];
    } completion:nil];
}

- (void)close {
    self.isOpen = NO;
    [UIView animateWithDuration:0.3f animations:^{
        self.menuView.transform = CGAffineTransformMakeTranslation(0.f, -kItemViewHeight * self.items.count - kNavBarHeight);
        //        self.menuView.alpha = 0;
        //        self.alpha = 0;
        self.backgroundColor = [UIColor clearColor];
    } completion:^(BOOL finish){
        self.alpha = 0;
    }];
}

- (void)buttonSelected:(UIButton*)sender {
    for (int i = 0; i < self.items.count; i++) {
        UIImageView *selectImg = [self.menuView viewWithTag:2100 + i];
        if (sender.tag == i + 2000) {
            selectImg.hidden = NO;
        } else {
            selectImg.hidden = YES;
        }
    }
    if (self.itemSelected) {
        self.itemSelected(sender.tag - 2000);
    }
    [self close];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self close];
}

#pragma mark - getter

- (UIView *)menuView {
    if (_menuView == nil) {
        _menuView = [[UIView alloc]initWithFrame:CGRectMake(0, kNavBarHeight, SCREEN_WIDTH, kItemViewHeight * self.items.count + kNavBarHeight)];
        _menuView.backgroundColor = [UIColor whiteColor];
    }
    return _menuView;
}

@end
