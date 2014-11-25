//
//  CEMArticle.m
//  elmundo
//
//  Created by Enrique Ismael Mendoza Robaina on 24/11/14.
//  Copyright (c) 2014 cuaQea SL. All rights reserved.
//

#import "CEMArticle.h"

@implementation CEMArticle

+ (id)articleWithId:(NSString *)anArticleId
              title:(NSString *)aTitle
               text:(NSString *)aText
                url:(NSString *)aUrl
            creator:(NSString *)aCreator
               guid:(NSString *)aGuid
         categories:(NSArray *)arrayOfCategories
    publicationDate:(NSDate *)aPublicationDate
          channelId:(NSString *)aChannelId
        textSummary:(NSString *)aTextSummary
             images:(NSArray *)arrayOfImages
             videos:(NSArray *)arrayOfVideos
      commentsCount:(int)aCommentsCount
           comments:(NSArray *)arrayOfComments
        sharedCount:(int)aSharedCount
          voteCount:(int)aVotesCount
                 ad:(CEMAd *)anAd
{
    return [[CEMArticle alloc] initWithId:anArticleId
                                    title:aTitle
                                     text:aText
                                      url:aUrl
                                  creator:aCreator
                                     guid:aGuid
                               categories:arrayOfCategories
                          publicationDate:aPublicationDate
                                channelId:aChannelId
                              textSummary:aTextSummary
                                   images:arrayOfImages
                                   videos:arrayOfVideos
                            commentsCount:aCommentsCount
                                 comments:arrayOfComments
                              sharedCount:aSharedCount
                                voteCount:aVotesCount
                                       ad:anAd];
}

// Inicializador designado
- (id)initWithId:(NSString *)anArticleId
           title:(NSString *)aTitle
            text:(NSString *)aText
             url:(NSString *)aUrl
         creator:(NSString *)aCreator
            guid:(NSString *)aGuid
      categories:(NSArray *)arrayOfCategories
 publicationDate:(NSDate *)aPublicationDate
       channelId:(NSString *)aChannelId
     textSummary:(NSString *)aTextSummary
          images:(NSArray *)arrayOfImages
          videos:(NSArray *)arrayOfVideos
   commentsCount:(int)aCommentsCount
        comments:(NSArray *)arrayOfComments
     sharedCount:(int)aSharedCount
       voteCount:(int)aVotesCount
              ad:(CEMAd *)anAd;
{
    if (self = [super init]) {
        _articleId = anArticleId;
        _title = aTitle;
        _text = aText;
        _url = aUrl;
        _creator = aCreator;
        _guid = aGuid;
        _categories = arrayOfCategories;
        _publicationDate = aPublicationDate;
        _channelId = aChannelId;
        _textSummary = aTextSummary;
        _images = arrayOfImages;
        _videos = arrayOfVideos;
        _commentsCount = aCommentsCount;
        _comments = arrayOfComments;
        _sharedCount = aSharedCount;
        _votesCount = aVotesCount;
        _ad = anAd;

    }
    
    return self;
}

// Inicializador de conveniencia
- (id)initWithDictionary:(NSDictionary *)aDictionary
{
    return nil;
}

@end
