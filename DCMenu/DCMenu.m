//
//  DCMenu.m
//  DCMenu
//
//  Created by dawnnnnn on 15/12/18.
//  Copyright © 2015年 dawnnnnn. All rights reserved.
//

#import "DCMenu.h"
#import "UIButton+HighlightBg.h"

#define ITEMVIEW_HEIGHT 44.f

@interface DCMenu ()

@property (nonatomic, copy) NSArray *items;
@property (nonatomic, strong) UIView *menuView;

@end

@implementation DCMenu

- (id)initWithItems:(NSArray *)items
{
    self = [self init];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.3f];
        
        _items = items;
        [self drawView];
    }
    return self;
}

- (void)drawView {
    _menuView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, ITEMVIEW_HEIGHT*_items.count+64)];
    _menuView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_menuView];
    
    for (int i = 0; i < _items.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(0, 64+i*ITEMVIEW_HEIGHT, _menuView.frame.size.width, ITEMVIEW_HEIGHT)];
        button.tag = 2000+i;
        [button setBackgroundColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(buttonSelected:) forControlEvents:UIControlEventTouchUpInside];
        [_menuView addSubview:button];
        
        UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(15, 64+i*ITEMVIEW_HEIGHT, _menuView.frame.size.width-15, 0.5)];
        line.backgroundColor = [UIColor lightGrayColor];
        [_menuView addSubview:line];
        
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(15, 64+i*ITEMVIEW_HEIGHT, _menuView.frame.size.width-50, ITEMVIEW_HEIGHT)];
        title.text = _items[i];
        title.textColor = [UIColor darkGrayColor];
        title.font = [UIFont systemFontOfSize:17];
        [_menuView addSubview:title];
        
        UIImageView *selectImg = [[UIImageView alloc]initWithFrame:CGRectMake(_menuView.frame.size.width - 30, 64+i*ITEMVIEW_HEIGHT+15, 19, 15)];
        selectImg.image = [UIImage imageNamed:@"pullmenu_select.png"];
        selectImg.tag = 2100+i;
        selectImg.hidden = i == 0 ? NO : YES;
        [_menuView addSubview:selectImg];

    }
}

- (void)open:(UIView *)views {
    BOOL isHave = NO;
    for (id obj in [views subviews]) {
        if ([obj isKindOfClass:[DCMenu class]] ) {
            isHave = YES;
            break;
        }
    }
    if (isHave == NO) {
        [views addSubview:self];
    }
    _menuView.transform = CGAffineTransformMakeTranslation(0.f, -ITEMVIEW_HEIGHT*_items.count);
    self.alpha = 0;
    //    _menuView.alpha = 0;
    
    self.isOpen = YES;
    [UIView animateWithDuration:.7f delay:0.f usingSpringWithDamping:.7f initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _menuView.transform = CGAffineTransformMakeTranslation(0.f, -64.f);
        //        _menuView.alpha = 1.0;
        self.alpha = 1.0;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.3f];
    } completion:nil];
}

- (void)close {
    self.isOpen = NO;
    [UIView animateWithDuration:0.3f animations:^{
        _menuView.transform = CGAffineTransformMakeTranslation(0.f, -ITEMVIEW_HEIGHT*_items.count-64);
        //        _menuView.alpha = 0;
        //        self.alpha = 0;
        self.backgroundColor = [UIColor clearColor];
    } completion:^(BOOL finish){
        self.alpha = 0;
    }];
}

- (void)buttonSelected:(UIButton*)sender {
    for (int i = 0; i < _items.count; i++) {
        UIImageView *selectImg = [_menuView viewWithTag:2100+i];
        if (sender.tag == i+2000) {
            selectImg.hidden = NO;
        }
        else {
            selectImg.hidden = YES;
        }
    }
    if (_itemSelected) {
        _itemSelected(sender.tag-2000);
    }
    [self close];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self close];
}


@end
