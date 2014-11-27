//
//  CuaqeApi.h
//  Cuaqea
//
//  Created by Enrique Mendoza Robaina on 27/11/13.
//  Copyright (c) 2013 Cuaqea SL. All rights reserved.
//

#import "CQACuaqeaApi.h"

/* Warning suppress: "Perform selector can cause a memo leak"
 * Stack overflow question number 7017281
 */
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

@implementation CQACuaqeaApi {}

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
            withSuccess:(SEL)successCallback{
    [self registerCuaqea:data
                calledBy:calledBy
             withSuccess:successCallback
              andFailure:@selector(defaultFailureCallback)];
}

- (void) registerCuaqea:(NSDictionary *)data
               calledBy:(id)calledBy
            withSuccess:(SEL)successCallback
             andFailure:(SEL)failureCallback{
    [self placePostRequest:@"api/register_cuaqea"
                  withData:data
               withHandler:^(NSURLResponse *response, NSData *rawData, NSError *error) {
                   NSString *string = [[NSString alloc] initWithData:rawData
                                                            encoding:NSUTF8StringEncoding];
                   
                   NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
                   int code = [httpResponse statusCode];
                   NSLog(@"%d", code);
                   
                   if (!(code >= 200 && code < 300)) {
                       NSLog(@"ERROR (%d): %@", code, string);
                       [calledBy performSelector:failureCallback withObject:string];
                   } else {
                       NSLog(@"OK");
                       NSDictionary *result = [NSDictionary dictionaryWithObjectsAndKeys:
                                               string, @"username",
                                               //string, @"id",
                                               nil];
                       [calledBy performSelector:successCallback withObject:result];
                   }
               }];
}

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
             withSuccess:(SEL)successCallback{
    [self registerTwitter:data
                calledBy:calledBy
             withSuccess:successCallback
              andFailure:@selector(defaultFailureCallback)];
}

- (void) registerTwitter:(NSDictionary *)data
                calledBy:(id)calledBy
             withSuccess:(SEL)successCallback
              andFailure:(SEL)failureCallback{
    [self placePostRequest:@"api/register_twitter"
                  withData:data
               withHandler:^(NSURLResponse *response, NSData *rawData, NSError *error) {
                   NSString *string = [[NSString alloc] initWithData:rawData
                                                            encoding:NSUTF8StringEncoding];
                   
                   NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
                   int code = [httpResponse statusCode];
                   NSLog(@"%d", code);
                   
                   if (!(code >= 200 && code < 300)) {
                       NSLog(@"ERROR (%d): %@", code, string);
                       [calledBy performSelector:failureCallback withObject:string];
                   } else {
                       NSLog(@"OK");
                       NSDictionary *result = [NSDictionary dictionaryWithObjectsAndKeys:
                                               string, @"username",
                                               //string, @"id",
                                               nil];
                       [calledBy performSelector:successCallback withObject:result];
                   }
               }];
}

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
              withSuccess:(SEL)successCallback{
    [self registerFacebook:data
                calledBy:calledBy
             withSuccess:successCallback
              andFailure:@selector(defaultFailureCallback)];
}

- (void) registerFacebook:(NSDictionary *)data
                 calledBy:(id)calledBy
              withSuccess:(SEL)successCallback
               andFailure:(SEL)failureCallback{
    [self placePostRequest:@"api/2/register_facebook"
                  withData:data
               withHandler:^(NSURLResponse *response, NSData *rawData, NSError *error) {
                   NSString *string = [[NSString alloc] initWithData:rawData
                                                            encoding:NSUTF8StringEncoding];
                   
                   NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
                   int code = [httpResponse statusCode];
                   NSLog(@"%d", code);
                   
                   if (!(code >= 200 && code < 300)) {
                       NSLog(@"ERROR (%d): %@", code, string);
                       [calledBy performSelector:failureCallback withObject:string];
                   } else {
                       NSLog(@"OK");
                       NSDictionary *result = [NSDictionary dictionaryWithObjectsAndKeys:
                                               string, @"username",
                                               //string, @"id",
                                               nil];
                       [calledBy performSelector:successCallback withObject:result];
                   }
               }];

}

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
         withSuccess:(SEL)successCallback{
    [self loginCuaqea:data
             calledBy:calledBy
          withSuccess:successCallback
           andFailure:@selector(defaultFailureCallback)];
}

- (void) loginCuaqea:(NSDictionary *)data
            calledBy:(id)calledBy
         withSuccess:(SEL)successCallback
          andFailure:(SEL)failureCallback{
    [self placePostRequest:@"api/login_cuaqea"
                  withData:data
               withHandler:^(NSURLResponse *response, NSData *rawData, NSError *error) {
                   NSString *string = [[NSString alloc] initWithData:rawData
                                                            encoding:NSUTF8StringEncoding];
                   
                   NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
                   int code = [httpResponse statusCode];
                   NSLog(@"%d", code);
                   
                   if (!(code >= 200 && code < 300)) {
                       NSLog(@"ERROR (%d): %@", code, string);
                       [calledBy performSelector:failureCallback withObject:string];
                   } else {
                       NSLog(@"OK");
                       NSDictionary *result = [NSDictionary dictionaryWithObjectsAndKeys:
                                               string, @"id",
                                               nil];
                       [calledBy performSelector:successCallback withObject:result];
                   }
               }];

}

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
          withSuccess:(SEL)successCallback{
    [self loginTwitter:data
               calledBy:calledBy
            withSuccess:successCallback
             andFailure:@selector(defaultFailureCallback)];
}

- (void) loginTwitter:(NSDictionary *)data
                calledBy:(id)calledBy
             withSuccess:(SEL)successCallback
              andFailure:(SEL)failureCallback{
    [self placePostRequest:@"api/login_twitter"
                  withData:data
               withHandler:^(NSURLResponse *response, NSData *rawData, NSError *error) {
                   NSString *string = [[NSString alloc] initWithData:rawData
                                                            encoding:NSUTF8StringEncoding];
                   
                   NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
                   int code = [httpResponse statusCode];
                   NSLog(@"%d", code);
                   
                   if (!(code >= 200 && code < 300)) {
                       NSLog(@"ERROR (%d): %@", code, string);
                       [calledBy performSelector:failureCallback withObject:string];
                   } else {
                       NSLog(@"OK");
                       NSDictionary *result = [NSDictionary dictionaryWithObjectsAndKeys:
                                               string, @"id",
                                               nil];
                       [calledBy performSelector:successCallback withObject:result];
                   }
               }];

}

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
           withSuccess:(SEL)successCallback{
    [self loginFacebook:data
                calledBy:calledBy
             withSuccess:successCallback
              andFailure:@selector(defaultFailureCallback)];
}

- (void) loginFacebook:(NSDictionary *)data
              calledBy:(id)calledBy
           withSuccess:(SEL)successCallback
            andFailure:(SEL)failureCallback{
    [self placePostRequest:@"api/2/login_facebook"
                  withData:data
               withHandler:^(NSURLResponse *response, NSData *rawData, NSError *error) {
                   NSString *string = [[NSString alloc] initWithData:rawData
                                                            encoding:NSUTF8StringEncoding];
                   
                   NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
                   int code = [httpResponse statusCode];
                   NSLog(@"%d", code);
                   
                   if (!(code >= 200 && code < 300)) {
                       NSLog(@"ERROR (%d): %@", code, string);
                       [calledBy performSelector:failureCallback withObject:string];
                   } else {
                       NSLog(@"OK");
                       
                       NSDictionary *result = [NSDictionary dictionaryWithObjectsAndKeys:
                                               string, @"id",
                                               nil];
                       [calledBy performSelector:successCallback withObject:result];
                   }
               }];
}
#pragma mark Notifications
/** POST: /api/push/register
 *
 * Data format (JSON):
 * {
 *     "username"   : "johndoe",
 *     "lang"       : "es"
 * }
 *
 */
