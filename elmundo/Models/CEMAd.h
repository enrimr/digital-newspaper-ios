//
//  CEMAd.h
//  elmundo
//
//  Created by Enrique Ismael Mendoza Robaina on 25/11/14.
//  Copyright (c) 2014 cuaQea SL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CEMAd : NSObject

@property (copy, nonatomic) NSString *adId;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *text;
@property (copy, nonatomic) NSString *url;
@property (strong, nonatomic) NSArray *categories;
@property (strong, nonatomic) NSArray *images;
@property (strong, nonatomic) NSArray *videos;
@property (nonatomic) int sharedCount;
@property (nonatomic) int votesCount;


+ (id)adWithId:(NSString *)anAdId
         title:(NSString *)aTitle
          text:(NSString *)aText
           url:(NSString *)aUrl
    categories:(NSArray *)arrayOfCategories
        images:(NSArray *)arrayOfImages
        videos:(NSArray *)arrayOfVideos
   sharedCount:(int)aSharedCount
     voteCount:(int)aVotesCount;

// Inicializador designado
- (id)initWithId:(NSString *)anAdId
           title:(NSString *)aTitle
            text:(NSString *)aText
             url:(NSString *)aUrl
      categories:(NSArray *)arrayOfCategories
          images:(NSArray *)arrayOfImages
          videos:(NSArray *)arrayOfVideos
     sharedCount:(int)aSharedCount
       voteCount:(int)aVotesCount;

// Inicializador de conveniencia
- (id)initWithDictionary:(NSDictionary *)aDictionary;

@end
