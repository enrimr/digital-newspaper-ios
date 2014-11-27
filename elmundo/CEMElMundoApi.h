//
//  CuaqeApi.h
//  Cuaqea
//
//  Created by Enrique Mendoza Robaina on 27/11/13.
//  Copyright (c) 2013 Cuaqea SL. All rights reserved.
//
 
#import <Foundation/Foundation.h>
#import "CQABaseApi.h"

@interface CQACuaqeaApi : CQABaseApi {}

#pragma mark -
#pragma mark Register
/** POST: /api/register_cuaqea 
 *
 * Data format (JSON):
 * {
 *   "user": {
 *     "username"    : "johndoe",
 *     "password"    : "passworditis",
 *     "email"       : "john@doe.com",
 *     "dateOfBirth" : "05/11/1987"
 *   }
 * }
 *
 */
- (void) registerCuaqea:(NSDictionary *)data
               calledBy:(id)calledBy
            withSuccess:(SEL)successCallback;

- (void) registerCuaqea:(NSDictionary *)data
               calledBy:(id)calledBy
            withSuccess:(SEL)successCallback
             andFailure:(SEL)failureCallback;

/** POST: /api/register_twitter
 *
 * Data format (JSON):
 * {
 *   "user": {
 *     "username"     : "johndoe",
 *     "usernameTW"   : "john_doe",
 *     "idTWitter"    : "34212356748",
 *     "oauthTokenTW" : "AQwsaFHfs+dfaL",
 *     "oauthSecreTW" : "POfh-adSFJNM+CS="
 *   }
 * }
 *
 */
- (void) registerTwitter:(NSDictionary *)data
                 calledBy:(id)calledBy
              withSuccess:(SEL)successCallback;

- (void) registerTwitter:(NSDictionary *)data
                 calledBy:(id)calledBy
              withSuccess:(SEL)successCallback
               andFailure:(SEL)failureCallback;

/** POST: /api/register_facebook
 *
 * Data format (JSON):
 * {
 *   "user": {
 *     "username"     : "johndoe",
 *     "email"        : "john@doe.com",
 *     "oauthTokenFB" : "AQwsaFHfs+dfaL",
 *     "usernameFB"   : "JohnDoe"
 *   }
 * }
 *
 */
- (void) registerFacebook:(NSDictionary *)data
                  calledBy:(id)calledBy
               withSuccess:(SEL)successCallback;

- (void) registerFacebook:(NSDictionary *)data
                  calledBy:(id)calledBy
               withSuccess:(SEL)successCallback
                andFailure:(SEL)failureCallback;

#pragma mark -
#pragma mark Login
/** POST: /api/login_cuaqea
 *
 * Data format (JSON):
 * {
 *   "user": {
 *     "username"    : "johndoe",
 *     "password"    : "passworditis"
 *   }
 * }
 *
 */
- (void) loginCuaqea:(NSDictionary *)data
            calledBy:(id)calledBy
         withSuccess:(SEL)successCallback;

- (void) loginCuaqea:(NSDictionary *)data
            calledBy:(id)calledBy
         withSuccess:(SEL)successCallback
          andFailure:(SEL)failureCallback;

/** POST: /api/login_twitter
 *
 * Data format (JSON):
 * {
 *   "user": {
 *     "idTWitter"    : "34212356748",
 *     "oauthTokenTW" : "AQwsaFHfs+dfaL",
 *     "oauthSecreTW" : "POfh-adSFJNM+CS="
 *   }
 * }
 *
 */
- (void) loginTwitter:(NSDictionary *)data
             calledBy:(id)calledBy
          withSuccess:(SEL)successCallback;

- (void) loginTwitter:(NSDictionary *)data
                calledBy:(id)calledBy
             withSuccess:(SEL)successCallback
              andFailure:(SEL)failureCallback;

/** POST: /api/login_facebook
 *
 * Data format (JSON):
 * {
 *   "user": {
 *     "email"        : "john@doe.com",
 *     "oauthTokenFB" : "AQwsaFHfs+dfaL"
 *   }
 * }
 *
 */