- (void) pushRegister:(NSDictionary *)data
             calledBy:(id)calledBy
          withSuccess:(SEL)successCallback{
    [self pushRegister:data
              calledBy:calledBy
           withSuccess:successCallback
            andFailure:@selector(defaultFailureCallback)];
}

- (void) pushRegister:(NSDictionary *)data
             calledBy:(id)calledBy
          withSuccess:(SEL)successCallback
           andFailure:(SEL)failureCallback{
    [self placePostRequest:@"api/push/register"
                  withData:data
               withHandler:^(NSURLResponse *response, NSData *rawData, NSError *error) {
                   NSString *string = [[NSString alloc] initWithData:rawData
                                                            encoding:NSUTF8StringEncoding];
                   
                   NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
                   int code = [httpResponse statusCode];
                   NSLog(@"%d", code);
                   
                   if (!(code >= 200 && code < 300)) {
                       NSLog(@"ERROR (%d): %@", code, string);
                       [calledBy performSelector:failureCallback withObject:string];
                   } else {
                       NSLog(@"OK");
                       
                       NSDictionary *result = [NSDictionary dictionaryWithObjectsAndKeys:
                                               string, @"id",
                                               nil];
                       [calledBy performSelector:successCallback withObject:result];
                   }
               }];
}

#pragma mark Reset Password
/** POST: /api/push/register
 *
 * Data format (JSON):
 * {
 *     "username"   : "johndoe",
 *     "lang"       : "es"
 * }
 *
 */
- (void) resetPassword:(NSDictionary *)data
              calledBy:(id)calledBy
           withSuccess:(SEL)successCallback{
    [self pushRegister:data
               calledBy:calledBy
            withSuccess:successCallback
             andFailure:@selector(defaultFailureCallback)];
}

- (void) resetPassword:(NSDictionary *)data
              calledBy:(id)calledBy
           withSuccess:(SEL)successCallback
            andFailure:(SEL)failureCallback{
    [self placePostRequest:@"api/settings/testsendmail"
                  withData:data
               withHandler:^(NSURLResponse *response, NSData *rawData, NSError *error) {
                   NSString *string = [[NSString alloc] initWithData:rawData
                                                            encoding:NSUTF8StringEncoding];
                   
                   NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
                   int code = [httpResponse statusCode];
                   NSLog(@"%d", code);
                   
                   if (!(code >= 200 && code < 300)) {
                       NSLog(@"ERROR (%d): %@", code, string);
                       [calledBy performSelector:failureCallback withObject:string];
                   } else {
                       NSLog(@"OK");
                       
                       NSDictionary *result = [NSDictionary dictionaryWithObjectsAndKeys:
                                               string, @"id",
                                               nil];
                       [calledBy performSelector:successCallback withObject:result];
                   }
               }];
}

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
 *     "sr" : "sr",
 *     "longitude" : "42.3123213",
 *     "latitude" : "-12.2434324",
 *     "morigen" : "morigen",
 *     "userImageURL" : "contentText",
 *     "contentText" : "contentText",
 *     "userLoc" : "userLoc",
 *   }
 * }
 *
 */

- (void) uploadCuaq:(NSDictionary *)data
           calledBy:(id)calledBy
        withSuccess:(SEL)successCallback{
    [self uploadCuaq:data
             calledBy:calledBy
          withSuccess:successCallback
           andFailure:@selector(defaultFailureCallback)];
}

- (void) uploadCuaq:(NSDictionary *)data
           calledBy:(id)calledBy
        withSuccess:(SEL)successCallback
         andFailure:(SEL)failureCallback{
    [self placePostRequest:@"api/cuaq/upload"
                  withData:data
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
                       NSMutableDictionary *result = [NSJSONSerialization JSONObjectWithData:rawData options:0 error:nil];
                       [calledBy performSelector:successCallback withObject:result];
                   }
               }];

}

/** GET: /api/cuaq/all(username:String) */
- (void) getAllCuaqsByUsername:(NSString *)username
                      calledBy:(id)calledBy
                   withSuccess:(SEL)successCallback{
    [self getAllCuaqsByUsername:username
               calledBy:calledBy
            withSuccess:successCallback
             andFailure:@selector(defaultFailureCallback)];
}

- (void) getAllCuaqsByUsername:(NSString *)username
                      calledBy:(id)calledBy
                   withSuccess:(SEL)successCallback
                    andFailure:(SEL)failureCallback{

    [self placeGetRequest:[NSString stringWithFormat:@"api/cuaq/all?username=%@",username]
              withHandler:^(NSURLResponse *response, NSData *rawData, NSError *error) {
                  
                  NSString *string = [[NSString alloc] initWithData:rawData
                                                           encoding:NSUTF8StringEncoding];
                  
                  NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
                  int code = [httpResponse statusCode];
                  NSLog(@"%d", code);
                  
                  if (!(code >= 200 && code < 300)) {
                      NSLog(@"ERROR (%d): %@", code, string);
                      [calledBy performSelector:failureCallback withObject:string];
                  } else {
                      NSArray *array = [NSJSONSerialization JSONObjectWithData:rawData
                                                                       options:0
                                                                         error:nil];
                      NSLog(@"getAllCuaqsByUsername OK");
                      [calledBy performSelector:successCallback withObject:array];
                  }
              }];
}

/** GET: /api/cuaq/search(search:String) */
- (void) getCuaqsByKey:(NSString *)key
              calledBy:(id)calledBy
           withSuccess:(SEL)successCallback{
    [self getCuaqsByKey:key
              calledBy:calledBy
           withSuccess:successCallback
            andFailure:@selector(defaultFailureCallback)];

}

- (void) getCuaqsByKey:(NSString *)key
              calledBy:(id)calledBy
           withSuccess:(SEL)successCallback
            andFailure:(SEL)failureCallback{
    [self placeGetRequest:[NSString stringWithFormat:@"api/cuaq/search?search=%@",key]
              withHandler:^(NSURLResponse *response, NSData *rawData, NSError *error) {
                  
                  NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
                  int code = [httpResponse statusCode];
                  NSLog(@"%d", code);
                  
                  if (!(code >= 200 && code < 300)) {
                      NSString *string = [[NSString alloc] initWithData:rawData
                                                               encoding:NSUTF8StringEncoding];
                      
                      NSLog(@"ERROR (%d): %@", code, string);
                      [calledBy performSelector:failureCallback withObject:string];
                  } else {
                      NSArray *array = [NSJSONSerialization JSONObjectWithData:rawData
                                                                       options:0
                                                                         error:nil];
                      NSLog(@"getCuaqsByKey OK");
                      [calledBy performSelector:successCallback withObject:array];
                  }
              }];
}

/** GET: /api/user/getCuaqsLikes(idUser:String) */
- (void) getCuaqsLikes:(NSString *)idUser
              calledBy:(id)calledBy
           withSuccess:(SEL)successCallback{
    [self getCuaqsLikes:idUser
               calledBy:calledBy
            withSuccess:successCallback
             andFailure:@selector(defaultFailureCallback)];
}

