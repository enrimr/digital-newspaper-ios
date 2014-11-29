//
//  CQAInvitePeopleUtils.h
//  cuaQea
//
//  Created by Enrique Ismael Mendoza Robaina on 06/10/14.
//  Copyright (c) 2014 Cuaqea SL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CQAInvitePeopleUtils : NSObject

-(void)sendMessageByWhatsapp:(NSString *)message;

-(void)shareMessage:(NSString *)message
            withURL:(NSURL *)url
           andImage:(UIImage *)image
          byService:(NSString *)service
               from:(id)view;

-(void)inviteByWhatsapp:(NSString *)anUrl article:(NSString *)articleId;
-(void)inviteByTwitterFrom:(id)origin url:(NSString *)anUrl article:(NSString *)articleId;
-(void)inviteByFacebookFrom:(id)origin url:(NSString *)anUrl article:(NSString *)articleId;

@end