- (void) loginFacebook:(NSDictionary *)data
              calledBy:(id)calledBy
           withSuccess:(SEL)successCallback;

- (void) loginFacebook:(NSDictionary *)data
              calledBy:(id)calledBy
           withSuccess:(SEL)successCallback
            andFailure:(SEL)failureCallback;

#pragma mark ResetPassword
/** POST: /api/settings/testsendmail
 *
 * Data format (JSON):
 * {
 *   "user": {
 *     "username"   : "johndoe",
 *     "lang"       : "es"
 *   }
 * }
 *
 */
- (void) resetPassword:(NSDictionary *)data
               calledBy:(id)calledBy
            withSuccess:(SEL)successCallback;

- (void) resetPassword:(NSDictionary *)data
               calledBy:(id)calledBy
            withSuccess:(SEL)successCallback
             andFailure:(SEL)failureCallback;

#pragma mark -
#pragma mark Notifications
#pragma mark pushRegister
/** POST: /api/push/register
 *
 * Data format (JSON):
 * {
 *      "regId":"String",
 *      "idUser":"String",
 *      "systemPhone":"String" => optional for android devices, values: "IOS" or "ANDROID" or null or '
 * }
 *
 */
- (void) pushRegister:(NSDictionary *)data
              calledBy:(id)calledBy
           withSuccess:(SEL)successCallback;

- (void) pushRegister:(NSDictionary *)data
              calledBy:(id)calledBy
           withSuccess:(SEL)successCallback
            andFailure:(SEL)failureCallback;

#pragma mark -
#pragma mark Cuaqs

/** POST: /api/cuaq/upload
 *
 * Data format (JSON):
 * {
 *   "cuaq": {
 *     "userId" : "52139a9344aecfa90b8583dd",
 *     "username" : "johndoe",
 *     "title" : "My title",
 *     "tags" : "tags",
 *     "time" : "time",
 *     "duracion" : "4",
 *     "content" : "base64stringOfFile",
 *     "url" : "",
 *     "ispublic" : true,
 *     "formato" : "m4a",
 *     "codec" : "codec",
 *     "this.sr" : "sr",
 *     "longitude" : "42.3123213",
 *     "latitude" : "-12.2434324",
 *     "morigen" : "morigen",
 *     "contentText" : "contentText"
 *   }
 * }
 *
 */
- (void) uploadCuaq:(NSDictionary *)data
           calledBy:(id)calledBy
        withSuccess:(SEL)successCallback;

- (void) uploadCuaq:(NSDictionary *)data
           calledBy:(id)calledBy
        withSuccess:(SEL)successCallback
         andFailure:(SEL)failureCallback;

/** GET: /api/cuaq/all(username:String) */
- (void) getAllCuaqsByUsername:(NSString *)username
                      calledBy:(id)calledBy
                   withSuccess:(SEL)successCallback;

- (void) getAllCuaqsByUsername:(NSString *)username
                      calledBy:(id)calledBy
                   withSuccess:(SEL)successCallback
                    andFailure:(SEL)failureCallback;

/** GET: /api/cuaq/search(search:String) */
- (void) getCuaqsByKey:(NSString *)key
                      calledBy:(id)calledBy
                   withSuccess:(SEL)successCallback;

- (void) getCuaqsByKey:(NSString *)key
                      calledBy:(id)calledBy
                   withSuccess:(SEL)successCallback
                    andFailure:(SEL)failureCallback;

/** GET: /api/user/getCuaqsLikes(idUser:String) */
- (void) getCuaqsLikes:(NSString *)idUser
              calledBy:(id)calledBy
           withSuccess:(SEL)successCallback;

- (void) getCuaqsLikes:(NSString *)idUser
              calledBy:(id)calledBy
           withSuccess:(SEL)successCallback
            andFailure:(SEL)failureCallback;

/** DELETE: /api/cuaq/delete(username:String,namefile:String) */
- (void) deleteCuaq:(NSString *)username
           fileName:(NSString *)fileName
           calledBy:(id)calledBy
        withSuccess:(SEL)successCallback;