- (void) getCuaqsLikes:(NSString *)idUser
              calledBy:(id)calledBy
           withSuccess:(SEL)successCallback
            andFailure:(SEL)failureCallback{
    [self placeGetRequest:[NSString stringWithFormat:@"api/getCuaqsLikes?idUser=%@",idUser]
              withHandler:^(NSURLResponse *response, NSData *rawData, NSError *error) {

                  NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
                  int code = [httpResponse statusCode];
                  NSLog(@"%d", code);
                  
                  if (!(code >= 200 && code < 300)) {
                      NSString *string = [[NSString alloc] initWithData:rawData
                                                               encoding:NSUTF8StringEncoding];
                      NSLog(@"ERROR (%d): %@", code, string);
                      [calledBy performSelector:failureCallback withObject:string];
                  } else {
                      NSArray *array = [NSJSONSerialization JSONObjectWithData:rawData
                                                                       options:0
                                                                         error:nil];
                      NSLog(@"getCuaqsLikes OK");
                      [calledBy performSelector:successCallback withObject:array];
                  }
              }];
}

/** DELETE: /api/cuaq/delete(username:String,namefile:String) */
- (void) deleteCuaq:(NSString *)username
           fileName:(NSString *)fileName
           calledBy:(id)calledBy
        withSuccess:(SEL)successCallback{

}

- (void) deleteCuaq:(NSString *)username
           fileName:(NSString *)fileName
           calledBy:(id)calledBy
        withSuccess:(SEL)successCallback
         andFailure:(SEL)failureCallback{

}

/** PUT: /api/cuaq/like(idCuaq:String,idUser:String) */
- (void) likeCuaq:(NSString *)cuaqId
           userId:(NSString *)userId
         calledBy:(id)calledBy
      withSuccess:(SEL)successCallback{
    [self likeCuaq:cuaqId
            userId:userId
          calledBy:calledBy
       withSuccess:successCallback
        andFailure:@selector(defaultFailureCallback)];

}

- (void) likeCuaq:(NSString *)cuaqId
           userId:(NSString *)userId
         calledBy:(id)calledBy
      withSuccess:(SEL)successCallback
       andFailure:(SEL)failureCallback{
    
    NSDictionary *data = [[NSDictionary alloc] init];
    
    [self placePutRequest:[NSString stringWithFormat:@"api/cuaq/like?idCuaq=%@&idUser=%@", cuaqId, userId]
                 withData:data
              withHandler:^(NSURLResponse *response, NSData *rawData, NSError *error) {
                  NSString *string = [[NSString alloc] initWithData:rawData
                                                           encoding:NSUTF8StringEncoding];
                  
                  NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
                  int code = [httpResponse statusCode];
                  NSLog(@"%d", code);
                  
                  if (!(code >= 200 && code < 300)) {
                      NSLog(@"ERROR (%d): %@", code, string);
                      [calledBy performSelector:failureCallback withObject:string];
                  } else {
                      NSLog(@"OK");
                      [calledBy performSelector:successCallback withObject:string];
                  }
              }];
}

/** PUT: /api/cuaq/view(idCuaq:String) */
- (void) viewCuaq:(NSString *)cuaqId
//userId:(NSString *)userId //TODO Add userId to a reproduction
         calledBy:(id)calledBy
      withSuccess:(SEL)successCallback{
    [self viewCuaq:cuaqId
          calledBy:calledBy
       withSuccess:successCallback
        andFailure:@selector(defaultFailureCallback)];

}

- (void) viewCuaq:(NSString *)cuaqId
//userId:(NSString *)userId //TODO Add userId to a reproduction
         calledBy:(id)calledBy
      withSuccess:(SEL)successCallback
       andFailure:(SEL)failureCallback{
    
    NSDictionary *data = [[NSDictionary alloc] init];
    
    [self placePutRequest:[NSString stringWithFormat:@"api/cuaq/view?idCuaq=%@", cuaqId]
                 withData:data
              withHandler:^(NSURLResponse *response, NSData *rawData, NSError *error) {
                  NSString *string = [[NSString alloc] initWithData:rawData
                                                           encoding:NSUTF8StringEncoding];
                  
                  NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
                  int code = [httpResponse statusCode];
                  NSLog(@"%d", code);
                  
                  if (!(code >= 200 && code < 300)) {
                      NSLog(@"ERROR (%d): %@", code, string);
                      [calledBy performSelector:failureCallback withObject:string];
                  } else {
                      NSLog(@"OK");
                      [calledBy performSelector:successCallback withObject:string];
                  }
              }];

}

/** PUT: /api/cuaq/addRequaq(idCuaq:String,idUser:String) */
- (void) recuaqCuaq:(NSString *)cuaqId
             userId:(NSString *)userId
           calledBy:(id)calledBy
        withSuccess:(SEL)successCallback{
    [self recuaqCuaq:cuaqId
              userId:userId
          calledBy:calledBy
       withSuccess:successCallback
        andFailure:@selector(defaultFailureCallback)];

}

- (void) recuaqCuaq:(NSString *)cuaqId
             userId:(NSString *)userId
           calledBy:(id)calledBy
        withSuccess:(SEL)successCallback
         andFailure:(SEL)failureCallback{
    
    NSDictionary *data = [[NSDictionary alloc] init];
    
    [self placePutRequest:[NSString stringWithFormat:@"api/cuaq/addRecuaq?idCuaq=%@&idUser=%@", cuaqId, userId]
                 withData:data
              withHandler:^(NSURLResponse *response, NSData *rawData, NSError *error) {
                  NSString *string = [[NSString alloc] initWithData:rawData
                                                           encoding:NSUTF8StringEncoding];
                  
                  NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
                  int code = [httpResponse statusCode];
                  NSLog(@"%d", code);
                  
                  if (!(code >= 200 && code < 300)) {
                      NSLog(@"ERROR (%d): %@", code, string);
                      [calledBy performSelector:failureCallback withObject:string];
                  } else {
                      NSLog(@"OK");
                      [calledBy performSelector:successCallback withObject:string];
                  }
              }];
}

/** POST: /api/cuaq/comment */

//{"cuaq": {
//    "idCuaq":"52149a6844ae1bf5789c321e"
//    "userId":"52139a9344aecfa90b8583dd",
//    "username":"username",
//    "time" : "time",
//    "duracion" :"duracion",
//    "content" : "content",
//    "url" : "",
//    "this.formato" : "formato",
//    "this.codec" : "codec",
//    "this.sr" : "sr",
//    "morigen" : "morigen",
//    "contentText" : "contentText";
//}
//}
- (void) commentCuaq:(NSDictionary *)data
            calledBy:(id)calledBy
         withSuccess:(SEL)successCallback{
    [self commentCuaq:data
             calledBy:calledBy
          withSuccess:successCallback
           andFailure:@selector(defaultFailureCallback)];
}

- (void) commentCuaq:(NSDictionary *)data
            calledBy:(id)calledBy
         withSuccess:(SEL)successCallback
          andFailure:(SEL)failureCallback{
    [self placePostRequest:@"api/cuaq/comment"
                  withData:data
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
                       NSMutableDictionary *result = [NSJSONSerialization JSONObjectWithData:rawData options:0 error:nil];
                       [calledBy performSelector:successCallback withObject:result];
                   }
               }];
}

/** GET: /api/getUserInfo(idUser:String) */
- (void) getUserById:(NSString *)userId
            calledBy:(id)calledBy
         withSuccess:(SEL)successCallback {
    [self getUserById:userId
               calledBy:calledBy
            withSuccess:successCallback
             andFailure:@selector(defaultFailureCallback)];
}

