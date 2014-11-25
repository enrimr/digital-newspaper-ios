//
//  CEMArticle.h
//  elmundo
//
//  Created by Enrique Ismael Mendoza Robaina on 24/11/14.
//  Copyright (c) 2014 cuaQea SL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CEMAd.h"

@interface CEMArticle : NSObject

@property (copy, nonatomic) NSString *articleId;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *text;
@property (copy, nonatomic) NSString *url;
@property (copy, nonatomic) NSString *creator;
@property (copy, nonatomic) NSString *guid;
@property (strong, nonatomic) NSArray *categories;
@property (strong, nonatomic) NSDate *publicationDate;
@property (copy, nonatomic) NSString *channelId;
@property (copy, nonatomic) NSString *textSummary;
@property (strong, nonatomic) NSArray *images;
@property (strong, nonatomic) NSArray *videos;
@property (nonatomic) int commentsCount;
@property (strong, nonatomic) NSArray *comments;
@property (nonatomic) int sharedCount;
@property (nonatomic) int votesCount;
@property (strong, nonatomic) CEMAd *ad;

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
              ad:(CEMAd *)anAd;

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

// Inicializador de conveniencia
- (id)initWithDictionary:(NSDictionary *)aDictionary;

@end
