//
//  NotificationManager.h
//  cuaQea
//
//  Created by Enrique Mendoza Robaina on 01/09/14.
//  Edited by Enrique Mendoza Robaina on 06/12/14.
//  Copyright (c) 2014 Cuaqea SL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CQANotificationManager : NSObject

- (void) sendPushToken;

- (void) scheduleLocalNotificationWithMessage:(NSString *)aMessage
                                       action:(NSString *)anAction
                                     fireDate:(NSDate *)aFireDate
                                     userInfo:(NSDictionary *)aUserInfo;

@end
