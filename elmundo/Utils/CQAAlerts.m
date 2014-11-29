//
//  Alerts.m
//  cuaQea
//
//  Created by Enrique Mendoza Robaina on 29/11/13.
//  Copyright (c) 2013 Cuaqea SL. All rights reserved.
//

#import "CQAAlerts.h"

@implementation CQAAlerts

@synthesize pColor, pFontColor, pFrame, pMessage, pOrigin, pView;

- (void)create:(NSString *)message
         color:(UIColor *)color
     fontColor:(UIColor *)fontColor
      position:(NSString *)orientation
          view:(UIView *)view{
    
    self.pOrigin = view;
    self.pMessage = message;
    self.pColor = color;
    self.pFontColor = fontColor;
    CGRect imageRect = CGRectMake(0, 64, 320, 33);
    self.pFrame = imageRect;
    
    UIImageView *someImageView = [[UIImageView alloc] initWithFrame:imageRect];
    [someImageView setBackgroundColor:color];
    UILabel *label = [[UILabel alloc] initWithFrame:imageRect];
    label.text = message;
    label.textColor = fontColor;
    [label setFont:[UIFont systemFontOfSize:13]];
    label.textAlignment = NSTextAlignmentCenter;
    UIView *newView = [[UIView alloc] init];
    [someImageView setAlpha:ALERT_ALPHA];
    [newView addSubview:someImageView];
    [newView addSubview:label];
    [view addSubview:newView];
    
    self.pView = newView;
}

-(void)destroy{
    NSLog(@"Alert deleted");
    [self.pView removeFromSuperview];
}

-(void)showAlert:(NSString *)message
           color:(UIColor *)color
       fontColor:(UIColor *)fontColor
        position:(NSString *)orientation
            time:(NSTimeInterval)time
            view:(UIView *)view{
    
    [self create:message
           color:color
       fontColor:fontColor
        position:orientation
            view:view];
    
    [NSTimer scheduledTimerWithTimeInterval:time target:self selector:@selector(destroy) userInfo:nil repeats:NO];
}

- (void)showWithMessage:(NSString *)message
                  color:(UIColor *)color
              fontColor:(UIColor *)fontColor
               position:(NSString *)orientation
                   time:(NSTimeInterval)time
                   view:(UIView *)view
{
    [self create:message
           color:color
       fontColor:fontColor
        position:orientation
            view:view];
    
    [NSTimer scheduledTimerWithTimeInterval:time target:self selector:@selector(destroy) userInfo:nil repeats:NO];
}

- (void)showInTopViewWithMessage:(NSString *)message
                           color:(UIColor *)color
                       fontColor:(UIColor *)fontColor
                        position:(NSString *)orientation
                            time:(NSTimeInterval)time
{
    [self create:message
           color:color
       fontColor:fontColor
        position:orientation
            view:[[[UIApplication sharedApplication] windows] lastObject]];
    
    [NSTimer scheduledTimerWithTimeInterval:time target:self selector:@selector(destroy) userInfo:nil repeats:NO];
}

+ (void)rateApp
{
    NSString *str = @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa";
    str = [NSString stringWithFormat:@"%@/wa/viewContentsUserReviews?", str];
    str = [NSString stringWithFormat:@"%@type=Purple+Software&id=", str];
    
    // Here is the app id from itunesconnect
    str = [NSString stringWithFormat:@"%@803847945", str];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

@end
