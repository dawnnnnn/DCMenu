//
//  DCMenu.h
//  DCMenu
//
//  Created by dawnnnnn on 15/12/18.
//  Copyright © 2015年 dawnnnnn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DCMenu : UIView

- (id)initWithItems:(NSArray *)items;
- (void)open:(UIView *)view;
- (void)close;


@property (nonatomic, assign) BOOL isOpen;
@property (nonatomic, copy) void (^itemSelected)(NSInteger tag);

@end
