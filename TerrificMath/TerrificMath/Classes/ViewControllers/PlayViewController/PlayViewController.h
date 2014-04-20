//
//  PlayViewController.h
//  TerrificMath
//
//  Created by Hoang Le on 4/5/14.
//  Copyright (c) 2014 hoang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayViewController : UIViewController
{
    int point, x, y, z;
    BOOL hiddenAnswer, answerGivenIsCorrect;
    NSArray *listColor;
}

@property (weak, nonatomic) IBOutlet UILabel *pointLabel;

@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UILabel *equationLabel;

@property (weak, nonatomic) IBOutlet UIView *progressView;

@property (weak, nonatomic) IBOutlet UIButton *correctBtn;
@property (weak, nonatomic) IBOutlet UIButton *wrongBtn;
@property (strong, nonatomic) IBOutlet UIView *gameOverView;
@property (weak, nonatomic) IBOutlet UILabel *AnewScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *bestScoreLabel;

- (IBAction)correctBtnAction:(id)sender;
- (IBAction)wrongBtnAction:(id)sender;
- (IBAction)playBtnAction:(id)sender;
- (IBAction)shareBtnAction:(id)sender;
- (IBAction)menuBtnAction:(id)sender;

@end
