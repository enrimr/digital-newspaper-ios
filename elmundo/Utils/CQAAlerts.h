//
//  Alerts.h
//  cuaQea
//
//  Created by Enrique Mendoza Robaina on 29/11/13.
//  Copyright (c) 2013 Cuaqea SL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CQAAlerts : NSObject

@property NSString *pMessage;
@property UIColor *pColor;
@property UIColor *pFontColor;
@property UIView *pOrigin;
@property UIView *pView;
@property CGRect pFrame;

- (void)destroy;

- (void)showAlert:(NSString *)message
            color:(UIColor *)color
        fontColor:(UIColor *)fontColor
         position:(NSString *)orientation
             time:(NSTimeInterval)time
             view:(UIView *)view __deprecated;

- (void)showWithMessage:(NSString *)message
                  color:(UIColor *)color
              fontColor:(UIColor *)fontColor
               position:(NSString *)orientation
                   time:(NSTimeInterval)time
                   view:(UIView *)view;

- (void)showInTopViewWithMessage:(NSString *)message
                       color:(UIColor *)color
                   fontColor:(UIColor *)fontColor
                    position:(NSString *)orientation
                        time:(NSTimeInterval)time;

+ (void)rateApp;

@end