- (void) getUserById:(NSString *)userId
            calledBy:(id)calledBy
         withSuccess:(SEL)successCallback
          andFailure:(SEL)failureCallback {
    
    [self placeGetRequest:[NSString stringWithFormat:@"api/getUserInfo?idUser=%@",userId]
              withHandler:^(NSURLResponse *response, NSData *rawData, NSError *error) {
                  
                  NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
                  int code = [httpResponse statusCode];
                  NSLog(@"%d", code);
                  
                  if (!(code >= 200 && code < 300)) {
                      NSString *string = [[NSString alloc] initWithData:rawData
                                                               encoding:NSUTF8StringEncoding];
                  
                      NSLog(@"ERROR (%d): %@", code, string);
                      [calledBy performSelector:failureCallback withObject:string];
                  } else {
                      NSMutableDictionary *result = [NSJSONSerialization JSONObjectWithData:rawData options:0 error:nil];
                      
                      NSLog(@"getCuaqsByKey OK");
                      [calledBy performSelector:successCallback withObject:result];
                  }
              }];

}

/** GET: /api/user/search(search:String) */
- (void) getUserByKey:(NSString *)key
            calledBy:(id)calledBy
         withSuccess:(SEL)successCallback {
    [self getUserByKey:key
             calledBy:calledBy
          withSuccess:successCallback
           andFailure:@selector(defaultFailureCallback)];
}

- (void) getUserByKey:(NSString *)key
            calledBy:(id)calledBy
         withSuccess:(SEL)successCallback
          andFailure:(SEL)failureCallback {
    
    [self placeGetRequest:[NSString stringWithFormat:@"api/user/search?search=%@",key]
              withHandler:^(NSURLResponse *response, NSData *rawData, NSError *error) {
                  
                  NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
                  int code = [httpResponse statusCode];
                  NSLog(@"%d", code);
                  
                  if (!(code >= 200 && code < 300)) {
                      NSString *string = [[NSString alloc] initWithData:rawData
                                                               encoding:NSUTF8StringEncoding];
                      
                      NSLog(@"ERROR (%d): %@", code, string);
                      [calledBy performSelector:failureCallback withObject:string];
                  } else {
                      NSMutableDictionary *result = [NSJSONSerialization JSONObjectWithData:rawData options:0 error:nil];
                      
                      NSLog(@"getCuaqsByKey OK");
                      [calledBy performSelector:successCallback withObject:result];
                  }
              }];
    
}

/** PUT: /api/settings/image
 *
 * Data format (JSON):
 * {
 *   "idUser": "52139a9344aecfa90b8583dd",
 *   "content": "Base64stringOfImageData",
 *   "formato" : "jpg",
 * }
 *
 */
- (void) uploadImage:(NSDictionary *)data
           calledBy:(id)calledBy
        withSuccess:(SEL)successCallback{
    [self uploadImage:data
                calledBy:calledBy
             withSuccess:successCallback
              andFailure:@selector(defaultFailureCallback)];
}

- (void) uploadImage:(NSDictionary *)data
           calledBy:(id)calledBy
        withSuccess:(SEL)successCallback
         andFailure:(SEL)failureCallback{
    [self placePutRequest:@"api/settings/image"
                  withData:data
               withHandler:^(NSURLResponse *response, NSData *rawData, NSError *error) {
                   NSString *string = [[NSString alloc] initWithData:rawData
                                                            encoding:NSUTF8StringEncoding];
                   
                   NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
                   int code = [httpResponse statusCode];
                   NSLog(@"%d", code);
                   
                   if (!(code >= 200 && code < 300)) {
                       NSLog(@"ERROR (%d): %@", code, string);
                       [calledBy performSelector:failureCallback withObject:string];
                   } else {
                       NSLog(@"OK");
                       [calledBy performSelector:successCallback withObject:string];
                   }
               }];
}

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
                          withSuccess:(SEL)successCallback{
    [self uploadDescriptionAndLocation:data
             calledBy:calledBy
          withSuccess:successCallback
           andFailure:@selector(defaultFailureCallback)];
}

- (void) uploadDescriptionAndLocation:(NSDictionary *)data
                             calledBy:(id)calledBy
                          withSuccess:(SEL)successCallback
                           andFailure:(SEL)failureCallback{
    [self placePutRequest:@"api/settings/information"
                 withData:data
              withHandler:^(NSURLResponse *response, NSData *rawData, NSError *error) {
                  NSString *string = [[NSString alloc] initWithData:rawData
                                                           encoding:NSUTF8StringEncoding];
                  
                  NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
                  int code = [httpResponse statusCode];
                  NSLog(@"%d", code);
                  
                  if (!(code >= 200 && code < 300)) {
                      NSLog(@"ERROR (%d): %@", code, string);
                      [calledBy performSelector:failureCallback withObject:string];
                  } else {
                      NSLog(@"OK");
                      [calledBy performSelector:successCallback withObject:data];
                  }
              }];
}

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
                          withSuccess:(SEL)successCallback{
    [self uploadPassword:data
                              calledBy:calledBy
                           withSuccess:successCallback
                            andFailure:@selector(defaultFailureCallback)];
}

- (void) uploadPassword:(NSDictionary *)data
                             calledBy:(id)calledBy
                          withSuccess:(SEL)successCallback
                           andFailure:(SEL)failureCallback{
    [self placePutRequest:@"api/settings/changepassword"
                 withData:data
              withHandler:^(NSURLResponse *response, NSData *rawData, NSError *error) {
                  NSString *string = [[NSString alloc] initWithData:rawData
                                                           encoding:NSUTF8StringEncoding];
                  
                  NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
                  int code = [httpResponse statusCode];
                  NSLog(@"%d", code);
                  
                  if (!(code >= 200 && code < 300)) {
                      NSLog(@"ERROR (%d): %@", code, string);
                      [calledBy performSelector:failureCallback withObject:string];
                  } else {
                      NSLog(@"OK");
                      [calledBy performSelector:successCallback withObject:data];
                  }
              }];
}

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
                          withSuccess:(SEL)successCallback{
    [self uploadDescriptionAndLocation:data
                              calledBy:calledBy
                           withSuccess:successCallback
                            andFailure:@selector(defaultFailureCallback)];
}

- (void) uploadVoicenick:(NSDictionary *)data
                             calledBy:(id)calledBy
                          withSuccess:(SEL)successCallback
                           andFailure:(SEL)failureCallback{
    [self placePutRequest:@"api/settings/voiceNick"
                 withData:data
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
                      [calledBy performSelector:successCallback withObject:data];
                  }
              }];
}


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
    withSuccess:(SEL)successCallback{
    [self follow:data
          calledBy:calledBy
       withSuccess:successCallback
        andFailure:@selector(defaultFailureCallback)];

}

- (void) follow:(NSDictionary *)data
       calledBy:(id)calledBy
    withSuccess:(SEL)successCallback
     andFailure:(SEL)failureCallback{
    [self placePostRequest:@"api/follow"
                  withData:data
               withHandler:^(NSURLResponse *response, NSData *rawData, NSError *error) {
                   NSString *string = [[NSString alloc] initWithData:rawData
                                                            encoding:NSUTF8StringEncoding];
                   
                   NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
                   int code = [httpResponse statusCode];
                   NSLog(@"%d", code);
                   
                   if (!(code >= 200 && code < 300)) {
                       NSLog(@"ERROR (%d): %@", code, string);
                       [calledBy performSelector:failureCallback withObject:string];
                   } else {
                       NSLog(@"OK");
                       NSDictionary *result = [NSDictionary dictionaryWithObjectsAndKeys:
                                               string, @"id",
                                               nil];
                       [calledBy performSelector:successCallback withObject:result];
                   }
               }];

}

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
      withSuccess:(SEL)successCallback {
    [self unfollow:data
          calledBy:calledBy
       withSuccess:successCallback
        andFailure:@selector(defaultFailureCallback)];
}

