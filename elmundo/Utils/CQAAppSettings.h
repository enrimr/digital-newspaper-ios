//
//  CQAAppSettings.h
//  diary
//
//  Created by Enrique Ismael Mendoza Robaina on 17/11/14.
//  Updated by Enrique Ismael Mendoza Robaina on 28/11/14.
//  Copyright (c) 2014 cuaQea SL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CQAAppSettings : NSObject

// Notifications
+ (BOOL) localNotifications;
+ (void) setLocalNotifications:(BOOL)value;
+ (NSDate *) localNotificationForMainActionSchedule;
+ (void) updateLocalNotificationForMainActionSchedule;

// Social
+ (BOOL) shareByTwitter;
+ (void) setShareByTwitter:(BOOL)value;
+ (BOOL) shareByFacebook;
+ (void) setShareByFacebook:(BOOL)value;

// User usage
+ (NSDate *) dateForLastAppLaunching;
+ (void) updateDateForLastAppLaunching;
+ (BOOL) hasOpenedAppToday;
+ (NSDate *) dateForLastMainAction;
+ (void) updateDateForLastMainAction;
+ (BOOL) hasDoneMainActionToday;
+ (NSDate *) dateForEvent:(NSString *)event;
+ (void) updateDateForEvent:(NSString *)event;
+ (BOOL) hasDoneEventToday:(NSString *)event;

@end