- (void) deleteCuaq:(NSString *)username
           fileName:(NSString *)fileName
           calledBy:(id)calledBy
        withSuccess:(SEL)successCallback
         andFailure:(SEL)failureCallback;

/** PUT: /api/cuaq/like(idCuaq:String,idUser:String) */
- (void) likeCuaq:(NSString *)cuaqId
           userId:(NSString *)userId
           calledBy:(id)calledBy
        withSuccess:(SEL)successCallback;

- (void) likeCuaq:(NSString *)cuaqId
           userId:(NSString *)userId
           calledBy:(id)calledBy
        withSuccess:(SEL)successCallback
         andFailure:(SEL)failureCallback;

/** PUT: /api/cuaq/view(idCuaq:String) */
- (void) viewCuaq:(NSString *)cuaqId
             //userId:(NSString *)userId //TODO Add userId to a reproduction
           calledBy:(id)calledBy
        withSuccess:(SEL)successCallback;

- (void) viewCuaq:(NSString *)cuaqId
             //userId:(NSString *)userId //TODO Add userId to a reproduction
           calledBy:(id)calledBy
        withSuccess:(SEL)successCallback
         andFailure:(SEL)failureCallback;

/** PUT: /api/cuaq/addRequaq(idCuaq:String,idUser:String) */
- (void) recuaqCuaq:(NSString *)cuaqId
             userId:(NSString *)userId
           calledBy:(id)calledBy
        withSuccess:(SEL)successCallback;

- (void) recuaqCuaq:(NSString *)cuaqId
             userId:(NSString *)userId
           calledBy:(id)calledBy
        withSuccess:(SEL)successCallback
         andFailure:(SEL)failureCallback;

/** POST: /api/cuaq/comment */
- (void) commentCuaq:(NSDictionary *)data
            calledBy:(id)calledBy
         withSuccess:(SEL)successCallback;

- (void) commentCuaq:(NSDictionary *)data
            calledBy:(id)calledBy
         withSuccess:(SEL)successCallback
          andFailure:(SEL)failureCallback;

/** GET: /api/cuaq/getUserInfo(idUser:String) */
- (void) getUserById:(NSString *)userId
                      calledBy:(id)calledBy
                   withSuccess:(SEL)successCallback;

- (void) getUserById:(NSString *)userId
                      calledBy:(id)calledBy
                   withSuccess:(SEL)successCallback
                    andFailure:(SEL)failureCallback;

/** GET: /api/user/search(search:String) */
- (void) getUserByKey:(NSString *)key
             calledBy:(id)calledBy
          withSuccess:(SEL)successCallback;

- (void) getUserByKey:(NSString *)key
             calledBy:(id)calledBy
          withSuccess:(SEL)successCallback
           andFailure:(SEL)failureCallback;

/** PUT: /api/settings/image
 *
 * Data format (JSON):
 * {
 *   "idUser": "52139a9344aecfa90b8583dd",
 *   "content": "Base64stringOfImageData",
 *   "formato" : "jpg"
 * }
 *
 */
- (void) uploadImage:(NSDictionary *)data
           calledBy:(id)calledBy
        withSuccess:(SEL)successCallback;

- (void) uploadImage:(NSDictionary *)data
           calledBy:(id)calledBy
        withSuccess:(SEL)successCallback
         andFailure:(SEL)failureCallback;

/** PUT: /api/settings/information
 *
 * Data format (JSON):
 * {
 *   "idUser": "52139a9344aecfa90b8583dd",
 *   "info1": "Description",
 *   "info2" : "Location"
 * }
 *
 */
- (void) uploadDescriptionAndLocation:(NSDictionary *)data
            calledBy:(id)calledBy
         withSuccess:(SEL)successCallback;

- (void) uploadDescriptionAndLocation:(NSDictionary *)data
            calledBy:(id)calledBy
         withSuccess:(SEL)successCallback
          andFailure:(SEL)failureCallback;

/** PUT: /api/settings/changepassword
 *
 * Data format (JSON):
 * {
 *   "idUser"   : "52139a9344aecfa90b8583dd",
 *   "pass"     : "*******",
 *   "passnew"  : "*******",
 *   "passnew2" : "*******"
 * }
 *
 */
