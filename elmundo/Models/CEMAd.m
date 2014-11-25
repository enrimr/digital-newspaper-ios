//
//  CEMAd.m
//  elmundo
//
//  Created by Enrique Ismael Mendoza Robaina on 25/11/14.
//  Copyright (c) 2014 cuaQea SL. All rights reserved.
//

#import "CEMAd.h"

@implementation CEMAd

+ (id)adWithId:(NSString *)anAdId
         title:(NSString *)aTitle
          text:(NSString *)aText
           url:(NSString *)aUrl
    categories:(NSArray *)arrayOfCategories
        images:(NSArray *)arrayOfImages
        videos:(NSArray *)arrayOfVideos
   sharedCount:(int)aSharedCount
     voteCount:(int)aVotesCount
{
    return [[CEMAd alloc] initWithId:anAdId
                               title:aTitle
                                text:aText
                                 url:aUrl
                          categories:arrayOfCategories
                              images:arrayOfImages
                              videos:arrayOfVideos
                         sharedCount:aSharedCount
                           voteCount:aVotesCount];
}

// Inicializador designado
- (id)initWithId:(NSString *)anAdId
           title:(NSString *)aTitle
            text:(NSString *)aText
             url:(NSString *)aUrl
      categories:(NSArray *)arrayOfCategories
          images:(NSArray *)arrayOfImages
          videos:(NSArray *)arrayOfVideos
     sharedCount:(int)aSharedCount
       voteCount:(int)aVotesCount
{
    if (self = [super init]) {
        _adId = anAdId;
        _title = aTitle;
        _text = aText;
        _url = aUrl;
        _categories = arrayOfCategories;
        _images = arrayOfImages;
        _videos = arrayOfVideos;
        _sharedCount = aSharedCount;
        _votesCount = aVotesCount;
        
    }
    
    return self;
}

// Inicializador de conveniencia
- (id)initWithDictionary:(NSDictionary *)aDictionary
{
    return nil;
}

@end
