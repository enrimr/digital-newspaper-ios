//
//  CuaqeApi.h
//  Cuaqea
//
//  Created by Enrique Mendoza Robaina on 27/11/14.
//  Copyright (c) 2014 Cuaqea SL. All rights reserved.
//

#import "CEMElMundoApi.h"

/* Warning suppress: "Perform selector can cause a memo leak"
 * Stack overflow question number 7017281
 */
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

@implementation CEMElMundoApi {}

#pragma mark -
/** POST: /api/1/newComment
 *
 * Data format (JSON):
 * {
 * }
 *
 */
- (void) newComment:(NSDictionary *)data
           calledBy:(id)calledBy
        withSuccess:(SEL)successCallback
{
    [self newComment:data
            calledBy:calledBy
         withSuccess:successCallback
          andFailure:@selector(defaultFailureCallback:)];
}

- (void) newComment:(NSDictionary *)data
           calledBy:(id)calledBy
        withSuccess:(SEL)successCallback
         andFailure:(SEL)failureCallback
{
    [self placePostRequest:@"api/1/newComment"
                  withData:data
               withHandler:^(NSURLResponse *response, NSData *rawData, NSError *error) {
                   NSString *string = [[NSString alloc] initWithData:rawData
                                                            encoding:NSUTF8StringEncoding];
                   
                   NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
                   NSInteger code = [httpResponse statusCode];
                   NSLog(@"%ld", (long)code);
                   
                   if (!(code >= 200 && code < 300)) {
                       NSLog(@"ERROR (%ld): %@", (long)code, string);
                       [calledBy performSelector:failureCallback withObject:string];
                   } else {
                       NSDictionary *result = [NSDictionary dictionaryWithObjectsAndKeys:
                                               string, @"id",
                                               nil];
                       [calledBy performSelector:successCallback withObject:result];
                   }
               }];

}

#pragma mark News
/** GET: /api/1/newsByChannel/{userId}/{channel} */
- (void) newsByChannel:(NSString *)channel
                userId:(NSString *)userId
              calledBy:(id)calledBy
           withSuccess:(SEL)successCallback
{
    [self newsByChannel:channel
                 userId:userId
               calledBy:calledBy
            withSuccess:successCallback
             andFailure:@selector(defaultFailureCallback:)];
}

- (void) newsByChannel:(NSString *)channel
                userId:(NSString *)userId
              calledBy:(id)calledBy
           withSuccess:(SEL)successCallback
            andFailure:(SEL)failureCallback
{
    [self placeGetRequestWithURL:[NSString stringWithFormat:@"%@/api/1/newsByChannel/%@/%@",
                                  URL_API,
                                  userId,
                                  channel]
                     withHandler:^(NSURLResponse *response, NSData *rawData, NSError *error) {
                         
                         NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
                         NSInteger code = [httpResponse statusCode];
                         NSLog(@"%ld", (long)code);
                         
                         if (code == 0){
                             NSString *string = [[NSString alloc] initWithData:rawData
                                                                      encoding:NSUTF8StringEncoding];
                             NSLog(@"ERROR (%ld): %@", (long)code, string);
                             [calledBy performSelector:failureCallback withObject:string];
                         } else if (!(code >= 200 && code < 300)) {
                             NSString *string = [[NSString alloc] initWithData:rawData
                                                                      encoding:NSUTF8StringEncoding];
                             NSLog(@"ERROR (%ld): %@", (long)code, string);
                             [calledBy performSelector:failureCallback withObject:string];
                         } else {
                             //NSMutableDictionary *result = [NSJSONSerialization JSONObjectWithData:rawData options:0 error:nil];
                             NSArray *result = [NSJSONSerialization JSONObjectWithData:rawData
                                                                              options:0
                                                                                error:nil];
                             [calledBy performSelector:successCallback withObject:result];
                         }
                     }];
}

/** GET: /api/1/newsById/{userId}/{articleId} */
- (void) articleById:(NSString *)articleId
              userId:(NSString *)userId
            calledBy:(id)calledBy
         withSuccess:(SEL)successCallback
{
    [self articleById:articleId
               userId:userId
             calledBy:calledBy
          withSuccess:successCallback
           andFailure:@selector(defaultFailureCallback:)];
}