- (void) unfollow:(NSDictionary *)data
         calledBy:(id)calledBy
      withSuccess:(SEL)successCallback
       andFailure:(SEL)failureCallback{
    [self placePostRequest:@"api/followRemove"
                  withData:data
               withHandler:^(NSURLResponse *response, NSData *rawData, NSError *error) {
                   NSString *string = [[NSString alloc] initWithData:rawData
                                                            encoding:NSUTF8StringEncoding];
                   
                   NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
                   int code = [httpResponse statusCode];
                   NSLog(@"%d", code);
                   
                   if (!(code >= 200 && code < 300)) {
                       NSLog(@"ERROR (%d): %@", code, string);
                       [calledBy performSelector:failureCallback withObject:string];
                   } else {
                       NSLog(@"OK");
                       NSDictionary *result = [NSDictionary dictionaryWithObjectsAndKeys:
                                               string, @"id",
                                               nil];
                       [calledBy performSelector:successCallback withObject:result];
                   }
               }];

}

/** GET: /api/getFollowers(idUser:String) */
- (void) getFollowers:(NSString *)userId
             calledBy:(id)calledBy
          withSuccess:(SEL)successCallback{
    [self getFollowers:userId
             calledBy:calledBy
          withSuccess:successCallback
           andFailure:@selector(defaultFailureCallback)];
}

- (void) getFollowers:(NSString *)userId
             calledBy:(id)calledBy
          withSuccess:(SEL)successCallback
           andFailure:(SEL)failureCallback{
    [self placeGetRequest:[NSString stringWithFormat:@"api/getFollowers?idUser=%@",userId]
              withHandler:^(NSURLResponse *response, NSData *rawData, NSError *error) {
                  
                  NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
                  int code = [httpResponse statusCode];
                  NSLog(@"%d", code);
                  
                  if (!(code >= 200 && code < 300)) {
                      NSString *string = [[NSString alloc] initWithData:rawData
                                                               encoding:NSUTF8StringEncoding];
                      NSLog(@"ERROR (%d): %@", code, string);
                      [calledBy performSelector:failureCallback withObject:string];
                  } else {
                      NSArray *array = [NSJSONSerialization JSONObjectWithData:rawData
                                                                       options:0
                                                                         error:nil];
                      NSLog(@"getFollowers OK");
                      [calledBy performSelector:successCallback withObject:array];
                  }
              }];

}

/** GET: /api/getFollowed(idUser:String) */
- (void) getFollowings:(NSString *)userId
              calledBy:(id)calledBy
           withSuccess:(SEL)successCallback{
    [self getFollowings:userId
             calledBy:calledBy
          withSuccess:successCallback
           andFailure:@selector(defaultFailureCallback)];

}

- (void) getFollowings:(NSString *)userId
              calledBy:(id)calledBy
           withSuccess:(SEL)successCallback
            andFailure:(SEL)failureCallback{
    [self placeGetRequest:[NSString stringWithFormat:@"api/getFollowed?idUser=%@",userId]
              withHandler:^(NSURLResponse *response, NSData *rawData, NSError *error) {
                  
                  NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
                  int code = [httpResponse statusCode];
                  NSLog(@"%d", code);
                  
                  if (!(code >= 200 && code < 300)) {
                      NSString *string = [[NSString alloc] initWithData:rawData
                                                               encoding:NSUTF8StringEncoding];
                      NSLog(@"ERROR (%d): %@", code, string);
                      [calledBy performSelector:failureCallback withObject:string];
                  } else {
                      NSArray *array = [NSJSONSerialization JSONObjectWithData:rawData
                                                                       options:0
                                                                         error:nil];
                      NSLog(@"getFollowings OK");
                      [calledBy performSelector:successCallback withObject:array];
                  }
              }];

}

#pragma mark estanQe
/** GET: /api/cuaqs/find/{userId}/{search}/{pageSize}/{beginElementId} */
- (void) getCuaqsFind:(NSString *)userId
               search:(NSString *)search
             pageSize:(NSString *)pageSize
       beginElementId:(NSString *)beginElementId
             calledBy:(id)calledBy
          withSuccess:(SEL)successCallback{
    [self getCuaqsFind:userId
                search:search
              pageSize:pageSize
        beginElementId:beginElementId
               calledBy:calledBy
            withSuccess:successCallback
             andFailure:@selector(defaultFailureCallback)];
}

- (void) getCuaqsFind:(NSString *)userId
               search:(NSString *)search
             pageSize:(NSString *)pageSize
       beginElementId:(NSString *)beginElementId
             calledBy:(id)calledBy
          withSuccess:(SEL)successCallback
           andFailure:(SEL)failureCallback{
    NSLog(@"%@",[NSString stringWithFormat:@"%@/api/cuaqs/find/%@/%@/%@/%@",
                 URL_API_ESTANQE,
                 userId,
                 search,
                 pageSize,
                 beginElementId]);
    [self placeGetRequestWithURL:[NSString stringWithFormat:@"%@/api/cuaqs/find/%@/%@/%@/%@",
                                  URL_API_ESTANQE,
                                  userId,
                                  search,
                                  pageSize,
                                  beginElementId]
                     withHandler:^(NSURLResponse *response, NSData *rawData, NSError *error) {
                         
                         NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
                         NSInteger code = [httpResponse statusCode];
                         NSLog(@"%ld", (long)code);
                         
                         if (code == 0){
                             // error
                         } else if (!(code >= 200 && code < 300) && !(code == 500)) {
                             NSString *string = [[NSString alloc] initWithData:rawData
                                                                      encoding:NSUTF8StringEncoding];
                             NSLog(@"ERROR (%ld): %@", (long)code, string);
                             [calledBy performSelector:failureCallback withObject:string];
                         } else {
                             NSMutableDictionary *result = [NSJSONSerialization JSONObjectWithData:rawData options:0 error:nil];
                             
                             NSLog(@"/api/cuaqs/find");
                             [calledBy performSelector:successCallback withObject:result];
                         }
                     }];
}

/** GET: /api/cuaqs/findOrientation/{userId}/{search}/{orientation}/{pageSize}/{beginElementId} */
- (void) getCuaqsFind:(NSString *)userId
               search:(NSString *)search
          orientation:(NSString *)orientation
             pageSize:(NSString *)pageSize
       beginElementId:(NSString *)beginElementId
             calledBy:(id)calledBy
          withSuccess:(SEL)successCallback{
    [self getCuaqsFind:userId
                search:search
           orientation:orientation
              pageSize:pageSize
        beginElementId:beginElementId
              calledBy:calledBy
           withSuccess:successCallback
            andFailure:@selector(defaultFailureCallback)];
}

- (void) getCuaqsFind:(NSString *)userId
               search:(NSString *)search
          orientation:(NSString *)orientation
             pageSize:(NSString *)pageSize
       beginElementId:(NSString *)beginElementId
             calledBy:(id)calledBy
          withSuccess:(SEL)successCallback
           andFailure:(SEL)failureCallback{
    NSLog(@"%@", [NSString stringWithFormat:@"%@/api/cuaqs/findOrientation/%@/%@/%@/%@/%@",
                  URL_API_ESTANQE,
                  userId,
                  search,
                  orientation,
                  pageSize,
                  beginElementId]);
    [self placeGetRequestWithURL:[NSString stringWithFormat:@"%@/api/cuaqs/findOrientation/%@/%@/%@/%@/%@",
                                  URL_API_ESTANQE,
                                  userId,
                                  search,
                                  orientation,
                                  pageSize,
                                  beginElementId]
                     withHandler:^(NSURLResponse *response, NSData *rawData, NSError *error) {
                         
                         NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
                         int code = [httpResponse statusCode];
                         NSLog(@"%d", code);
                         
                         if (code == 0){
                             // error
                         } else if (!(code >= 200 && code < 300) && !(code == 500)) {
                             NSString *string = [[NSString alloc] initWithData:rawData
                                                                      encoding:NSUTF8StringEncoding];
                             NSLog(@"ERROR (%d): %@", code, string);
                             [calledBy performSelector:failureCallback withObject:string];
                         } else {
                             NSMutableDictionary *result = [NSJSONSerialization JSONObjectWithData:rawData options:0 error:nil];
                             
                             NSLog(@"getCuaqsFind OK");
                             [calledBy performSelector:successCallback withObject:result];
                         }
                     }];

}

