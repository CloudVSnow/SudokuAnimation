//
//  RewardView.m
//  SudokuAnimation
//
//  Created by LiuTian on 2018/2/5.
//  Copyright © 2018年 CloudVSnow. All rights reserved.
//

#import "RewardView.h"

@implementation RewardView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.selectView = [[UIView alloc]initWithFrame:self.bounds];
        self.selectView.layer.borderColor = [UIColor orangeColor].CGColor;
        self.selectView.layer.borderWidth = 8;
        [self addSubview:self.selectView];
        self.selectView.hidden = YES;
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
