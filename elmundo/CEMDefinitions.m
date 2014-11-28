//
//  Definitions.m
//  cuaQea
//
//  Created by Enrique Ismael Mendoza Robaina on 27/11/14.
//  Copyright (c) 2014 cuaQea SL. All rights reserved.
//

#import "CEMDefinitions.h"

NSString *const URL_API = @"http://cuaqeadev.cloudapp.net:9000";
NSString *const URL_SHARE_ARTICLE = @"http://cqa.es/c/";

NSTimeInterval const ALERT_TIME = 3.0;
NSTimeInterval const ALERT_TIME_LONG = ALERT_TIME + 2;
float const ALERT_ALPHA = 1.0f;

int const MAX_UPLOAD_SIZE = 70000;
int const MAX_LIST_ELEMENTS = 50;
int const MAX_USERNAME_LENGHT = 20;
int const MAX_CUAQ_TITLE_LENGHT = 40;
int const MAX_RECOMMENDED_PEOPLE = 10;
int const MORE_PAGE_SIZE = 25;
int const INITIAL_PAGE_SIZE = 50;
int const EXTRA_CUAQ_TIME = 10;
int const MAX_TIMES_TO_REMEMBER_EXTRA_DURATION = 5;
int const REMEMBER_RECORD_TIME_INTERVAL = 3;

// Images
NSString *const BACK_BUTTON = @"ic_TabNavBlueArrowNav.png";
NSString *const BACK_BUTTON_HOVER = @"ic_TabNavBlueArrowNavHover.png";

NSString *const ELMUNDO_CHANNELS = @"elmundoChannels";
NSString *const ELMUNDO_MY_CHANNELS = @"elmundoMyChannels";


@implementation CEMDefinitions

@end