/** GET: /api/cuaqs/nCuaqsofUser/{userId}/{orientation}/{pageSize}/{beginElementId} */
- (void) getCuaqsByUserId:(NSString *)userId
              orientation:(NSString *)orientation
                 pageSize:(NSString *)pageSize
           beginElementId:(NSString *)beginElementId
                 calledBy:(id)calledBy
              withSuccess:(SEL)successCallback{
    [self getCuaqsByUserId:userId
               orientation:orientation
                  pageSize:pageSize
            beginElementId:beginElementId
                  calledBy:calledBy
               withSuccess:successCallback
                andFailure:@selector(defaultFailureCallback)];
}

- (void) getCuaqsByUserId:(NSString *)userId
              orientation:(NSString *)orientation
                 pageSize:(NSString *)pageSize
           beginElementId:(NSString *)beginElementId
                 calledBy:(id)calledBy
              withSuccess:(SEL)successCallback
               andFailure:(SEL)failureCallback{
    NSLog(@"%@", [NSString stringWithFormat:@"%@/api/cuaqs/nCuaqsofUser/%@/%@/%@/%@",
                  URL_API_ESTANQE,
                  userId,
                  orientation,
                  pageSize,
                  beginElementId]);
    [self placeGetRequestWithURL:[NSString stringWithFormat:@"%@/api/cuaqs/nCuaqsofUser/%@/%@/%@/%@",
                                  URL_API_ESTANQE,
                                  userId,
                                  orientation,
                                  pageSize,
                                  beginElementId]
                     withHandler:^(NSURLResponse *response, NSData *rawData, NSError *error) {
                         
                         NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
                         NSInteger code = [httpResponse statusCode];
                         NSLog(@"%ld", (long)code);
                         
                         if (code == 0){
                             // error
                         } else if (!(code >= 200 && code < 300) && !(code == 500)) {
                             NSString *string = [[NSString alloc] initWithData:rawData
                                                                      encoding:NSUTF8StringEncoding];
                             NSLog(@"ERROR (%ld): %@", (long)code, string);
                             [calledBy performSelector:failureCallback withObject:string];
                         } else {
                             NSMutableDictionary *result = [NSJSONSerialization JSONObjectWithData:rawData options:0 error:nil];
                             
                             NSLog(@"/api/cuaqs/nCuaqsofUser");
                             [calledBy performSelector:successCallback withObject:result];
                         }
                     }];

}

/** GET: /api/v2/cuaqs/nCuaqsofUser/:userOriginId/:userId/:orientation/:pageSize/:beginElementId */
- (void) getCuaqsWithUserOriginId:(NSString *)userOriginId
                           userId:(NSString *)userId
                      orientation:(NSString *)orientation
                         pageSize:(NSString *)pageSize
                   beginElementId:(NSString *)beginElementId
                         calledBy:(id)calledBy
                      withSuccess:(SEL)successCallback
{
    [self getCuaqsWithUserOriginId:userOriginId
                            userId:userId
                       orientation:orientation
                          pageSize:pageSize
                    beginElementId:beginElementId
                          calledBy:calledBy
                       withSuccess:successCallback
                        andFailure:@selector(defaultFailureCallback)];
}

- (void) getCuaqsWithUserOriginId:(NSString *)userOriginId
                           userId:(NSString *)userId
                      orientation:(NSString *)orientation
                         pageSize:(NSString *)pageSize
                   beginElementId:(NSString *)beginElementId
                         calledBy:(id)calledBy
                      withSuccess:(SEL)successCallback
                       andFailure:(SEL)failureCallback
{
    [self placeGetRequestWithURL:[NSString stringWithFormat:@"%@/api/v2/cuaqs/nCuaqsofUser/%@/%@/%@/%@/%@",
                                  URL_API_ESTANQE,
                                  userOriginId,
                                  userId,
                                  orientation,
                                  pageSize,
                                  beginElementId]
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
                             NSMutableDictionary *result = [NSJSONSerialization JSONObjectWithData:rawData options:0 error:nil];
                             
                             [calledBy performSelector:successCallback withObject:result];
                         }
                     }];
}

/** GET: /api/cuaqs/followingCuaqs/{userId}/{orientation}/{pageSize}/{beginElementId} */
- (void) getFollowing:(NSString *)userId
          orientation:(NSString *)orientation
             pageSize:(NSString *)pageSize
       beginElementId:(NSString *)beginElementId
             calledBy:(id)calledBy
          withSuccess:(SEL)successCallback{
    [self getFollowing:userId
           orientation:orientation
              pageSize:pageSize
        beginElementId:beginElementId
              calledBy:calledBy
           withSuccess:successCallback
            andFailure:@selector(defaultFailureCallback)];
}

- (void) getFollowing:(NSString *)userId
          orientation:(NSString *)orientation
             pageSize:(NSString *)pageSize
       beginElementId:(NSString *)beginElementId
             calledBy:(id)calledBy
          withSuccess:(SEL)successCallback
           andFailure:(SEL)failureCallback{
    NSLog(@"%@",[NSString stringWithFormat:@"%@/api/cuaqs/followingCuaqs/%@/%@/%@/%@",
                 URL_API_ESTANQE,
                 userId,
                 orientation,
                 pageSize,
                 beginElementId]);
    [self placeGetRequestWithURL:[NSString stringWithFormat:@"%@/api/cuaqs/followingCuaqs/%@/%@/%@/%@",
                                  URL_API_ESTANQE,
                                  userId,
                                  orientation,
                                  pageSize,
                                  beginElementId]
                     withHandler:^(NSURLResponse *response, NSData *rawData, NSError *error) {
                         
                         NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
                         NSInteger code = [httpResponse statusCode];
                         NSLog(@"%ld", (long)code);
                         
                         if (code == 0){
                             // error
                         } else if (!(code >= 200 && code < 300) && !(code == 500)) {
                             NSString *string = [[NSString alloc] initWithData:rawData
                                                                      encoding:NSUTF8StringEncoding];
                             NSLog(@"ERROR (%ld): %@", (long)code, string);
                             [calledBy performSelector:failureCallback withObject:string];
                         } else {
                             NSMutableDictionary *result = [NSJSONSerialization JSONObjectWithData:rawData options:0 error:nil];
                             
                             NSLog(@"/api/cuaqs/followingCuaqs");
                             [calledBy performSelector:successCallback withObject:result];
                         }
                     }];
}

/** GET: /api/users/allUsers/{userId}/{orientation}/{pageSize}/{beginElementId} */
- (void) getAllUsers:(NSString *)userId
         orientation:(NSString *)orientation
            pageSize:(NSString *)pageSize
      beginElementId:(NSString *)beginElementId
            calledBy:(id)calledBy
         withSuccess:(SEL)successCallback{
    [self getAllUsers:userId
           orientation:orientation
              pageSize:pageSize
        beginElementId:beginElementId
              calledBy:calledBy
           withSuccess:successCallback
            andFailure:@selector(defaultFailureCallback)];
}

