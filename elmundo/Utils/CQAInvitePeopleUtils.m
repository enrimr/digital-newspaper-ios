//
//  CQAInvitePeopleUtils.m
//  cuaQea
//
//  Created by Enrique Ismael Mendoza Robaina on 06/10/14.
//  Copyright (c) 2014 Cuaqea SL. All rights reserved.
//

#import "CQAInvitePeopleUtils.h"
#import <Social/Social.h>

@implementation CQAInvitePeopleUtils

-(void)sendMessageByWhatsapp:(NSString *)message article:(NSString *)articleId{
    NSLog(@"sendByWhatsapp:");
    
    NSURL *whatsappURL = [NSURL URLWithString:[NSString stringWithFormat:@"whatsapp://send?text=%@", [message stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    if ([[UIApplication sharedApplication] canOpenURL: whatsappURL]) {
        [[CEMElMundoApi alloc] shareArticle:articleId
                                     userId:@"userId"
                                   calledBy:self
                                withSuccess:@selector(shareDidEnd:)
                                 andFailure:@selector(shareFailure:)];
        
        [[UIApplication sharedApplication] openURL: whatsappURL];
    }
}

-(void)shareMessage:(NSString *)message
       withURL:(NSURL *)url
      andImage:(UIImage *)image
     byService:(NSString *)service
            article:articleId
          from:(id)origin{
    if ([SLComposeViewController isAvailableForServiceType:service])
    {
        SLComposeViewController *viewController = [SLComposeViewController
                                                          composeViewControllerForServiceType:service];
        
        [viewController setInitialText:message];
        [viewController addURL:url];
        [viewController addImage:image];
        
        [origin presentViewController:viewController animated:YES completion:nil];
        
        [viewController setCompletionHandler:^(SLComposeViewControllerResult result) {
            switch (result) {
                case SLComposeViewControllerResultCancelled:
                    //NSLog(@"Action Cancelled");
                    break;
                case SLComposeViewControllerResultDone:
                    //NSLog(@"Posted");
                    [[CEMElMundoApi alloc] shareArticle:articleId
                                                 userId:@"userId"
                                               calledBy:self
                                            withSuccess:@selector(shareDidEnd:)
                                             andFailure:@selector(shareFailure:)];
                default:
                    break;
            }
        }];
    }
}

-(void)inviteByWhatsapp:(NSString *)anUrl article:(NSString *)articleId{
    [self sendMessageByWhatsapp:[NSString stringWithFormat:NSLocalizedString(INVITATION_MESSAGE,nil),anUrl]
                        article:articleId];
}

-(void)inviteByTwitterFrom:(id)origin url:(NSString *)anUrl article:(NSString *)articleId{
    [self shareMessage:[NSString stringWithFormat:NSLocalizedString(INVITATION_MESSAGE,nil),anUrl]
               withURL:[NSURL URLWithString:anUrl]
              andImage:[UIImage imageNamed:INVITATION_MESSAGE_IMAGE]
             byService:SLServiceTypeTwitter
               article:articleId
                  from:origin];
}

-(void)inviteByFacebookFrom:(id)origin url:(NSString *)anUrl article:(NSString *)articleId{
    [self shareMessage:[NSString stringWithFormat:NSLocalizedString(INVITATION_MESSAGE,nil),anUrl]
               withURL:[NSURL URLWithString:anUrl]
              andImage:[UIImage imageNamed:INVITATION_MESSAGE_IMAGE]
             byService:SLServiceTypeFacebook
               article:articleId
                  from:origin];
}

-(void)shareDidEnd:(id)result{
    NSLog(@"shareDidEnd");
    [[CQAAlerts alloc] showInTopViewWithMessage:NSLocalizedString(@"¡Tu mensaje se ha compartido!", nil)
                                          color:[UIColor colorWithRed:122/255.0f
                                                                green:213/255.0f
                                                                 blue:180/255.0f
                                                                alpha:1.0f]
                                      fontColor:[UIColor darkGrayColor]
                                       position:nil
                                           time:ALERT_TIME_LONG];
}

-(void)shareFailure:(id)result{
    NSLog(@"shareFailure");
    [[CQAAlerts alloc] showInTopViewWithMessage:NSLocalizedString(@"Se ha producido un error :S", nil)
                                          color:[UIColor colorWithRed:202/255.0f
                                                                green:81/255.0f
                                                                 blue:53/255.0f
                                                                alpha:1.0f]
                                      fontColor:[UIColor whiteColor]
                                       position:nil
                                           time:ALERT_TIME_LONG];
}
@end
