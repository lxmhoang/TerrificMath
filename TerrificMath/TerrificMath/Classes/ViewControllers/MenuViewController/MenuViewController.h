//
//  MenuViewController.h
//  TerrificMath
//
//  Created by Hoang Le on 4/5/14.
//  Copyright (c) 2014 hoang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UIButton *rateBtn;
@property (weak, nonatomic) IBOutlet UIButton *rankBtn;
- (IBAction)playBtnAction:(id)sender;
- (IBAction)rateBtnAction:(id)sender;

- (IBAction)rankBtnAction:(id)sender;

@end
