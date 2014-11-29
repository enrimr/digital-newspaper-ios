//
//  CEMArticleViewController.m
//  elmundo
//
//  Created by Enrique Ismael Mendoza Robaina on 29/11/14.
//  Copyright (c) 2014 cuaQea SL. All rights reserved.
//

#import "CEMArticleViewController.h"
#import "CQANavigationBarUtils.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "CQAInvitePeopleUtils.h"

@interface CEMArticleViewController ()
{
    NSString *lastActionSheet;
}
@end

@implementation CEMArticleViewController

- (id)initWithTitle:(NSString *)aTitle
            article:(NSDictionary *)anArticle
         backButton:(BOOL)showBackButton
              style:(UITableViewStyle)aStyle
{
    if (self = [super initWithNibName:nil bundle:nil]) {
        _model = anArticle;
        _backButton = showBackButton;
        self.title = aTitle;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.scroll setDelegate:self];

    [self.articleTitle setText:[_model objectForKey:@"title"]];
    
    NSString *imageUrlString = nil;
    NSArray *arrayOfImages = (NSArray *)[_model objectForKey:@"images"];
    int imagesCount = 0;
    if (arrayOfImages == nil || [arrayOfImages count] == 0){
        arrayOfImages = nil;
        [self.articleImage setImage:[UIImage imageNamed:@"imageBackground"]];
    } else {
        imagesCount = (int)[arrayOfImages count];
        imageUrlString = [arrayOfImages objectAtIndex:0];
        [self.articleImage sd_setImageWithURL:[NSURL URLWithString:imageUrlString]
                                    completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                        NSLog(@"Cargada");
                                    }];
    }
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithData:[[_model objectForKey:@"text"] dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    
    /*NSInteger stringLength=[[_model objectForKey:@"text"] length];
    [attributedString addAttribute:NSFontAttributeName
                            value:[UIFont fontWithName:@"MuseoSans-700" size:12.0]
                            range:NSMakeRange(0, stringLength)];
    [attributedString addAttribute:NSForegroundColorAttributeName
                            value:[UIColor darkGrayColor]
                            range:NSMakeRange(0, stringLength)];*/
    
    [self.articleText setAttributedText:attributedString];
    
    [self.articleCreator setText:[_model objectForKey:@"creator"]];
    
    
    // Calculamos el timestamp
    NSTimeInterval dateToday = [[NSDate date] timeIntervalSince1970];
    NSString *time = [NSString stringWithFormat:@"%@",[_model objectForKey:@"publicationDate"]];
    NSString *time10 = [time substringToIndex:10];
    int timeInt = [time10 intValue];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd 'de' MMMM 'de' YYYY 'a las' HH:mm'h'"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    NSDate *dateArticleNSDate = [NSDate dateWithTimeIntervalSince1970:timeInt];
    NSString *formattedDate = [dateFormatter stringFromDate:dateArticleNSDate];
    
    [self.articleDate setText:formattedDate];
    


    
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    self.navigationItem.leftBarButtonItem =
    [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_TabNavBlueArrowNav"]
                                     style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(backButtonClick)];
    
    UIBarButtonItem *search = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_10_news_comment"]
                                                               style:UIBarButtonItemStylePlain
                                                              target:self
                                                              action:@selector(commentArticle)];
    [search setImageInsets:UIEdgeInsetsMake(0.0, -2.5, 0, -75)];
    
    UIBarButtonItem *profile = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_07_share"]
                                                                style:UIBarButtonItemStylePlain
                                                               target:self
                                                               action:@selector(invitePeople)];
    [profile setImageInsets:UIEdgeInsetsMake(0.0, -2.5, 0, -35)];
    
    UIBarButtonItem *menu = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_02_actionbar_options"]
                                                             style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:nil];
    [menu setImageInsets:UIEdgeInsetsMake(0.0, -2.5, 0, 5)];
    
    self.navigationItem.rightBarButtonItems = @[menu, profile, search];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)voteArticle:(id)sender {
    [self voteArticleAction];
}

- (void) backButtonClick {
    NSLog(@"backButtonClick local");
    [[CQANavigationBarUtils alloc] backButtonClick:self.navigationController];
}

