//
//  PlayViewController.m
//  TerrificMath
//
//  Created by Hoang Le on 4/5/14.
//  Copyright (c) 2014 hoang. All rights reserved.
//

#define kHeightOfProgressView 4
#define kTimeToAnswer 1
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
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidAppear:(BOOL)animated
{
    point = 0;
    pointLabel.text =@"0";
    [self newGame];
}

- (void)newGame
{
    correctBtn.enabled = YES;
    wrongBtn.enabled = YES;
    x = rand()%10;
    y = rand()%10;
    z = rand()%20;
    equationLabel.text = [NSString stringWithFormat:@"%d + %d", x, y];
    resultLabel.text = [NSString stringWithFormat:@"%d", z];
    hiddenAnswer = (x+y) == z;
    [progressView setFrame:CGRectMake(0, 0, 1, kHeightOfProgressView)];
    [UIView animateWithDuration:kTimeToAnswer animations:^{
            [progressView setFrame:CGRectMake(0, 0, 320, kHeightOfProgressView)];
    } completion:^(BOOL finished) {
        if (finished)
        {
            [self timeUp];
        }else
        {
            
        }
    }];
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
    [progressView setFrame:CGRectMake(0, 0, 1, kHeightOfProgressView)];
    
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
