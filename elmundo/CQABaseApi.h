//
//  BaseApi.h
//  Cuaqea
//
//  Created by Pablo López Torres on 15/08/13.
//  Copyright (c) 2013 Cuaqea SL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CEMAppDelegate.h"

@interface CQABaseApi : NSObject

-(void)placeGetRequest:(NSString *)action withHandler:(void (^)(NSURLResponse *response, NSData *data, NSError *error))ourBlock;
-(void)placeGetRequestWithURL:(NSString *)action withHandler:(void (^)(NSURLResponse *response, NSData *data, NSError *error))ourBlock;

-(void)placePostRequest:(NSString *)action withData:(NSDictionary *)dataToSend withHandler:(void (^)(NSURLResponse *response, NSData *data, NSError *error))ourBlock;
-(void)placePostRequestWithURL:(NSString *)action withData:(NSDictionary *)dataToSend withHandler:(void (^)(NSURLResponse *response, NSData *data, NSError *error))ourBlock;

-(void)placePutRequest:(NSString *)action withData:(NSDictionary *)dataToSend withHandler:(void (^)(NSURLResponse *response, NSData *data, NSError *error))ourBlock;
-(void)placePutRequestWithURL:(NSString *)action withData:(NSDictionary *)dataToSend withHandler:(void (^)(NSURLResponse *response, NSData *data, NSError *error))ourBlock;
-(void)placePutRequest:(NSString *)action withHandler:(void (^)(NSURLResponse *response, NSData *data, NSError *error))ourBlock;
-(void)placePutRequestWithURL:(NSString *)action withHandler:(void (^)(NSURLResponse *response, NSData *data, NSError *error))ourBlock;

//TODO placeDeleteRequest

@end