- (void) uploadPassword:(NSDictionary *)data
               calledBy:(id)calledBy
            withSuccess:(SEL)successCallback;

- (void) uploadPassword:(NSDictionary *)data
               calledBy:(id)calledBy
            withSuccess:(SEL)successCallback
             andFailure:(SEL)failureCallback;

/** PUT: /api/settings/voiceNick
 *
 * Data format (JSON):
 * {
 *   "idUser": "52139a9344aecfa90b8583dd",
 *   "content": "base64string",
 *   "formato" : "opus",
 *   "voicenickduration" : "3345"
 * }
 *
 */
- (void) uploadVoicenick:(NSDictionary *)data
                calledBy:(id)calledBy
             withSuccess:(SEL)successCallback;

- (void) uploadVoicenick:(NSDictionary *)data
                calledBy:(id)calledBy
             withSuccess:(SEL)successCallback
              andFailure:(SEL)failureCallback;

/** POST: /api/follow
 *
 * Data format (JSON):
 * {
 *   "cuaq": {
 *     "user" : "52139a9344aecfa90b8583dd",
 *     "userFollow" : "contentText"
 *   }
 * }
 *
 */
- (void) follow:(NSDictionary *)data
           calledBy:(id)calledBy
        withSuccess:(SEL)successCallback;

- (void) follow:(NSDictionary *)data
           calledBy:(id)calledBy
        withSuccess:(SEL)successCallback
         andFailure:(SEL)failureCallback;

/** POST: /api/followRemove
 *
 * Data format (JSON):
 * {
 *   "cuaq": {
 *     "user" : "52139a9344aecfa90b8583dd",
 *     "userFollow" : "contentText"
 *   }
 * }
 *
 */
- (void) unfollow:(NSDictionary *)data
       calledBy:(id)calledBy
    withSuccess:(SEL)successCallback;

- (void) unfollow:(NSDictionary *)data
       calledBy:(id)calledBy
    withSuccess:(SEL)successCallback
     andFailure:(SEL)failureCallback;

/** GET: /api/getFollowers(idUser:String) */
- (void) getFollowers:(NSString *)userId
              calledBy:(id)calledBy
           withSuccess:(SEL)successCallback;

- (void) getFollowers:(NSString *)userId
              calledBy:(id)calledBy
           withSuccess:(SEL)successCallback
            andFailure:(SEL)failureCallback;

/** GET: /api/getFollowed(idUser:String) */
- (void) getFollowings:(NSString *)userId
              calledBy:(id)calledBy
           withSuccess:(SEL)successCallback;

- (void) getFollowings:(NSString *)userId
              calledBy:(id)calledBy
           withSuccess:(SEL)successCallback
            andFailure:(SEL)failureCallback;
#pragma mark -
#pragma mark estanQe
/** GET: /api/cuaqs/find/{userId}/{search}/{pageSize}/{beginElementId} */
- (void) getCuaqsFind:(NSString *)userId
               search:(NSString *)search
             pageSize:(NSString *)pageSize
       beginElementId:(NSString *)beginElementId
             calledBy:(id)calledBy
          withSuccess:(SEL)successCallback;

- (void) getCuaqsFind:(NSString *)userId
               search:(NSString *)search
             pageSize:(NSString *)pageSize
       beginElementId:(NSString *)beginElementId
             calledBy:(id)calledBy
          withSuccess:(SEL)successCallback
           andFailure:(SEL)failureCallback;

/** GET: /api/cuaqs/findOrientation/{userId}/{search}/{orientation}/{pageSize}/{beginElementId} */
- (void) getCuaqsFind:(NSString *)userId
               search:(NSString *)search
          orientation:(NSString *)orientation
             pageSize:(NSString *)pageSize
       beginElementId:(NSString *)beginElementId
             calledBy:(id)calledBy
          withSuccess:(SEL)successCallback;

