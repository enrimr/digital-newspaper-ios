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

-(void)sendMessageByWhatsapp:(NSString *)message{
    NSLog(@"sendByWhatsapp:");
    
    NSURL *whatsappURL = [NSURL URLWithString:[NSString stringWithFormat:@"whatsapp://send?text=%@", [message stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    if ([[UIApplication sharedApplication] canOpenURL: whatsappURL]) {
        [[UIApplication sharedApplication] openURL: whatsappURL];
    }
}

-(void)shareMessage:(NSString *)message
       withURL:(NSURL *)url
      andImage:(UIImage *)image
     byService:(NSString *)service
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
                default:
                    break;
            }
        }];
    }
}

-(void)inviteByWhatsapp:(NSString *)anUrl{
    [self sendMessageByWhatsapp:[NSString stringWithFormat:NSLocalizedString(INVITATION_MESSAGE,nil),anUrl]];
}

-(void)inviteByTwitterFrom:(id)origin url:(NSString *)anUrl{
    [self shareMessage:[NSString stringWithFormat:NSLocalizedString(INVITATION_MESSAGE,nil),anUrl]
               withURL:[NSURL URLWithString:anUrl]
              andImage:[UIImage imageNamed:INVITATION_MESSAGE_IMAGE]
             byService:SLServiceTypeTwitter from:origin];
}

-(void)inviteByFacebookFrom:(id)origin url:(NSString *)anUrl{
    [self shareMessage:[NSString stringWithFormat:NSLocalizedString(INVITATION_MESSAGE,nil),anUrl]
               withURL:[NSURL URLWithString:anUrl]
              andImage:[UIImage imageNamed:INVITATION_MESSAGE_IMAGE]
             byService:SLServiceTypeFacebook from:origin];
}

@end
