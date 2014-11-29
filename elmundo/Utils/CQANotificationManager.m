//
//  NotificationManager.m
//  cuaQea
//
//  Created by Enrique Mendoza Robaina on 01/09/14.
//  Edited by Enrique Mendoza Robaina on 06/12/14.
//  Copyright (c) 2014 Cuaqea SL. All rights reserved.
//

#import "CQANotificationManager.h"

@implementation CQANotificationManager

/*- (void) sendPushToken{
    NSString *userId;
    if ([CQAUserInfo isLogged]){
        userId = [CQAUserInfo userId];
    }
    if (userId == nil){
        userId = @"notLogged";
    }
    
    NSDictionary *dataToSend = [NSDictionary dictionaryWithObjectsAndKeys:
                                [CQAUserInfo getPushToken], @"regId",
                                userId, @"idUser",
                                @"IOS", @"systemPhone", nil];
    
    [[CQACuaqeaApi alloc] pushRegister:dataToSend calledBy:self withSuccess:@selector(pushRegisterDidEnd:) andFailure:@selector(pushRegisterFailure:)];
}*/

- (void) pushRegisterDidEnd:(id)result{
    NSLog(@"pushRegisterDidEnd");
}

- (void) pushRegisterFailure:(id)result{
    NSLog(@"pushRegisterFailure");
}

- (void) scheduleLocalNotificationWithMessage:(NSString *)aMessage
                                       action:(NSString *)anAction
                                     fireDate:(NSDate *)aFireDate
                                     userInfo:(NSDictionary *)aUserInfo
{
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    localNotification.fireDate = aFireDate;
    localNotification.alertBody = aMessage;
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    localNotification.alertAction = anAction;
    localNotification.userInfo = aUserInfo;
    localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

@end