- (void) getCuaqsFind:(NSString *)userId
               search:(NSString *)search
          orientation:(NSString *)orientation
             pageSize:(NSString *)pageSize
       beginElementId:(NSString *)beginElementId
             calledBy:(id)calledBy
          withSuccess:(SEL)successCallback
           andFailure:(SEL)failureCallback;

/** GET: /api/cuaqs/nCuaqsofUser/{userId}/{orientation}/{pageSize}/{beginElementId} */
- (void) getCuaqsByUserId:(NSString *)userId
              orientation:(NSString *)orientation
             pageSize:(NSString *)pageSize
       beginElementId:(NSString *)beginElementId
             calledBy:(id)calledBy
              withSuccess:(SEL)successCallback __deprecated;

- (void) getCuaqsByUserId:(NSString *)userId
              orientation:(NSString *)orientation
             pageSize:(NSString *)pageSize
       beginElementId:(NSString *)beginElementId
             calledBy:(id)calledBy
          withSuccess:(SEL)successCallback
           andFailure:(SEL)failureCallback __deprecated;

/** GET: /api/v2/cuaqs/nCuaqsofUser/:userOriginId/:userId/:orientation/:pageSize/:beginElementId */
- (void) getCuaqsWithUserOriginId:(NSString *)userOriginId
                           userId:(NSString *)userId
                      orientation:(NSString *)orientation
                         pageSize:(NSString *)pageSize
                   beginElementId:(NSString *)beginElementId
                         calledBy:(id)calledBy
                      withSuccess:(SEL)successCallback;

- (void) getCuaqsWithUserOriginId:(NSString *)userOriginId
                           userId:(NSString *)userId
                      orientation:(NSString *)orientation
                         pageSize:(NSString *)pageSize
                   beginElementId:(NSString *)beginElementId
                         calledBy:(id)calledBy
                      withSuccess:(SEL)successCallback
                       andFailure:(SEL)failureCallback;

/** GET: /api/cuaqs/followingCuaqs/{userId}/{orientation}/{pageSize}/{beginElementId} */
- (void) getFollowing:(NSString *)userId
          orientation:(NSString *)orientation
                 pageSize:(NSString *)pageSize
           beginElementId:(NSString *)beginElementId
                 calledBy:(id)calledBy
              withSuccess:(SEL)successCallback;

- (void) getFollowing:(NSString *)userId
          orientation:(NSString *)orientation
                 pageSize:(NSString *)pageSize
           beginElementId:(NSString *)beginElementId
                 calledBy:(id)calledBy
              withSuccess:(SEL)successCallback
               andFailure:(SEL)failureCallback;

/** GET: /api/users/allUsers/{userId}/{orientation}/{pageSize}/{beginElementId} */
- (void) getAllUsers:(NSString *)userId
         orientation:(NSString *)orientation
             pageSize:(NSString *)pageSize
       beginElementId:(NSString *)beginElementId
             calledBy:(id)calledBy
          withSuccess:(SEL)successCallback;

- (void) getAllUsers:(NSString *)userId
         orientation:(NSString *)orientation
             pageSize:(NSString *)pageSize
       beginElementId:(NSString *)beginElementId
             calledBy:(id)calledBy
          withSuccess:(SEL)successCallback
           andFailure:(SEL)failureCallback;

/** GET: /api/cuaqs/allCuaqs/{userId}/{orientation}/{pageSize}/{beginElementId} */
- (void) getAllCuaqs:(NSString *)userId
         orientation:(NSString *)orientation
            pageSize:(NSString *)pageSize
      beginElementId:(NSString *)beginElementId
            calledBy:(id)calledBy
         withSuccess:(SEL)successCallback;

- (void) getAllCuaqs:(NSString *)userId
         orientation:(NSString *)orientation
            pageSize:(NSString *)pageSize
      beginElementId:(NSString *)beginElementId
            calledBy:(id)calledBy
         withSuccess:(SEL)successCallback
          andFailure:(SEL)failureCallback;

/** GET: /api/users/find/{userId}/{search}/{pageSize}/{beginElementId} */
- (void) getUsersFind:(NSString *)userId
               search:(NSString *)search
            pageSize:(NSString *)pageSize
      beginElementId:(NSString *)beginElementId
            calledBy:(id)calledBy
         withSuccess:(SEL)successCallback;

