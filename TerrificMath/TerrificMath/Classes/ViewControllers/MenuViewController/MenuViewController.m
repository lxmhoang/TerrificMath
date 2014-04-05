//
//  MenuViewController.m
//  TerrificMath
//
//  Created by Hoang Le on 4/5/14.
//  Copyright (c) 2014 hoang. All rights reserved.
//

#import "MenuViewController.h"
#import "PlayViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

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
}
@end
