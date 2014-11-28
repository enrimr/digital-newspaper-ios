//
//  CQAAppSettings.m
//  diary
//
//  Created by Enrique Ismael Mendoza Robaina on 17/11/14.
//  Updated by Enrique Ismael Mendoza Robaina on 28/11/14.
//  Copyright (c) 2014 cuaQea SL. All rights reserved.
//

#import "CQAAppSettings.h"

@implementation CQAAppSettings

// Notifications
+ (BOOL) localNotifications{
    return [[NSUserDefaults standardUserDefaults] boolForKey:SETTINGS_LOCAL_NOTIFICATIONS];
}
+ (void) setLocalNotifications:(BOOL)value{
    [[NSUserDefaults standardUserDefaults] setBool:value forKey:SETTINGS_LOCAL_NOTIFICATIONS];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSDate *) localNotificationForMainActionSchedule{
    return [[NSUserDefaults standardUserDefaults] objectForKey:SETTINGS_LOCAL_NOTIFICATION_DAILY_ACTION_SCHEDULE_DATE];
}
+ (void) updateLocalNotificationForMainActionSchedule{
    [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:SETTINGS_LOCAL_NOTIFICATION_DAILY_ACTION_SCHEDULE_DATE];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

// Social
+ (BOOL) shareByTwitter{
    return [[NSUserDefaults standardUserDefaults] boolForKey:SETTINGS_SOCIAL_SHARE_BY_TWITTER];
}
+ (void) setShareByTwitter:(BOOL)value{
    [[NSUserDefaults standardUserDefaults] setBool:value forKey:SETTINGS_SOCIAL_SHARE_BY_TWITTER];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (BOOL) shareByFacebook{
    return [[NSUserDefaults standardUserDefaults] boolForKey:SETTINGS_SOCIAL_SHARE_BY_FACEBOOK];
}
+ (void) setShareByFacebook:(BOOL)value{
    [[NSUserDefaults standardUserDefaults] setBool:value forKey:SETTINGS_SOCIAL_SHARE_BY_FACEBOOK];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

// User usage
+ (NSDate *) dateForLastAppLaunching{
    return [[NSUserDefaults standardUserDefaults] objectForKey:SETTINGS_USAGE_LAST_APP_LAUNCHING];
}
+ (void) updateDateForLastAppLaunching{
    [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:SETTINGS_USAGE_LAST_APP_LAUNCHING];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (BOOL) hasOpenedAppToday{
    return [[NSCalendar currentCalendar] isDateInToday:[self dateForLastAppLaunching]];
}
+ (NSDate *) dateForLastMainAction{
    return [[NSUserDefaults standardUserDefaults] objectForKey:SETTINGS_USAGE_LAST_MAIN_ACTION];
}
+ (void) updateDateForLastMainAction{
    [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:SETTINGS_USAGE_LAST_MAIN_ACTION];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (BOOL) hasDoneMainActionToday{
    return [[NSCalendar currentCalendar] isDateInToday:[self dateForLastMainAction]];
}
+ (NSDate *) dateForEvent:(NSString *)event{
    return [[NSUserDefaults standardUserDefaults] objectForKey:[SETTINGS_USAGE_ stringByAppendingString:event]];

}
+ (void) updateDateForEvent:(NSString *)event{
    [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:[SETTINGS_USAGE_ stringByAppendingString:event]];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (BOOL) hasDoneEventToday:(NSString *)event{
    return [[NSCalendar currentCalendar] isDateInToday:[self dateForEvent:event]];
}
@end