- (void) getUsersFind:(NSString *)userId
               search:(NSString *)search
            pageSize:(NSString *)pageSize
      beginElementId:(NSString *)beginElementId
            calledBy:(id)calledBy
         withSuccess:(SEL)successCallback
          andFailure:(SEL)failureCallback;

/** GET: /api/users/findOrientation/{userId}/{search}/{orientation}/{pageSize}/{beginElementId} */
- (void) getUsersFind:(NSString *)userId
               search:(NSString *)search
          orientation:(NSString *)orientation
             pageSize:(NSString *)pageSize
       beginElementId:(NSString *)beginElementId
             calledBy:(id)calledBy
          withSuccess:(SEL)successCallback;

- (void) getUsersFind:(NSString *)userId
               search:(NSString *)search
          orientation:(NSString *)orientation
             pageSize:(NSString *)pageSize
       beginElementId:(NSString *)beginElementId
             calledBy:(id)calledBy
          withSuccess:(SEL)successCallback
           andFailure:(SEL)failureCallback;
#pragma mark -

/** GET: /api/cuaqs/timeline/:userId/:orientation/:pageSize/:beginElementId */
- (void) getTimeline:(NSString *)userId
          orientation:(NSString *)orientation
             pageSize:(NSString *)pageSize
       beginElementId:(NSString *)beginElementId
             calledBy:(id)calledBy
          withSuccess:(SEL)successCallback;

- (void) getTimeline:(NSString *)userId
          orientation:(NSString *)orientation
             pageSize:(NSString *)pageSize
       beginElementId:(NSString *)beginElementId
             calledBy:(id)calledBy
          withSuccess:(SEL)successCallback
           andFailure:(SEL)failureCallback;

/** GET: /api/cuaqs/discoverCuaqs/:userId/:orientation/:pageSize/:beginElementId */
- (void) getDiscoverCuaqs:(NSString *)userId
         orientation:(NSString *)orientation
            pageSize:(NSString *)pageSize
      beginElementId:(NSString *)beginElementId
            calledBy:(id)calledBy
         withSuccess:(SEL)successCallback;

- (void) getDiscoverCuaqs:(NSString *)userId
         orientation:(NSString *)orientation
            pageSize:(NSString *)pageSize
      beginElementId:(NSString *)beginElementId
            calledBy:(id)calledBy
         withSuccess:(SEL)successCallback
          andFailure:(SEL)failureCallback;

/** GET: /api/users/info/:userId */
- (void) getUserInfo:(NSString *)userId
                 calledBy:(id)calledBy
              withSuccess:(SEL)successCallback;

- (void) getUserInfo:(NSString *)userId
                 calledBy:(id)calledBy
              withSuccess:(SEL)successCallback
               andFailure:(SEL)failureCallback;

#pragma mark -
#pragma mark Suggestions
/** GET: /api/users/suggestions/random/:userId/:size */
- (void) getUserSuggestionsRandom:(NSString *)userId
                             size:(int)size
                         calledBy:(id)calledBy
                      withSuccess:(SEL)successCallback;

- (void) getUserSuggestionsRandom:(NSString *)userId
                             size:(int)size
                         calledBy:(id)calledBy
                      withSuccess:(SEL)successCallback
                       andFailure:(SEL)failureCallback;

#pragma mark Facebook
/** POST: /api/2/addFriendsFB
 *
 * Data format (JSON):
 * {
 *   "friends": ["12345678", "12345679", "12345680"],
 *   "userIdFB": "12345632"
 * }
 *
 */
- (void) sendFacebookFriends:(NSDictionary *)data
            calledBy:(id)calledBy
         withSuccess:(SEL)successCallback;

- (void) sendFacebookFriends:(NSDictionary *)data
            calledBy:(id)calledBy
         withSuccess:(SEL)successCallback
          andFailure:(SEL)failureCallback;
#pragma mark -
#pragma mark Failure Callbacks

- (void) defaultFailureCallback;

@end
