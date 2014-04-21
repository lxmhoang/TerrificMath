//
//  PlayViewController.m
//  TerrificMath
//
//  Created by Hoang Le on 4/5/14.
//  Copyright (c) 2014 hoang. All rights reserved.
//

#define kHeightOfProgressView 4
#define kTimeToAnswer 1.2
#import "PlayViewController.h"
#import "MenuViewController.h"
#import "ApActivityData.h"

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
        
        if (![[NSUserDefaults standardUserDefaults] boolForKey:@"noads"])
        {
            if ([ADBannerView instancesRespondToSelector:@selector(initWithAdType:)]) {
                bannerView = [[ADBannerView alloc] initWithAdType:ADAdTypeBanner];
            } else {
                bannerView = [[ADBannerView alloc] init];
            }
            bannerView.delegate = self;
        }
    }
    return self;
}

- (void)viewDidLoad
{

    
    [gameOverView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"gameoverview.png"]]];
    
    [super viewDidLoad];
    
//    [self.view addSubview:bannerView];
    bannerView.alpha = 0;
    
    point = 0;
    pointLabel.text =@"0";
    
    [self newGame];
}

- (void)viewWillAppear:(BOOL)animated
{
}

- (void)viewDidAppear:(BOOL)animated
{
    if ([ [ UIScreen mainScreen ] bounds ].size.height < 568)
    {
        [correctBtn setFrame:CGRectMake(correctBtn.frame.origin.x, 300, correctBtn.frame.size.width, correctBtn.frame.size.height)];
        [wrongBtn setFrame:CGRectMake(wrongBtn.frame.origin.x, 300, wrongBtn.frame.size.width, correctBtn.frame.size.height)];
    }
}

- (void)newGame
{
    [bestScoreLabel setTextColor:[UIColor whiteColor]];
    bannerView.alpha = 0;
    UIColor *bgColor = self.view.backgroundColor;
    
    UIColor *color = [listColor objectAtIndex:(rand()%(listColor.count-1))];
    while ([color isEqual:bgColor]) {
        int num = rand()%(listColor.count-1);
        color = [listColor objectAtIndex:num];
    }
    
    
    NSLog(@"color index : %d",[listColor indexOfObject:color]);
    
    [self.view setBackgroundColor:color];
    
    correctBtn.userInteractionEnabled = YES;
    wrongBtn.userInteractionEnabled = YES;
    
    
    x = arc4random_uniform(8)+1;
    y = x+arc4random_uniform(15-x)+1;
    
    BOOL equal = arc4random_uniform(99) %2;
    
    if (equal)
        NSLog(@"Bang");
    else
        NSLog(@"khac");
    
    z = equal ? x+y : x+y-arc4random_uniform(2)+arc4random_uniform(4);
    
   
    equationLabel.text = [NSString stringWithFormat:@"%d + %d", x, y];
    resultLabel.text = [NSString stringWithFormat:@"= %d", z];
    
    
    CGRect frame = equationLabel.frame;
    frame.origin.x = 320;
    equationLabel.frame = frame;
    frame = resultLabel.frame;
    frame.origin.x = 320;
    resultLabel.frame = frame;
    
    [UIView animateWithDuration:0.2 animations:^{
        CGRect frame = equationLabel.frame;
        frame.origin.x = 0;
        equationLabel.frame = frame;
    }];
    [UIView animateWithDuration:0.2 animations:^{
        CGRect frame = resultLabel.frame;
        frame.origin.x = 0;
        resultLabel.frame = frame;
    }];
    
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
    correctBtn.userInteractionEnabled = NO;
    wrongBtn.userInteractionEnabled = NO;
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
        [self earthquake:self.view];
    }
    
}

