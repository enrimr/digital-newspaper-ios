//
//  TimeUtils.m
//  cuaQea
//
//  Created by Enrique Mendoza Robaina on 03/12/13.
//  Updated by Enrique Mendoza Robaina on 29/11/14.
//  Copyright (c) 2013 Cuaqea SL. All rights reserved.
//

#import "CQATimeUtils.h"

@implementation CQATimeUtils

+(NSString *)getTimeString:(int)time{
    if (time < 2) {
        return @"now";
    } else if (time < 60) {
        return [NSString stringWithFormat:NSLocalizedString(@"%ds", nil),time];
    } else if (time < 3600) {
        int minutes = time/60;
        return [NSString stringWithFormat:NSLocalizedString(@"%dm", nil),minutes];
    } else if (time < 86400) {
        int hours = time/3600;
        return [NSString stringWithFormat:NSLocalizedString(@"%dh", nil),hours];
    } else {
        int days = time/86400;
        return [NSString stringWithFormat:NSLocalizedString(@"%dd", nil),days];
    }
}

@end
