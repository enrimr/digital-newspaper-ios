//
//  Definitions.h
//  cuaQea
//
//  Created by Enrique Ismael Mendoza Robaina on 27/11/14.
//  Copyright (c) 2014 cuaQea SL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CQAAppSettingsDefinitions.h"

FOUNDATION_EXPORT NSString *const URL_API;
FOUNDATION_EXPORT NSString *const URL_SHARE_ARTICLE;

#pragma mark Settings

FOUNDATION_EXPORT NSTimeInterval const ALERT_TIME;
FOUNDATION_EXPORT NSTimeInterval const ALERT_TIME_LONG;
FOUNDATION_EXPORT float const ALERT_ALPHA;
FOUNDATION_EXPORT int const MAX_UPLOAD_SIZE;
FOUNDATION_EXPORT int const MAX_LIST_ELEMENTS;
FOUNDATION_EXPORT int const MAX_USERNAME_LENGHT;
FOUNDATION_EXPORT int const MAX_CUAQ_TITLE_LENGHT;
FOUNDATION_EXPORT int const MAX_RECOMMENDED_PEOPLE;
FOUNDATION_EXPORT int const MORE_PAGE_SIZE;
FOUNDATION_EXPORT int const INITIAL_PAGE_SIZE;
FOUNDATION_EXPORT int const EXTRA_CUAQ_TIME;
FOUNDATION_EXPORT int const MAX_TIMES_TO_REMEMBER_EXTRA_DURATION;
FOUNDATION_EXPORT int const REMEMBER_RECORD_TIME_INTERVAL;

#pragma mark -

#pragma mark Images

FOUNDATION_EXPORT NSString *const BACK_BUTTON;
FOUNDATION_EXPORT NSString *const BACK_BUTTON_HOVER;


@interface CEMDefinitions : CQAAppSettingsDefinitions

@end
