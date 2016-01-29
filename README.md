# DCMenu

A simple pull menu for iOS.
iOS开发中简单的下拉菜单。


# Preview 预览
![screenshots](https://raw.githubusercontent.com/dawnnnnn/DCMenu/master/screenshots/DCMenu.gif)


# Usage 使用
Init 初始化
``` objc
	NSArray *arr = @[@"全部", @"签到奖励", @"邀请好友奖励", @"兑换(零钱)"];
    self.menu = [[DCMenu alloc]initWithItems:arr];
    self.menu.itemSelected = ^(NSInteger tag) {
        // 选择了第tag个
        [strongSelf.titleBtn setTitle:arr[tag] forState:UIControlStateNormal];
    };
```

button clicked 按钮点击时

``` objc
	if (self.menu.isOpen) {
        [self.menu close];
    }
    else {
        [self.menu open:self.view];
        [self.view sendSubviewToBack:self.myTableView];
    }
```