- (void)gameOver
{
    bannerView.alpha = 1;
    [[NSUserDefaults standardUserDefaults] setInteger:point forKey:kLatestPoint];
    
    if (point > [[NSUserDefaults standardUserDefaults] integerForKey:kHighestPoint])
    {
        [[NSUserDefaults standardUserDefaults] setInteger:point forKey:kHighestPoint];
        [[GameKitHelper sharedGameKitHelper]
         submitScore:(int64_t)point
         category:kHighScoreLeaderboardCategory];
        
        [bestScoreLabel setTextColor:[UIColor yellowColor]];
    }
    
    
    
    AnewScoreLabel.text = [NSString stringWithFormat:@"%d",point];
    bestScoreLabel.text = [NSString stringWithFormat:@"%ld", (long)[[NSUserDefaults standardUserDefaults] integerForKey:kHighestPoint]];
    
    
    gameOverView.alpha = 1;
    [UIView animateWithDuration:0.15 animations:^{
        [gameOverView setFrame:CGRectMake(30, 60, gameOverView.frame.size.width, gameOverView.frame.size.height)];
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

- (void)dismissTmpView:(MenuViewController *)menuVC
{
    [menuVC dismissViewControllerAnimated:YES completion:^{
    }];
}

- (IBAction)playBtnAction:(id)sender {
    gameOverView.frame = CGRectMake(30, -gameOverView.frame.size.height, gameOverView.frame.size.width, gameOverView.frame.size.height);
    gameOverView.alpha = 0;
    point = 0;
    pointLabel.text = @"0";
    
    
    
    MenuViewController *menuVC = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
    
    menuVC.titleLabel.text = @"";
    
    [self presentViewController:menuVC animated:YES completion:^{
        
        [self newGame];
        
        [self performSelector:@selector(dismissTmpView:) withObject:menuVC afterDelay:0.2];
    }];
}

- (IBAction)shareBtnAction:(id)sender {
    if( [UIActivityViewController class] )
    {
        UIGraphicsBeginImageContext(self.view.bounds.size);
        [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *ImageAtt = UIGraphicsGetImageFromCurrentImageContext();
        
        APActivityProvider *ActivityProvider = [[APActivityProvider alloc] init];
        NSArray *Items = @[ActivityProvider, ImageAtt];
        
        
        UIActivityViewController *aVC = [[UIActivityViewController alloc] initWithActivityItems:Items applicationActivities:nil];
        
        NSMutableArray *listDisableItems = [[NSMutableArray alloc] initWithObjects:UIActivityTypeAssignToContact, UIActivityTypeCopyToPasteboard, UIActivityTypePrint,  UIActivityTypePostToWeibo, UIActivityTypeAirDrop, UIActivityTypeSaveToCameraRoll, nil];
        
        [aVC setExcludedActivityTypes:listDisableItems];
        
        [aVC setCompletionHandler:^(NSString *activityType, BOOL completed){
            NSLog(@"activity Type : %@", activityType);
            if (completed)
            {
               
            }
        }];
        
        [self  presentViewController:aVC animated:YES completion:nil];
    }else{
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Sorry" message:@"This feature is only available in IOS 6 and above" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
}

- (IBAction)menuBtnAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark layOutAnimated

- (void)layoutAnimated:(BOOL)animated
{
    
    // As of iOS 6.0, the banner will automatically resize itself based on its width.
    // To support iOS 5.0 however, we continue to set the currentContentSizeIdentifier appropriately.
    CGRect contentFrame = self.view.bounds;
    //    if (contentFrame.size.width < contentFrame.size.height) {
    //        bannerView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierPortrait;
    //    } else {
    //        bannerView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierLandscape;
    //    }
    
    
    
    CGRect bannerFrame = bannerView.frame;
    if (bannerView.bannerLoaded) {
        NSLog(@"ads loaded !");
        //        contentFrame.size.height -= bannerView.frame.size.height;
        bannerFrame.origin.y = contentFrame.size.height - bannerFrame.size.height;
    } else {
        NSLog(@"ads NOT loaded !");
        bannerFrame.origin.y = contentFrame.size.height;
    }
    
    //    if (_bannerView.bannerLoaded){
    [UIView animateWithDuration:animated ? 0 : 0.0 animations:^{
        self.view.frame = contentFrame;
        [self.view layoutIfNeeded];
        bannerView.frame = bannerFrame;
    }];
    //    }else{
    //        NSLog(@"Banner not loaded");
    //    }
}


#pragma mark Bannerview delegate

- (void)viewDidLayoutSubviews
{
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"noads"])
    {
        [self layoutAnimated:[UIView areAnimationsEnabled]];
    }
}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    
    [self layoutAnimated:YES];
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    NSLog(@"error log : %@",error);
    [self layoutAnimated:YES];
}

- (BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave
{
    
    return YES;
}

- (void)bannerViewActionDidFinish:(ADBannerView *)banner
{
    
}

#pragma mark Earth Quacke

- (void)earthquake:(UIView*)viewToShake
{
//    CGFloat t = 2.0;
//    CGAffineTransform translateRight  = CGAffineTransformTranslate(CGAffineTransformIdentity, t, 0.0);
//    CGAffineTransform translateLeft = CGAffineTransformTranslate(CGAffineTransformIdentity, -t, 0.0);
//    
//    viewToShake.transform = translateLeft;
//    
//    [UIView animateWithDuration:0.07 delay:0.0 options:UIViewAnimationOptionAutoreverse|UIViewAnimationOptionRepeat animations:^{
//        [UIView setAnimationRepeatCount:2.0];
//        viewToShake.transform = translateRight;
//    } completion:^(BOOL finished) {
//        if (finished) {
//            [UIView animateWithDuration:0.05 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
//                viewToShake.transform = CGAffineTransformIdentity;
//            } completion:^(BOOL finished) {
//                
                [self gameOver];
//            }];
//        }
//    }];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