- (void) getAllUsers:(NSString *)userId
         orientation:(NSString *)orientation
            pageSize:(NSString *)pageSize
      beginElementId:(NSString *)beginElementId
            calledBy:(id)calledBy
         withSuccess:(SEL)successCallback
          andFailure:(SEL)failureCallback{
    
    [self placeGetRequestWithURL:[NSString stringWithFormat:@"%@/api/cuaqs/allUsers/%@/%@/%@/%@",
                                  URL_API_ESTANQE,
                                  userId,
                                  orientation,
                                  pageSize,
                                  beginElementId]
                     withHandler:^(NSURLResponse *response, NSData *rawData, NSError *error) {
                         
                         NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
                         NSInteger code = [httpResponse statusCode];
                         NSLog(@"%ld", (long)code);
                         
                         if (!(code >= 200 && code < 300) && !(code == 500)) {
                             NSString *string = [[NSString alloc] initWithData:rawData
                                                                      encoding:NSUTF8StringEncoding];
                             NSLog(@"ERROR (%ld): %@", (long)code, string);
                             [calledBy performSelector:failureCallback withObject:string];
                         } else {
                             NSMutableDictionary *result = [NSJSONSerialization JSONObjectWithData:rawData options:0 error:nil];
                             
                             NSLog(@"/api/cuaqs/allUsers");
                             [calledBy performSelector:successCallback withObject:result];
                         }
                     }];
}

/** GET: /api/cuaqs/allCuaqs/{userId}/{orientation}/{pageSize}/{beginElementId} */
- (void) getAllCuaqs:(NSString *)userId
         orientation:(NSString *)orientation
            pageSize:(NSString *)pageSize
      beginElementId:(NSString *)beginElementId
            calledBy:(id)calledBy
         withSuccess:(SEL)successCallback{
    [self getAllCuaqs:userId
           orientation:orientation
              pageSize:pageSize
        beginElementId:beginElementId
              calledBy:calledBy
           withSuccess:successCallback
            andFailure:@selector(defaultFailureCallback)];
}

- (void) getAllCuaqs:(NSString *)userId
         orientation:(NSString *)orientation
            pageSize:(NSString *)pageSize
      beginElementId:(NSString *)beginElementId
            calledBy:(id)calledBy
         withSuccess:(SEL)successCallback
          andFailure:(SEL)failureCallback{
    NSLog(@"%@",[NSString stringWithFormat:@"%@/api/cuaqs/allCuaqs/%@/%@/%@/%@",
           URL_API_ESTANQE,
           userId,
           orientation,
           pageSize,
           beginElementId]);
    [self placeGetRequestWithURL:[NSString stringWithFormat:@"%@/api/cuaqs/allCuaqs/%@/%@/%@/%@",
                                  URL_API_ESTANQE,
                                  userId,
                                  orientation,
                                  pageSize,
                                  beginElementId]
                     withHandler:^(NSURLResponse *response, NSData *rawData, NSError *error) {
                         
                         NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
                         NSInteger code = [httpResponse statusCode];
                         NSLog(@"%ld", (long)code);
                         
                         if (code == 0){
                             // error
                         } else if (!(code >= 200 && code < 300) && !(code == 500)) {
                             NSString *string = [[NSString alloc] initWithData:rawData
                                                                      encoding:NSUTF8StringEncoding];
                             NSLog(@"ERROR (%ld): %@", (long)code, string);
                             [calledBy performSelector:failureCallback withObject:string];
                         } else {
                             NSMutableDictionary *result = [NSJSONSerialization JSONObjectWithData:rawData options:0 error:nil];
                             
                             NSLog(@"/api/cuaqs/allCuaqs");
                             [calledBy performSelector:successCallback withObject:result];
                         }
                     }];
}

/** GET: /api/users/find/{userId}/{search}/{pageSize}/{beginElementId} */
- (void) getUsersFind:(NSString *)userId
               search:(NSString *)search
             pageSize:(NSString *)pageSize
       beginElementId:(NSString *)beginElementId
             calledBy:(id)calledBy
          withSuccess:(SEL)successCallback{
    [self getUsersFind:userId
          search:search
             pageSize:pageSize
       beginElementId:beginElementId
             calledBy:calledBy
          withSuccess:successCallback
           andFailure:@selector(defaultFailureCallback)];
}

- (void) getUsersFind:(NSString *)userId
               search:(NSString *)search
             pageSize:(NSString *)pageSize
       beginElementId:(NSString *)beginElementId
             calledBy:(id)calledBy
          withSuccess:(SEL)successCallback
           andFailure:(SEL)failureCallback{
    [self placeGetRequestWithURL:[NSString stringWithFormat:@"%@/api/users/find/%@/%@/%@/%@",
                                  URL_API_ESTANQE,
                                  userId,
                                  search,
                                  pageSize,
                                  beginElementId]
                     withHandler:^(NSURLResponse *response, NSData *rawData, NSError *error) {
                         
                         NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
                         NSInteger code = [httpResponse statusCode];
                         NSLog(@"%ld", (long)code);
                         
                         if (code == 0){
                             // error
                         } else if (!(code >= 200 && code < 300) && !(code == 500)) {
                             NSString *string = [[NSString alloc] initWithData:rawData
                                                                      encoding:NSUTF8StringEncoding];
                             NSLog(@"ERROR (%ld): %@", (long)code, string);
                             [calledBy performSelector:failureCallback withObject:string];
                         } else {
                             NSMutableDictionary *result = [NSJSONSerialization JSONObjectWithData:rawData options:0 error:nil];
                             
                             NSLog(@"/api/users/find");
                             [calledBy performSelector:successCallback withObject:result];
                         }
                     }];
}

/** GET: /api/users/findOrientation/{userId}/{search}/{orientation}/{pageSize}/{beginElementId} */
- (void) getUsersFind:(NSString *)userId
               search:(NSString *)search
          orientation:(NSString *)orientation
             pageSize:(NSString *)pageSize
       beginElementId:(NSString *)beginElementId
             calledBy:(id)calledBy
          withSuccess:(SEL)successCallback{
    [self getUsersFind:userId
                    search:search
               orientation:orientation
                  pageSize:pageSize
            beginElementId:beginElementId
                  calledBy:calledBy
               withSuccess:successCallback
                andFailure:@selector(defaultFailureCallback)];
}

- (void) getUsersFind:(NSString *)userId
               search:(NSString *)search
          orientation:(NSString *)orientation
             pageSize:(NSString *)pageSize
       beginElementId:(NSString *)beginElementId
             calledBy:(id)calledBy
          withSuccess:(SEL)successCallback
           andFailure:(SEL)failureCallback{
    [self placeGetRequestWithURL:[NSString stringWithFormat:@"%@/api/users/findOrientation/%@/%@/%@/%@/%@",
                                  URL_API_ESTANQE,
                                  userId,
                                  search,
                                  orientation,
                                  pageSize,
                                  beginElementId]
                     withHandler:^(NSURLResponse *response, NSData *rawData, NSError *error) {
                         
                         NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
                         NSInteger code = [httpResponse statusCode];
                         NSLog(@"%ld", (long)code);
                         
                         if (code == 0){
                             // error
                         } else if (!(code >= 200 && code < 300) && !(code == 500)) {
                             NSString *string = [[NSString alloc] initWithData:rawData
                                                                      encoding:NSUTF8StringEncoding];
                             NSLog(@"ERROR (%ld): %@", (long)code, string);
                             [calledBy performSelector:failureCallback withObject:string];
                         } else {
                             NSMutableDictionary *result = [NSJSONSerialization JSONObjectWithData:rawData options:0 error:nil];
                             
                             NSLog(@"/api/users/findOrientation");
                             [calledBy performSelector:successCallback withObject:result];
                         }
                     }];
}
#pragma mark -

