//
//  CuaqeApi.h
//  Cuaqea
//
//  Created by Enrique Mendoza Robaina on 27/11/14.
//  Copyright (c) 2014 Cuaqea SL. All rights reserved.
//
 
#import <Foundation/Foundation.h>
#import "CQABaseApi.h"

@interface CEMElMundoApi : CQABaseApi {}

#pragma mark -
#pragma mark Comment
/** POST: /api/1/newComment
 *
 * Data format (JSON):
 * {
 * }
 *
 */
- (void) newComment:(NSDictionary *)data
           calledBy:(id)calledBy
        withSuccess:(SEL)successCallback;

- (void) newComment:(NSDictionary *)data
           calledBy:(id)calledBy
        withSuccess:(SEL)successCallback
         andFailure:(SEL)failureCallback;

#pragma mark News
/** GET: /api/1/newsByChannel/{userId}/{channel} */
- (void) newsByChannel:(NSString *)channel
                userId:(NSString *)userId
              calledBy:(id)calledBy
           withSuccess:(SEL)successCallback;

- (void) newsByChannel:(NSString *)channel
                userId:(NSString *)userId
              calledBy:(id)calledBy
           withSuccess:(SEL)successCallback
            andFailure:(SEL)failureCallback;

/** GET: /api/1/newsById/{userId}/{articleId} */
- (void) articleById:(NSString *)articleId
              userId:(NSString *)userId
            calledBy:(id)calledBy
         withSuccess:(SEL)successCallback;

- (void) articleById:(NSString *)articleId
              userId:(NSString *)userId
            calledBy:(id)calledBy
         withSuccess:(SEL)successCallback
          andFailure:(SEL)failureCallback;

/** GET: /api/1/newsByCreator/{userId}/{creator} */
- (void) newsByCreator:(NSString *)creator
                userId:(NSString *)userId
              calledBy:(id)calledBy
           withSuccess:(SEL)successCallback;

- (void) newsByCreator:(NSString *)creator
                userId:(NSString *)userId
              calledBy:(id)calledBy
           withSuccess:(SEL)successCallback
            andFailure:(SEL)failureCallback;

/** GET: /api/1/channels/{userId} */
- (void) channels:(NSString *)userId
         calledBy:(id)calledBy
      withSuccess:(SEL)successCallback;

- (void) channels:(NSString *)userId
         calledBy:(id)calledBy
      withSuccess:(SEL)successCallback
       andFailure:(SEL)failureCallback;


#pragma mark -
#pragma mark Failure Callbacks

- (void) defaultFailureCallback;
- (void) defaultFailureCallback:(id)result;

@end
