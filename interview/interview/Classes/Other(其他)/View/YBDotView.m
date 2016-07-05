//
//  YBDotView.m
//  interview
//
//  Created by Mickey on 16/6/30.
//  Copyright © 2016年 于波. All rights reserved.
//
#define dotWidthAndHeight 8.0f

#import "YBDotView.h"

@implementation YBDotView

- (void)showDot
{
    self.hidden = NO;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat dotY = (30 - dotWidthAndHeight) / 2;
        self.frame = CGRectMake(70, dotY, dotWidthAndHeight, dotWidthAndHeight);
        self.layer.cornerRadius = dotWidthAndHeight / 2;
        self.backgroundColor = YT_ColorFromRGB(0xa6e2c6);
        
    }
    return self;
}

- (void)hideDot
{
    self.hidden = YES;
}

@end
