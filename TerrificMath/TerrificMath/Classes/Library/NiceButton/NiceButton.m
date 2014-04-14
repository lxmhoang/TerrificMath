//
//  NiceButton.m
//  TerrificMath
//
//  Created by Hoang Le on 4/13/14.
//  Copyright (c) 2014 hoang. All rights reserved.
//

#import "NiceButton.h"

@implementation NiceButton

- (id)initWithFrame:(CGRect)frame type:(NiceButtonType)type
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self createBGView];
        [self setKindOfButton:type];
        
        [self addTarget:self action:@selector(stateChanged) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
}

- (void)stateChanged
{
    NSLog(@"1");
}

- (void)setKindOfButton:(NiceButtonType)type
{
    switch (type) {
        case PlayButton:
                
            break;
            
        default:
            break;
    }
}


- (void)createBGView
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:self.frame];
    v1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, btn.frame.size.width, btn.frame.size.height)];
    v1.layer.cornerRadius = 6;
    [v1 setBackgroundColor:[UIColor lightGrayColor]];
    
    v2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, btn.frame.size.width, btn.frame.size.height-4)];
    v2.layer.cornerRadius = 4;
    [v2 setBackgroundColor:[UIColor whiteColor]];
    
    [self addSubview:v1];
    v1.userInteractionEnabled = NO;
    [v1 addSubview:v2];
    
    [self sendSubviewToBack:v1];

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