/** GET: /api/cuaqs/timeline/:userId/:orientation/:pageSize/:beginElementId */
- (void) getTimeline:(NSString *)userId
          orientation:(NSString *)orientation
             pageSize:(NSString *)pageSize
       beginElementId:(NSString *)beginElementId
             calledBy:(id)calledBy
          withSuccess:(SEL)successCallback{
    [self getTimeline:userId
           orientation:orientation
              pageSize:pageSize
        beginElementId:beginElementId
              calledBy:calledBy
           withSuccess:successCallback
            andFailure:@selector(defaultFailureCallback)];
}

- (void) getTimeline:(NSString *)userId
          orientation:(NSString *)orientation
             pageSize:(NSString *)pageSize
       beginElementId:(NSString *)beginElementId
             calledBy:(id)calledBy
          withSuccess:(SEL)successCallback
           andFailure:(SEL)failureCallback{
    [self placeGetRequestWithURL:[NSString stringWithFormat:@"%@/api/cuaqs/timeline/%@/%@/%@/%@",
                                  URL_API_ESTANQE,
                                  userId,
                                  orientation,
                                  pageSize,
                                  beginElementId]
                     withHandler:^(NSURLResponse *response, NSData *rawData, NSError *error) {
                         
                         NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
                         NSInteger code = [httpResponse statusCode];
                         NSLog(@"%ld", (long)code);
                         
                         if (code == 0){
                             // error
                         } else if (!(code >= 200 && code < 300) && !(code == 500)) {
                             NSString *string = [[NSString alloc] initWithData:rawData
                                                                      encoding:NSUTF8StringEncoding];
                             NSLog(@"ERROR (%ld): %@", (long)code, string);
                             [calledBy performSelector:failureCallback withObject:string];
                         } else {
                             NSMutableDictionary *result = [NSJSONSerialization JSONObjectWithData:rawData options:0 error:nil];
                             [calledBy performSelector:successCallback withObject:result];
                         }
                     }];
}

/** GET: /api/cuaqs/discoverCuaqs/:userId/:orientation/:pageSize/:beginElementId */
- (void) getDiscoverCuaqs:(NSString *)userId
         orientation:(NSString *)orientation
            pageSize:(NSString *)pageSize
      beginElementId:(NSString *)beginElementId
            calledBy:(id)calledBy
         withSuccess:(SEL)successCallback{
    [self getDiscoverCuaqs:userId
          orientation:orientation
             pageSize:pageSize
       beginElementId:beginElementId
             calledBy:calledBy
          withSuccess:successCallback
           andFailure:@selector(defaultFailureCallback)];
}

- (void) getDiscoverCuaqs:(NSString *)userId
         orientation:(NSString *)orientation
            pageSize:(NSString *)pageSize
      beginElementId:(NSString *)beginElementId
            calledBy:(id)calledBy
         withSuccess:(SEL)successCallback
          andFailure:(SEL)failureCallback{
    [self placeGetRequestWithURL:[NSString stringWithFormat:@"%@/api/cuaqs/discoverCuaqs/%@/%@/%@/%@",
                                  URL_API_ESTANQE,
                                  userId,
                                  orientation,
                                  pageSize,
                                  beginElementId]
                     withHandler:^(NSURLResponse *response, NSData *rawData, NSError *error) {
                         
                         NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
                         NSInteger code = [httpResponse statusCode];
                         NSLog(@"%ld", (long)code);
                         
                         if (code == 0){
                             // error
                         } else if (!(code >= 200 && code < 300) && !(code == 500)) {
                             NSString *string = [[NSString alloc] initWithData:rawData
                                                                      encoding:NSUTF8StringEncoding];
                             NSLog(@"ERROR (%ld): %@", (long)code, string);
                             [calledBy performSelector:failureCallback withObject:string];
                         } else {
                             NSMutableDictionary *result = [NSJSONSerialization JSONObjectWithData:rawData options:0 error:nil];
                             [calledBy performSelector:successCallback withObject:result];
                         }
                     }];
}

/** GET: /api/users/info/:userId */
- (void) getUserInfo:(NSString *)userId
            calledBy:(id)calledBy
         withSuccess:(SEL)successCallback{
    [self getUserInfo:userId
             calledBy:calledBy
          withSuccess:successCallback
           andFailure:@selector(defaultFailureCallback)];
}

- (void) getUserInfo:(NSString *)userId
            calledBy:(id)calledBy
         withSuccess:(SEL)successCallback
          andFailure:(SEL)failureCallback{
    [self placeGetRequestWithURL:[NSString stringWithFormat:@"%@/api/users/info/%@",
                                  URL_API_ESTANQE,
                                  userId]
                     withHandler:^(NSURLResponse *response, NSData *rawData, NSError *error) {
                         
                         NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
                         NSInteger code = [httpResponse statusCode];
                         NSLog(@"%ld", (long)code);
                         
                         if (code == 0){
                             // error
                         } else if (!(code >= 200 && code < 300)) {
                             NSString *string = [[NSString alloc] initWithData:rawData
                                                                      encoding:NSUTF8StringEncoding];
                             NSLog(@"ERROR (%ld): %@", (long)code, string);
                             [calledBy performSelector:failureCallback withObject:string];
                         } else {
                             NSMutableDictionary *result = [NSJSONSerialization JSONObjectWithData:rawData options:0 error:nil];
                             [calledBy performSelector:successCallback withObject:result];
                         }
                     }];
}


#pragma mark -
#pragma mark Suggestions
/** GET: /api/users/suggestions/random/:userId/:size */
- (void) getUserSuggestionsRandom:(NSString *)userId
                             size:(int)size
                         calledBy:(id)calledBy
                      withSuccess:(SEL)successCallback{
    [self getUserSuggestionsRandom:userId
                              size:size
                          calledBy:calledBy
                       withSuccess:successCallback
                        andFailure:@selector(defaultFailureCallback)];

}

- (void) getUserSuggestionsRandom:(NSString *)userId
                             size:(int)size
                         calledBy:(id)calledBy
                      withSuccess:(SEL)successCallback
                       andFailure:(SEL)failureCallback{
    [self placeGetRequestWithURL:[NSString stringWithFormat:@"%@/api/users/suggestions/random/%@/%i",
                                  URL_API_ESTANQE,
                                  userId,
                                  size]
              withHandler:^(NSURLResponse *response, NSData *rawData, NSError *error) {
                  
                  NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
                  int code = [httpResponse statusCode];
                  NSLog(@"%d", code);
                  
                  if (!(code >= 200 && code < 300)) {
                      NSString *string = [[NSString alloc] initWithData:rawData
                                                               encoding:NSUTF8StringEncoding];
                      NSLog(@"ERROR (%d): %@", code, string);
                      [calledBy performSelector:failureCallback withObject:string];
                  } else {
                      NSMutableDictionary *result = [NSJSONSerialization JSONObjectWithData:rawData options:0 error:nil];
                      [calledBy performSelector:successCallback withObject:result];
                  }
              }];
}

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
                 withSuccess:(SEL)successCallback{
    [self sendFacebookFriends:data
                     calledBy:calledBy
                  withSuccess:successCallback
                   andFailure:@selector(defaultFailureCallback)];
}

- (void) sendFacebookFriends:(NSDictionary *)data
                    calledBy:(id)calledBy
                 withSuccess:(SEL)successCallback
                  andFailure:(SEL)failureCallback{
    [self placePostRequest:@"api/2/addFriendsFB"
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
                       NSLog(@"OK");

                       NSDictionary *result = [NSDictionary dictionaryWithObjectsAndKeys:
                                               string, @"id",
                                               nil];
                       [calledBy performSelector:successCallback withObject:result];
                   }
               }];
}
#pragma mark -
#pragma mark Failure Callbacks

- (void) defaultFailureCallback
{
    NSLog(@"Failure");
}

@end
