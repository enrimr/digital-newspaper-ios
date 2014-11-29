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
    NSString *searchKey;
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
    //[self.scroll setContentSize:CGSizeMake(320, 1000)];

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
    
    NSInteger stringLength=[[_model objectForKey:@"text"] length];
    
    /*[attributedString addAttribute:NSFontAttributeName
                            value:[UIFont fontWithName:@"MuseoSans-700" size:14.0]
                            range:NSMakeRange(0, stringLength - 20)];
    [attributedString addAttribute:NSForegroundColorAttributeName
                            value:[UIColor darkGrayColor]
                            range:NSMakeRange(0, stringLength - 20)];*/
    
    [self.articleText setAttributedText:attributedString];
    
    CGSize textViewSize = [[attributedString string] sizeWithFont:[UIFont fontWithName:@"MuseoSans-700" size:13]
                           constrainedToSize:CGSizeMake(300, FLT_MAX)
                               lineBreakMode:UILineBreakModeTailTruncation];
    [self.articleText setFrame:CGRectMake(self.articleText.frame.origin.x,
                                          self.articleText.frame.origin.y,
                                          textViewSize.width,
                                          textViewSize.height)];
    
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
    
    NSArray *categories = [_model objectForKey:@"categories"];
    
    int y = 0;
    int i = 0;
    int width = 10;
    int height = 10;
    for (NSString *category in categories) {
        CGSize stringsize = [category sizeWithFont:[UIFont fontWithName:@"MuseoSans-500" size:11]];
        if (stringsize.width <= 285) {
            if(i > 10) {
                break;
            }
            
            width += stringsize.width + 15 + 10;
            height += stringsize.height;
            if (width > 285) {
                y++;
                width = 10;
            } else {
                width -= stringsize.width;
            }
            UIButton *buttonForCategory = [[UIButton alloc] initWithFrame:CGRectMake(width,
                                                                                     10+(10+20)*y,
                                                                                     15+stringsize.width,
                                                                                     25)];
            
            [buttonForCategory setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            [buttonForCategory setFont:[UIFont fontWithName:@"MuseoSans-500" size:11]];
            [buttonForCategory setTitle:category forState:UIControlStateNormal];
            [buttonForCategory setBackgroundColor:[UIColor colorWithRed:235/255.0f green:238/255.0f blue:192/255.0f alpha:1.0]];
            [buttonForCategory addTarget:self action:@selector(searchKey:) forControlEvents:UIControlEventTouchUpInside];
            [self.categoriesView addSubview:buttonForCategory];
            i++;
            width += stringsize.width+15+10;
        }
    }
    [self.categoriesView setFrame:CGRectMake(self.categoriesView.frame.origin.x, 280+textViewSize.height-10, 300, height+10)];
    [self.commentsButton setFrame:CGRectMake(self.commentsButton.frame.origin.x,
                                            280+textViewSize.height+height+10,
                                            self.commentsButton.frame.size.width,
                                            self.commentsButton.frame.size.height)];
    
    [self.scroll setContentSize:CGSizeMake(320, 280+textViewSize.height+height+10+self.commentsButton.frame.size.height+10)];
    
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

- (IBAction)viewComments:(id)sender {
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
        
        lastActionSheet = @"commentText";
        
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Nuevo comentario", nil)
                                                         message:nil
                                                        delegate:self
                                               cancelButtonTitle:NSLocalizedString(@"Cancel", nil)
                                               otherButtonTitles:NSLocalizedString(@"Comentar", nil), nil];
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        [alert show];
    } else if ([lastActionSheet isEqualToString:@"search"]){
        switch (buttonIndex) {
            case 0:
                // El Mundo
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://ariadna.elmundo.es/buscador/archivo.html?q=%@",[searchKey stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]]];
                break;
            case 1:
                // Marca
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://cgi.marca.com/buscador/archivo_marca.html?q=%@",[[searchKey stringByReplacingOccurrencesOfString:@" " withString:@"+"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]]];
                break;
            case 2:
                // Wikipedia
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://es.wikipedia.org/wiki/%@",[[searchKey stringByReplacingOccurrencesOfString:@" " withString:@"_"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]]];
                break;
            case 3:
                // YouTube
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://www.youtube.com/results?search_query=%@",[[searchKey stringByReplacingOccurrencesOfString:@" " withString:@"+"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]]];
                break;
            case 4:
                // Amazon
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.amazon.es/s/field-keywords=%@",[[searchKey stringByReplacingOccurrencesOfString:@" " withString:@"+"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]]];
                
                break;
            case 5:
                // ASOS
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.asos.com/search/%@?q=%@",[[searchKey stringByReplacingOccurrencesOfString:@" " withString:@"-"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[[searchKey stringByReplacingOccurrencesOfString:@" " withString:@"+"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]]];
                break;
        }
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

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([lastActionSheet isEqualToString:@"commentText"]){
        if (buttonIndex == 1)
        {
            
        }
    } else if ([lastActionSheet isEqualToString:@"commentAudio"]){
        if (buttonIndex == 1)
        {
            
        }
    } else if ([lastActionSheet isEqualToString:@"commentVideo"]){
        if (buttonIndex == 1)
        {
            
        }
    }
}

-(void)searchKey:(id)sender{
    NSLog(@"searchKey");
    UIButton *button = (UIButton *)sender;
    searchKey = [[button titleLabel] text];
    NSLog(searchKey);
    lastActionSheet = @"search";
    UIActionSheet * action = [[UIActionSheet alloc]
                              initWithTitle:[NSString stringWithFormat:@"Buscar '%@' en...",searchKey]
                              delegate:self
                              cancelButtonTitle:@"Cancelar"
                              destructiveButtonTitle:nil
                              otherButtonTitles:@"El Mundo", @"Marca", @"Wikipedia", @"YouTube", @"Amazon", @"ASOS", nil];
    
    action.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [action showFromBarButtonItem:self.parentViewController.navigationItem.leftBarButtonItem animated:YES];
}
@end