-(void)invitePeople{
    lastActionSheet = @"invite";
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"Share with friends", nil)
                                                             delegate:self
                                                    cancelButtonTitle:NSLocalizedString(@"Cancel", nil)
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Whatsapp", @"Twitter", @"Facebook", nil];
    
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showFromBarButtonItem:self.parentViewController.navigationItem.leftBarButtonItem animated:YES];
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if ([lastActionSheet isEqualToString:@"invite"]){
        CQAInvitePeopleUtils *inviteUtils = [[CQAInvitePeopleUtils alloc] init];
        switch (buttonIndex) {
            case 0:
                [inviteUtils inviteByWhatsapp:[_model objectForKey:@"guid"]
                                      article:[_model objectForKey:@"articleId"]];
                break;
            case 1:
                [inviteUtils inviteByTwitterFrom:self
                                             url:[_model objectForKey:@"guid"]
                                         article:[_model objectForKey:@"articleId"]];
                break;
            case 2:
                [inviteUtils inviteByFacebookFrom:self
                                              url:[_model objectForKey:@"guid"]
                                          article:[_model objectForKey:@"articleId"]];
                break;
        }
    } else if ([lastActionSheet isEqualToString:@"vote"]){
        switch (buttonIndex) {
            case 0:
                [[CEMElMundoApi alloc] voteArticle:[_model objectForKey:@"articleId"]
                                            userId:@"userId"
                                         voteValue:4
                                          calledBy:self
                                       withSuccess:@selector(voteArticleDidEnd:)
                                        andFailure:@selector(voteArticleFailure:)];
                break;
            case 1:
                [[CEMElMundoApi alloc] voteArticle:[_model objectForKey:@"articleId"]
                                            userId:@"enrique"
                                         voteValue:2
                                          calledBy:self
                                       withSuccess:@selector(voteArticleDidEnd:)
                                        andFailure:@selector(voteArticleFailure:)];
                break;
            case 2:
                [[CEMElMundoApi alloc] voteArticle:[_model objectForKey:@"articleId"]
                                            userId:@"enrique"
                                         voteValue:0
                                          calledBy:self
                                       withSuccess:@selector(voteArticleDidEnd:)
                                        andFailure:@selector(voteArticleFailure:)];
                break;
            case 3:
                [[CEMElMundoApi alloc] voteArticle:[_model objectForKey:@"articleId"]
                                            userId:@"enrique"
                                         voteValue:-1
                                          calledBy:self
                                       withSuccess:@selector(voteArticleDidEnd:)
                                        andFailure:@selector(voteArticleFailure:)];
                break;
            case 4:
                [[CEMElMundoApi alloc] voteArticle:[_model objectForKey:@"articleId"]
                                            userId:@"enrique"
                                         voteValue:-3
                                          calledBy:self
                                       withSuccess:@selector(voteArticleDidEnd:)
                                        andFailure:@selector(voteArticleFailure:)];
                break;
        }
    } else if ([lastActionSheet isEqualToString:@"comment"]){
        
    }
}

-(void)voteArticleDidEnd:(id)result{
    NSLog(@"voteArticleDidEnd");
}

-(void)voteArticleFailure:(id)result{
    NSLog(@"voteArticleFailure");
}

-(void)voteArticleAction{
    lastActionSheet = @"vote";
    UIActionSheet * action = [[UIActionSheet alloc]
                              initWithTitle:@"Puntúa la noticia"
                              delegate:self
                              cancelButtonTitle:@"Cancel"
                              destructiveButtonTitle:nil
                              otherButtonTitles:@"Sorprendido", @"Satisfecho", @"Indiferente", @"Enfadado", @"Triste", nil];
    
    /*[[[action valueForKey:@"_buttons"] objectAtIndex:0] setImage:[UIImage imageNamed:@"ic_11_moods_astonished"] forState:UIControlStateNormal];
    [[[action valueForKey:@"_buttons"] objectAtIndex:1] setImage:[UIImage imageNamed:@"ic_11_moods_pleased"] forState:UIControlStateNormal];
    [[[action valueForKey:@"_buttons"] objectAtIndex:2] setImage:[UIImage imageNamed:@"ic_11_moods_indiferent"] forState:UIControlStateNormal];
    [[[action valueForKey:@"_buttons"] objectAtIndex:3] setImage:[UIImage imageNamed:@"ic_11_moods_worried"] forState:UIControlStateNormal];
    [[[action valueForKey:@"_buttons"] objectAtIndex:4] setImage:[UIImage imageNamed:@"ic_11_moods_sorry"] forState:UIControlStateNormal];*/
    action.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [action showFromBarButtonItem:self.parentViewController.navigationItem.leftBarButtonItem animated:YES];

}

-(void)commentArticle{
    lastActionSheet = @"comment";
    UIActionSheet * action = [[UIActionSheet alloc]
                              initWithTitle:@"Comenta la noticia"
                              delegate:self
                              cancelButtonTitle:@"Cancelar"
                              destructiveButtonTitle:nil
                              otherButtonTitles:@"Con texto", @"Con voz", @"Con video", nil];
    
    action.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [action showFromBarButtonItem:self.parentViewController.navigationItem.leftBarButtonItem animated:YES];
    
}
@end
