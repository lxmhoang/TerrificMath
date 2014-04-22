//
//  ApActivityData.m
//  saytheword
//
//  Created by Hoang Le on 7/11/13.
//  Copyright (c) 2013 Hoang Le. All rights reserved.
//

#import "ApActivityData.h"

@implementation APActivityProvider
- (id) activityViewController:(UIActivityViewController *)activityViewController
          itemForActivityType:(NSString *)activityType
{
    
    NSString *message = [NSString stringWithFormat:@"Just scored %d points at One Second, a game which you have only 1 second to give an answer in each round %@  ", (int)[[NSUserDefaults standardUserDefaults] integerForKey:kLatestPoint], appURL];
    
    if ( [activityType isEqualToString:UIActivityTypePostToTwitter] )
        return message;
    if ( [activityType isEqualToString:UIActivityTypePostToFacebook] )
        return message;
    if ( [activityType isEqualToString:UIActivityTypeMessage] )
        return message;
    if ( [activityType isEqualToString:UIActivityTypeMail] )
        return message;
    return message;
}
- (id) activityViewControllerPlaceholderItem:(UIActivityViewController *)activityViewController { return @""; }
@end

@implementation APActivityIcon
- (NSString *)activityType { return @"it.albertopasca.myApp"; }
- (NSString *)activityTitle { return @"Open Maps"; }
- (UIImage *) activityImage { return [UIImage imageNamed:@"lines.png"]; }
- (BOOL) canPerformWithActivityItems:(NSArray *)activityItems {
    NSLog(@"canPerformWithActivityItems");
    return YES;
}
- (void) prepareWithActivityItems:(NSArray *)activityItems {
    NSLog(@"prepareWithActivityItems");
 
}
- (UIViewController *) activityViewController { return nil; }
- (void) performActivity {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"maps://"]];
    }
@end