//
//  NiceButton.h
//  TerrificMath
//
//  Created by Hoang Le on 4/13/14.
//  Copyright (c) 2014 hoang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    PlayButton,
    RateButton,
    ShareButton,
    RankButton,
    RightButton,
    WrongButton
} NiceButtonType;

@interface NiceButton : UIButton
{
    UIView *v1,*v2;
}
- (id)initWithFrame:(CGRect)frame type:(NiceButtonType)type;

@end