- (void) articleById:(NSString *)articleId
              userId:(NSString *)userId
            calledBy:(id)calledBy
         withSuccess:(SEL)successCallback
          andFailure:(SEL)failureCallback
{
    [self placeGetRequestWithURL:[NSString stringWithFormat:@"%@/api/1/newsById/%@/%@",
                                  URL_API,
                                  userId,
                                  articleId]
                     withHandler:^(NSURLResponse *response, NSData *rawData, NSError *error) {
                         
                         NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
                         NSInteger code = [httpResponse statusCode];
                         NSLog(@"%ld", (long)code);
                         
                         if (code == 0){
                             NSString *string = [[NSString alloc] initWithData:rawData
                                                                      encoding:NSUTF8StringEncoding];
                             NSLog(@"ERROR (%ld): %@", (long)code, string);
                             [calledBy performSelector:failureCallback withObject:string];
                         } else if (!(code >= 200 && code < 300)) {
                             NSString *string = [[NSString alloc] initWithData:rawData
                                                                      encoding:NSUTF8StringEncoding];
                             NSLog(@"ERROR (%ld): %@", (long)code, string);
                             [calledBy performSelector:failureCallback withObject:string];
                         } else {
                             //NSMutableDictionary *result = [NSJSONSerialization JSONObjectWithData:rawData options:0 error:nil];
                             NSArray *result = [NSJSONSerialization JSONObjectWithData:rawData
                                                                               options:0
                                                                                 error:nil];
                             [calledBy performSelector:successCallback withObject:result];
                         }
                     }];
}

/** GET: /api/1/newsByCreator/{userId}/{creator} */
- (void) newsByCreator:(NSString *)creator
                userId:(NSString *)userId
              calledBy:(id)calledBy
           withSuccess:(SEL)successCallback
{
    [self newsByCreator:creator
                 userId:userId
               calledBy:calledBy
            withSuccess:successCallback
             andFailure:@selector(defaultFailureCallback:)];
}

- (void) newsByCreator:(NSString *)creator
                userId:(NSString *)userId
              calledBy:(id)calledBy
           withSuccess:(SEL)successCallback
            andFailure:(SEL)failureCallback
{
    [self placeGetRequestWithURL:[NSString stringWithFormat:@"%@/api/1/newsByCreator/%@/%@",
                                  URL_API,
                                  userId,
                                  creator]
                     withHandler:^(NSURLResponse *response, NSData *rawData, NSError *error) {
                         
                         NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
                         NSInteger code = [httpResponse statusCode];
                         NSLog(@"%ld", (long)code);
                         
                         if (code == 0){
                             NSString *string = [[NSString alloc] initWithData:rawData
                                                                      encoding:NSUTF8StringEncoding];
                             NSLog(@"ERROR (%ld): %@", (long)code, string);
                             [calledBy performSelector:failureCallback withObject:string];
                         } else if (!(code >= 200 && code < 300)) {
                             NSString *string = [[NSString alloc] initWithData:rawData
                                                                      encoding:NSUTF8StringEncoding];
                             NSLog(@"ERROR (%ld): %@", (long)code, string);
                             [calledBy performSelector:failureCallback withObject:string];
                         } else {
                             //NSMutableDictionary *result = [NSJSONSerialization JSONObjectWithData:rawData options:0 error:nil];
                             NSArray *result = [NSJSONSerialization JSONObjectWithData:rawData
                                                                               options:0
                                                                                 error:nil];
                             [calledBy performSelector:successCallback withObject:result];
                         }
                     }];
}

/** GET: /api/1/channels/{userId} */
- (void) channels:(NSString *)userId
         calledBy:(id)calledBy
      withSuccess:(SEL)successCallback
{
    [self channels:userId
          calledBy:calledBy
       withSuccess:successCallback
        andFailure:@selector(defaultFailureCallback:)];
}

