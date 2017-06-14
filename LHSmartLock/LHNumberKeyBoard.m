//
//  LHNumberKeyBoard.m
//  customKeyBoard
//
//  Created by 陈良辉 on 2017/5/31.
//  Copyright © 2017年 陈良辉. All rights reserved.
//

#import "LHNumberKeyBoard.h"
#import "Masonry.h"
#import "UIImage+Extents.h"

#define kCustomKeyboardHeight 216
#define kButtonWidth (kScreenSize.width-3)/4
#define kButtonHeight (kCustomKeyboardHeight-3)/4
#define keyboardBGColor [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0]

@interface LHNumberKeyBoard ()

@property (nonatomic,copy)NSArray *array;
//@property (nonatomic,strong)UIImage *whiteImage;
//@property (nonatomic,strong)UIImage *lightgrayImage;


@end

@implementation LHNumberKeyBoard

- (instancetype)init{
    if (self = [super init]) {
        self.frame = CGRectMake(0, kScreenSize.height-kCustomKeyboardHeight, kScreenSize.width, kCustomKeyboardHeight);
        self.backgroundColor = keyboardBGColor;
        [self initSubButtons];
//        self.whiteImage = [[UIImage alloc] init];
//        self.whiteImage = [self.whiteImage imageWithColor:[UIColor whiteColor]];
//        self.lightgrayImage = [[UIImage alloc] init];
//        self.lightgrayImage = [self.lightgrayImage imageWithColor:[UIColor lightGrayColor]];
    }
    return self;
}

- (void)initSubButtons{
    for (int i = 0; i < 12; i++) {
        CGFloat x = (i % 3)*(kButtonWidth+1);
        CGFloat y = (i/3)*(kButtonHeight+1);
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(x, y, kButtonWidth, kButtonHeight);
//        button.backgroundColor = [UIColor whiteColor];
        [button setBackgroundImage:[UIImage createImageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage createImageWithColor:keyboardBGColor] forState:UIControlStateHighlighted];
        button.tag = 1000+i;
        [button setTitle:self.array[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:30];
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
    
    //添加删除按钮
    UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [deleteButton setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
    [deleteButton setBackgroundImage:[UIImage createImageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [deleteButton setBackgroundImage:[UIImage createImageWithColor:keyboardBGColor] forState:UIControlStateHighlighted];
    deleteButton.tag = 1012;
    [deleteButton addTarget:self action:@selector(deleteButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:deleteButton];
    
    //添加完成按钮
    UIButton *commitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [commitButton setTitle:@"确定" forState:UIControlStateNormal];
    commitButton.titleLabel.font = [UIFont systemFontOfSize:25];
    [commitButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [commitButton setBackgroundImage:[UIImage createImageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [commitButton setBackgroundImage:[UIImage createImageWithColor:keyboardBGColor] forState:UIControlStateHighlighted];
    commitButton.tag = 1013;
    [commitButton addTarget:self action:@selector(commitButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:commitButton];
    
    [deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.right.equalTo(self.mas_right);
        make.width.equalTo(@(kButtonWidth));
        make.height.equalTo(@(kButtonHeight*2+1));
    }];
    
    [commitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(deleteButton.mas_bottom).offset(1);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom).offset(-1);
        make.width.equalTo(@(kButtonWidth));
    }];
}

- (void)buttonClicked:(UIButton *)button{
    
    NSString *string = self.array[button.tag - 1000];
    if (self.delegate&&[self.delegate respondsToSelector:@selector(numberButtonHadClickedWithString:)]) {
        [self.delegate numberButtonHadClickedWithString:string];
    }
}

- (void)deleteButtonClicked{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(deleteButtonHadClicked)]) {
        [self.delegate deleteButtonHadClicked];
    }
}

- (void)commitButtonClick{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(commitButtonHadClicked)]) {
        [self.delegate commitButtonHadClicked];
    }
}

- (NSArray *)array{
    if (!_array) {
        _array = [NSArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"*",@"0",@"#", nil];
    }
    return _array;
}

@end
