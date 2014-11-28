//
//  CQACuaqeaSettings.h
//  diary
//
//  Created by Enrique Ismael Mendoza Robaina on 18/11/14.
//  Copyright (c) 2014 cuaQea SL. All rights reserved.
//

#import "CQAAppSettings.h"

@interface CEMSettings : CQAAppSettings

+ (BOOL) areAllChannelsLoaded;
+ (void) addChannel:(NSString *)channel;
+(NSArray *)setChannels:(NSArray *)channels;
+(NSArray *)getChannels;
+(NSArray *)setMyChannels:(NSArray *)channels;
+(NSArray *)getMyChannels;

@end
