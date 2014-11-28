//
//  CQACuaqeaSettings.m
//  diary
//
//  Created by Enrique Ismael Mendoza Robaina on 18/11/14.
//  Copyright (c) 2014 cuaQea SL. All rights reserved.
//

#import "CEMSettings.h"

@implementation CEMSettings

+ (BOOL) areAllChannelsLoaded{
    NSArray *channels = [[NSUserDefaults standardUserDefaults] arrayForKey:ELMUNDO_CHANNELS];
    NSArray *myChannels = [[NSUserDefaults standardUserDefaults] arrayForKey:ELMUNDO_MY_CHANNELS];
    return [channels count] == [myChannels count];
}
+ (void) addChannel:(NSString *)channel{
    NSMutableArray *myChannels = [[[NSUserDefaults standardUserDefaults] arrayForKey:ELMUNDO_MY_CHANNELS] mutableCopy];
    [myChannels addObject:channel];
}
+(void)setChannels:(NSArray *)channels{
    [[NSUserDefaults standardUserDefaults] setObject:channels forKey:ELMUNDO_CHANNELS];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(NSArray *)getChannels{
    return [[NSUserDefaults standardUserDefaults] arrayForKey:ELMUNDO_CHANNELS];
}
+(void)setMyChannels:(NSArray *)channels{
    [[NSUserDefaults standardUserDefaults] setObject:channels forKey:ELMUNDO_MY_CHANNELS];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(NSArray *)getMyChannels{
    return [[NSUserDefaults standardUserDefaults] arrayForKey:ELMUNDO_MY_CHANNELS];
}

@end
