//
//  PlayViewController.m
//  TerrificMath
//
//  Created by Hoang Le on 4/5/14.
//  Copyright (c) 2014 hoang. All rights reserved.
//

#define kHeightOfProgressView 4
#define kTimeToAnswer 1.5
#import "PlayViewController.h"

@interface PlayViewController ()


@end

@implementation PlayViewController

bool stop = NO;

@synthesize equationLabel, resultLabel, progressView, pointLabel, correctBtn, wrongBtn, gameOverView, AnewScoreLabel, bestScoreLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        listColor = @[
                      [UIColor colorWithRed:76/255.0f green:153/255.0f blue:0/255.0f alpha:1],
                      [UIColor colorWithRed:25/255.0f green:51/255.0f blue:0/255.0f alpha:1],
                      [UIColor colorWithRed:102/255.0f green:0/255.0f blue:51/255.0f alpha:1],
                      [UIColor colorWithRed:0/255.0f green:76/255.0f blue:153/255.0f alpha:1],
                      [UIColor colorWithRed:204/255.0f green:102/255.0f blue:0/255.0f alpha:1],
                      [UIColor colorWithRed:255/255.0f green:128/255.0f blue:0/255.0f alpha:1],
                      [UIColor colorWithRed:102/255.0f green:102/255.0f blue:255/255.0f alpha:1],
                      [UIColor colorWithRed:0/255.0f green:51/255.0f blue:0/255.0f alpha:1],
                      [UIColor colorWithRed:0/255.0f green:0/255.0f blue:102/255.0f alpha:1],
                      
                      
                      ];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    point = 0;
    pointLabel.text =@"0";
    [self newGame];
    
}

- (void)viewDidAppear:(BOOL)animated
{

}

- (void)newGame
{
    UIColor *bgColor = self.view.backgroundColor;
    
    UIColor *color = [listColor objectAtIndex:(rand()%(listColor.count-1))];
    while ([color isEqual:bgColor]) {
        int num = rand()%(listColor.count-1);
        color = [listColor objectAtIndex:num];
    }
    
    
    NSLog(@"color index : %d",[listColor indexOfObject:color]);
    
    [self.view setBackgroundColor:color];
    
    correctBtn.enabled = YES;
    wrongBtn.enabled = YES;
    
    int difficult;
    if (point<9)
        difficult = 5;
    else
        difficult = 10;
    
//    NSLog(@"difficult : %d", difficult);
    
    x = arc4random_uniform(difficult)+1+difficult-5;;
    y = arc4random_uniform(difficult)+x+3;
    
    BOOL equal = arc4random_uniform(99) %2;
    
    if (equal)
        NSLog(@"Bang");
    else
        NSLog(@"khac");
    
    z = equal ? x+y : x+y-arc4random_uniform(4)+arc4random_uniform(8);
    
    
    if (z==x+y)
        z++;
   
    equationLabel.text = [NSString stringWithFormat:@"%d + %d", x, y];
    resultLabel.text = [NSString stringWithFormat:@"%d", z];
    hiddenAnswer = (x+y) == z;
    [progressView setFrame:CGRectMake(0, 0, 320, kHeightOfProgressView)];
    
    if (point != 0)
    {
        
        [UIView animateWithDuration:kTimeToAnswer animations:^{
            [progressView setFrame:CGRectMake(0, 0, 0, kHeightOfProgressView)];
        } completion:^(BOOL finished) {
            if (finished)
            {
                [self timeUp];
            }else
            {
                
            }
        }];
    }
}

- (void)timeUp
{
    NSLog(@"time is up !!!");
    [self gameOver];
}

- (void)answerIsGiven
{
    correctBtn.enabled = NO;
    wrongBtn.enabled = NO;
    [progressView.layer removeAllAnimations];
    [progressView setFrame:CGRectMake(0, 0, 320, kHeightOfProgressView)];
    
    if (answerGivenIsCorrect)
    {
        NSLog(@"correct answer !!!");
        point ++;
        pointLabel.text = [NSString stringWithFormat:@"%d",point];
        [self newGame];
    }else
    {
        NSLog(@"wrong answer !!!");
        [self gameOver];
    }
    
}

- (void)gameOver
{
    if (point > [[NSUserDefaults standardUserDefaults] integerForKey:kHighestPoint])
    {
        [[NSUserDefaults standardUserDefaults] setInteger:point forKey:kHighestPoint];
        [[GameKitHelper sharedGameKitHelper]
         submitScore:(int64_t)point
         category:kHighScoreLeaderboardCategory];
    }
    
    AnewScoreLabel.text = [NSString stringWithFormat:@"%d",point];
    bestScoreLabel.text = [NSString stringWithFormat:@"%d", [[NSUserDefaults standardUserDefaults] integerForKey:kHighestPoint]];
    
    
    gameOverView.alpha = 1;
    [UIView animateWithDuration:0.15 animations:^{
        [gameOverView setFrame:CGRectMake(30, 120, gameOverView.frame.size.width, gameOverView.frame.size.height)];
    } completion:^(BOOL finished) {
        nil;
    }];
    
    
    
}


- (IBAction)correctBtnAction:(id)sender
{
    if (hiddenAnswer)
    {
        answerGivenIsCorrect = YES;
    }else
    {
        answerGivenIsCorrect = NO;
    }
    
    [self answerIsGiven];
}


- (IBAction)wrongBtnAction:(id)sender
{
    if (hiddenAnswer)
    {
        answerGivenIsCorrect = NO;
    }else
    {
        answerGivenIsCorrect = YES;
    }
    
    [self answerIsGiven];
    
}

- (IBAction)playBtnAction:(id)sender {
    gameOverView.frame = CGRectMake(30, -gameOverView.frame.size.height, gameOverView.frame.size.width, gameOverView.frame.size.height);
    gameOverView.alpha = 0;
    point = 0;
    pointLabel.text = @"0";
    [self newGame];
}

- (IBAction)shareBtnAction:(id)sender {
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
