//
//  MenuViewController.m
//  TerrificMath
//
//  Created by Hoang Le on 4/5/14.
//  Copyright (c) 2014 hoang. All rights reserved.
//

#import "MenuViewController.h"
#import "PlayViewController.h"

#import "NiceButton.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
    [super viewDidLoad];
    [self.view addSubview:bannerView];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)playBtnAction:(id)sender {
    PlayViewController *nextVC = [[PlayViewController alloc] initWithNibName:@"PlayViewController" bundle:nil];
    [self presentViewController:nextVC animated:YES completion:nil];
}

- (IBAction)rateBtnAction:(id)sender {
}
- (IBAction)rankBtnAction:(id)sender {
    GKGameCenterViewController *gcViewController = [[GKGameCenterViewController alloc] init];
    
    gcViewController.gameCenterDelegate = self;
    
    if (1==2) {
        gcViewController.viewState = GKGameCenterViewControllerStateLeaderboards;
        gcViewController.leaderboardIdentifier = @"TML";
    }
    else{
        gcViewController.viewState = GKGameCenterViewControllerStateAchievements;
    }
    
    [self presentViewController:gcViewController animated:YES completion:nil];
}

- (void)gameCenterViewControllerDidFinish:(GKGameCenterViewController *)gameCenterViewController NS_AVAILABLE_IOS(6_0)
{
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
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


@end