- (void) channels:(NSString *)userId
         calledBy:(id)calledBy
      withSuccess:(SEL)successCallback
       andFailure:(SEL)failureCallback
{
    [self placeGetRequestWithURL:[NSString stringWithFormat:@"%@/api/1/channels/%@",
                                  URL_API,
                                  userId]
                     withHandler:^(NSURLResponse *response, NSData *rawData, NSError *error) {
                         
                         NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
                         NSInteger code = [httpResponse statusCode];
                         NSLog(@"%ld", (long)code);
                         
                         if (code == 0){
                             NSString *string = [[NSString alloc] initWithData:rawData
                                                                      encoding:NSUTF8StringEncoding];
                             NSLog(@"ERROR (%ld): %@", (long)code, string);
                             [calledBy performSelector:failureCallback withObject:string];
                         } else if (!(code >= 200 && code < 300)) {
                             NSString *string = [[NSString alloc] initWithData:rawData
                                                                      encoding:NSUTF8StringEncoding];
                             NSLog(@"ERROR (%ld): %@", (long)code, string);
                             [calledBy performSelector:failureCallback withObject:string];
                         } else {
                             NSArray *result = [NSJSONSerialization JSONObjectWithData:rawData
                                                                               options:0
                                                                                 error:nil];
                             [calledBy performSelector:successCallback withObject:result];
                         }
                     }];
}

/** PUT: /api/1/voteArticle/{userId}/{articleId}/{voteValue} */
- (void) voteArticle:(NSString *)articleId
              userId:(NSString *)userId
           voteValue:(int)voteValue
            calledBy:(id)calledBy
         withSuccess:(SEL)successCallback
{
    [self voteArticle:articleId
               userId:userId
            voteValue:voteValue
             calledBy:self
          withSuccess:successCallback
           andFailure:@selector(defaultFailureCallback:)];
}

- (void) voteArticle:(NSString *)articleId
              userId:(NSString *)userId
           voteValue:(int)voteValue
            calledBy:(id)calledBy
         withSuccess:(SEL)successCallback
          andFailure:(SEL)failureCallback
{
    NSLog([NSString stringWithFormat:@"%@/api/1/voteArticle/%@/%@/%d",
           URL_API,
           userId,
           articleId,
           voteValue]);
    [self placePutRequestWithURL:[NSString stringWithFormat:@"%@/api/1/voteArticle/%@/%@/%d",
                           URL_API,
                           userId,
                           articleId,
                           voteValue]
                 withData:[NSDictionary dictionaryWithObjectsAndKeys: nil]
              withHandler:^(NSURLResponse *response, NSData *rawData, NSError *error) {
                  NSString *string = [[NSString alloc] initWithData:rawData
                                                           encoding:NSUTF8StringEncoding];
                  
                  NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
                  int code = [httpResponse statusCode];
                  NSLog(@"%d", code);
                  
                  if (!(code >= 200 && code < 300) && !(code == 500)) {
                      NSLog(@"ERROR (%d): %@", code, string);
                      [calledBy performSelector:failureCallback withObject:string];
                  } else {
                      NSLog(@"OK");
                      [calledBy performSelector:successCallback withObject:nil];
                  }
              }];
}

/** PUT: /api/1/shareArticle/{userId}/{articleId} */
- (void) shareArticle:(NSString *)articleId
              userId:(NSString *)userId
            calledBy:(id)calledBy
         withSuccess:(SEL)successCallback
{
    [self shareArticle:articleId
                userId:userId
              calledBy:self
           withSuccess:successCallback
            andFailure:@selector(defaultFailureCallback:)];
}

- (void) shareArticle:(NSString *)articleId
              userId:(NSString *)userId
            calledBy:(id)calledBy
         withSuccess:(SEL)successCallback
          andFailure:(SEL)failureCallback
{
    [self placePutRequestWithURL:[NSString stringWithFormat:@"%@/api/1/shareArticle/%@/%@",
                                  URL_API,
                                  userId,
                                  articleId]
                        withData:[NSDictionary dictionaryWithObjectsAndKeys: nil]
                     withHandler:^(NSURLResponse *response, NSData *rawData, NSError *error) {
                         NSString *string = [[NSString alloc] initWithData:rawData
                                                                  encoding:NSUTF8StringEncoding];
                         
                         NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
                         int code = [httpResponse statusCode];
                         NSLog(@"%d", code);
                         
                         if (!(code >= 200 && code < 300) && !(code == 500)) {
                             NSLog(@"ERROR (%d): %@", code, string);
                             [calledBy performSelector:failureCallback withObject:string];
                         } else {
                             NSLog(@"OK");
                             [calledBy performSelector:successCallback withObject:nil];
                         }
                     }];
}

#pragma mark Failure Callbacks

- (void) defaultFailureCallback
{
    NSLog(@"Failure");
}

- (void) defaultFailureCallback:(id)result
{
    NSLog(@"Failure");
}

@end
