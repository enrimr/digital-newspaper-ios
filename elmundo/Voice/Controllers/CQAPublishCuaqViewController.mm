//
//  CQAPublishCuaqViewController.m
//  diary
//
//  Created by Enrique Ismael Mendoza Robaina on 7/11/14.
//  Copyright (c) 2014 cuaQea SL. All rights reserved.
//

#import "CQAPublishCuaqViewController.h"
#include "SoundTouch.h"
#include "soundstretch.h"
#import <CoreAudio/CoreAudioTypes.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioServices.h>
#import <StoreKit/StoreKit.h>
#import "CQAVoiceEffects.h"
#import "CQAAlerts.h"
#import "CQACuaqeaApi.h"
#import "CQANavigationBarUtils.h"

// Twitter
#import <Accounts/Accounts.h>
#import <Twitter/Twitter.h>
#import "OAuth+Additions.h"
#import "TWAPIManager.h"
#import "TWSignedRequest.h"

@interface CQAPublishCuaqViewController ()
{
    NSURL *file;
    
    int progressTime;
    double progressTimerInterval;
    double progressPixelInterval;
    
    NSMutableArray *elements;
    NSMutableArray *effects;
    
    NSURL *opusURL;
    NSURL *opusURLOriginal;
    
    NSString *recordingType;
    
    BOOL publishingCuaq;
    
    UITableViewCell *lastCell;
    NSString *lastEffect;
    
    BOOL moved;
    
    NSDictionary *effectSelected;
}

// Twitter
@property (nonatomic, strong) ACAccountStore *accountStore;
@property (nonatomic, strong) TWAPIManager *apiManager;
@property (nonatomic, strong) NSArray *accounts;
@property (nonatomic, strong) UIButton *reverseAuthBtn;
// Effects
@property soundtouch::SoundTouch *soundTouchEngine;
@property (nonatomic, strong) SKProduct *product;

@end

@implementation CQAPublishCuaqViewController

@synthesize progressPixelInterval, progressTimerInterval;

@synthesize play, border;

@synthesize publishTableView, effectsTableView;

@synthesize progressView = _progressView;
@synthesize playerTimer = _playerTimer;

@synthesize audioURL, audioURLString, player, playing, session, duration, durationEffect;

@synthesize audioOriginal, audioEffect, effectType;

@synthesize playButtonView;

// SOUNDTOUCH
@synthesize soundTouchEngine;

- (id)initWithCuaq:(CQACuaqModel *)aCuaq{
    if (self = [super init]) {
        _model = aCuaq;
        self.title = NSLocalizedString(@"Edit story", nil);
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _accountStore = [[ACAccountStore alloc] init];
    _apiManager = [[TWAPIManager alloc] init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTwitterAccounts) name:ACAccountStoreDidChangeNotification object:nil];
    
    [self initOptionsTable];
    [self initEffectsTable];
    effectType = @"0";
    effectSelected = [effects objectAtIndex:0];
    
    duration = [_model duration];
    
    // Configuramos el botón de enviar
    /*self.navigationController.navigationItem.rightBarButtonItem.target = self;
    [self.navigationController.navigationItem.rightBarButtonItem setTitle:NSLocalizedString(@"Publish", nil)];
    self.navigationController.navigationItem.rightBarButtonItem.action = @selector(publishCuaqControl);
    
    self.parentViewController.navigationController.navigationItem.rightBarButtonItem.target = self;
    [self.parentViewController.navigationController.navigationItem.rightBarButtonItem setTitle:NSLocalizedString(@"Publish", nil)];
    self.parentViewController.navigationController.navigationItem.rightBarButtonItem.action = @selector(publishCuaqControl);*/
    
    self.navigationItem.rightBarButtonItem.target = self;
    [self.navigationItem.rightBarButtonItem setTitle:NSLocalizedString(@"Publish", nil)];
    self.navigationItem.rightBarButtonItem.action = @selector(publishCuaqControl);
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_TabNavBlueArrowNavRight"] style:UIBarButtonItemStylePlain target:self action:@selector(publishCuaqControl)];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:BACK_BUTTON] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonClick)];
    
    [self.navigationItem.leftBarButtonItem setTitle:nil];

    
    [publishTableView setDataSource:self];
    [publishTableView setDelegate:self];
    [publishTableView setTag:0];
    [effectsTableView setDataSource:self];
    [effectsTableView setDelegate:self];
    [effectsTableView setTag:1];
    
    CALayer *layer = self.play.layer;
    [layer setCornerRadius:57]; // 72 144
    [layer setMasksToBounds:YES];
    
    self.border.backgroundColor = [[CQAColors alloc] aqua];
    layer = self.border.layer;
    [layer setCornerRadius:64]; // 79 158
    [layer setMasksToBounds:YES];
    
    audioURL = [_model localURL];
    audioURLString = [audioURL path]; // Obtenemos la string de la url
    audioOriginal = audioURL;
    
    session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:audioURL error:nil];
    [player setDelegate:self];
    
    // CREATE OPUS
    opusURL = [[[CQAAudioUtils alloc] init] generateOpusFromWAV:audioURLString fileId:@"cuaqOpus"];
    opusURLOriginal = [[[CQAAudioUtils alloc] init] generateOpusFromWAV:[audioOriginal path] fileId:@"cuaqOpusOriginal"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) publishCuaq {
    if (!publishingCuaq) {
        NSLog(@"OPUS FILE: %@", opusURL);
        
        NSString *userIdStr = [[NSUserDefaults standardUserDefaults] stringForKey:USER_ID];
        NSString *usernameStr = [[NSUserDefaults standardUserDefaults] stringForKey:USER_USERNAME];
        NSString *imageURLStr = [[NSUserDefaults standardUserDefaults] stringForKey:USER_IMAGE];
        
        /*// To publish cuaQ with effect using opusURL
         NSData *audioData = [NSData dataWithContentsOfURL:opusURL];
         NSString *base64String = [audioData base64EncodedStringWithOptions:0];*/
        
        // TODO 20141021 (quizas haya que poner efecto aquí)
        NSData *audioData = [NSData dataWithContentsOfURL:opusURLOriginal];
        NSString *base64String = [audioData base64EncodedStringWithOptions:0];
        
        NSString *fileDuration = [NSString stringWithFormat:@"%d",duration];
        
        NSTimeInterval dateToday = [[NSDate date] timeIntervalSince1970];
        int dateTodayInt = dateToday;
        NSString *datetime = [NSString stringWithFormat:@"%i000",dateTodayInt];
        
        [_model setEffect:effectType];
        
        NSString *effect = [_model effect];
        
        NSString *tags = @"iOS, diary, CQAdiary";//[[_model tags] description];
        
        UITableViewCell *titleCell = (UITableViewCell *)[publishTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        UITextField *titleTextField = (UITextField *)titleCell.accessoryView;
        NSString *cuaqTitle = titleTextField.text;
        [_model setTitle:cuaqTitle];
        
        NSNumber *isPublic;
        if ([CQACuaqeaSettings shareByCuaqea])
        {
            isPublic = @YES;
        } else {
            isPublic = @NO;
        }
        
        if ([[_model title] length] == 0) {
            [[CQAAlerts alloc] showWithMessage:NSLocalizedString(@"Your cuaQ needs a title", nil) color:[[CQAColors alloc] bittersweet] fontColor:[[CQAColors alloc] lightgray] position:nil time:ALERT_TIME view:self.view];
        } else {
            NSDictionary *cuaq = [[NSDictionary alloc] initWithObjectsAndKeys:
                                  @"amr-wb", @"codec",
                                  base64String, @"content",
                                  @"contentText", @"contentText",
                                  fileDuration, @"duracion",
                                  @"opus", @"formato",
                                  isPublic, @"ispublic",
                                  @"iPhone", @"morigen",
                                  usernameStr, @"username",
                                  effect, @"sr",
                                  tags, @"tags",
                                  datetime, @"time",
                                  [_model title], @"title",
                                  @"url", @"url",
                                  [CQAUserInfo userId], @"userId",
                                  @"0", @"numViews",
                                  imageURLStr, @"userImageURL",
                                  @"0.0", @"longitude",
                                  @"0.0", @"latitude",
                                  @"iOSPruebaLoc", @"userloc",
                                  nil];
            
            NSDictionary *dataToSend = [[NSDictionary alloc] initWithObjectsAndKeys:
                                        cuaq, @"cuaq",
                                        nil];
            
            publishingCuaq = YES;
            
            [[[CQACuaqeaApi alloc] init] uploadCuaq:dataToSend calledBy:self withSuccess:@selector(uploadCuaqDidEnd:) andFailure:@selector(uploadCuaqFailure:)];
        }
    } else {
        NSLog(@"publishCuaq NO");
    }
}

- (void) uploadCuaqDidEnd:(id)result {
    NSLog(@"uploadCuaqDidEnd");
    
    [[CQAAlerts alloc] showInTopViewWithMessage:NSLocalizedString(@"Your cuaQ has been published", nil) color:[[CQAColors alloc] aquaBlack] fontColor:[[CQAColors alloc] lightgray] position:nil time:ALERT_TIME_LONG];
    
    //publishingCuaq = NO;
    NSString *url_corta = [result objectForKey:@"url_corta"];
    url_corta = [url_corta stringByReplacingOccurrencesOfString:@"/" withString:@"%2F"]; // Transformamos la barra en el caracter ascii para urls
    NSString *url = [URL_SHARE_CUAQ stringByAppendingString:url_corta];
    /*UITableViewCell *twitterCell = (UITableViewCell *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    if (twitterCell.accessoryView.isOn) {
        //[self shareByTwitter:url];
    }
    UITableViewCell *facebookCell = (UITableViewCell *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    if (facebookCell.accessoryView.isOn) {
        //[self shareByFacebook:url];
    }*/
    
    //[CQAAppSettings updateDateForLastMainAction];
    //[[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    // Indicamos al delegado que queremos volver a la pantalla de cuaqs marcando appdelagate gotorootfromrecord
    CQAAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    [appDelegate setGoToRootFromRecord:YES];
    
    // Vamos atrás
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void) uploadCuaqFailure:(id)result {
    NSLog(@"uploadCuaqFailure");
    
    publishingCuaq = NO;
    
    [[CQAAlerts alloc] showAlert:NSLocalizedString(@"Oops, an error occurred uploading your cuaQ", nil) color:[[CQAColors alloc] bittersweet] fontColor:[[CQAColors alloc] lightgray] position:nil time:ALERT_TIME_LONG view:self.view];
}

#pragma mark Play methods
// Play
- (IBAction)playAction:(id)sender {
    NSLog(@"Playing cuaq!");
    
    if ([player isPlaying]) {
        [player stop];
        [self stopProgression];
    } else {
        // Vemos si tenemos que cargar el fichero de audio para decodificar el opus
        if (audioURL == nil){
            session = [AVAudioSession sharedInstance];
            [session setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
            
            CQAAudioUtils *audioUtils = [[CQAAudioUtils alloc] init];
            int randomId = arc4random() % 100000;
            NSString *fileId = [NSString stringWithFormat:@"file%d", randomId];
            audioURL = [audioUtils generateWAVFromURL:audioURLString fileId:fileId];
            
            player = [[AVAudioPlayer alloc] initWithContentsOfURL:audioURL error:nil];
            
            [player setDelegate:self];
        }
        
        // Si se ha devuelto una NSURL correcta, reproducimos el cuaq
        if (audioURL) {
            NSLog(@"Play cuaq");
            durationEffect = [[CQAVoiceEffects alloc] getLengthMS:audioURL];
            progressTimerInterval = 0.05;
            progressPixelInterval = 1.0/(double)(durationEffect/50);
            
            [player setCurrentTime:0.0];
            [player play];
            [play setImage:[UIImage imageNamed:@"ic_MainCuaqPause.png" ] forState:UIControlStateNormal];
            [play setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
            [self.progressView setHidden:NO];
            [self.border setHidden:YES];
            [self.progressView setProgress:0.0f animated:YES];
            self.progressView.roundedCorners = YES;
            self.progressView.trackTintColor = [UIColor clearColor];
            self.progressView.progressTintColor = [[CQAColors alloc] sunflowerMedium];
            self.progressView.thicknessRatio = 0.1f;
            [self startAnimation];
            
            //[[VoiceEffects alloc] getLengthMS:audioURL]/1000.0]
        } else {
            CQAAlerts *error = [[CQAAlerts alloc] init];
            [error showAlert:@"Error loading cuaQ" color:[[CQAColors alloc] bittersweet] fontColor:[[CQAColors alloc] lightgray] position:nil time:ALERT_TIME view:self.view];
        }
    }
    
}

- (void) stopPlaying {
    [player stop];
    [self stopProgression];
}

- (void) playCuaq:(NSURL *)audioFile {
    NSLog(@"Playing cuaq!");
    
    if ([player isPlaying]) {
        [player stop];
        [self stopProgression];
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:audioFile error:nil];
    } else {
        // Vemos si tenemos que cargar el fichero de audio para decodificar el opus
        if (session == nil){
            session = [AVAudioSession sharedInstance];
            [session setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
        }
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:audioFile error:nil];
        //[player setDelegate:self];
        NSLog(@"Play cuaq");
        durationEffect = [[CQAVoiceEffects alloc] getLengthMS:audioFile];
        progressTimerInterval = 0.05;
        progressPixelInterval = 1.0/(double)(durationEffect/50);
        [player setCurrentTime:0.0];
        [player play];
        [play setImage:[UIImage imageNamed:@"ic_MainCuaqPause.png" ] forState:UIControlStateNormal];
        [play setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [self.progressView setHidden:NO];
        [self.border setHidden:YES];
        [self.progressView setProgress:0.0f animated:YES];
        self.progressView.roundedCorners = YES;
        self.progressView.trackTintColor = [UIColor clearColor];
        self.progressView.progressTintColor = [[CQAColors alloc] sunflowerMedium];
        self.progressView.thicknessRatio = 0.1f;
        [self startAnimation];
    }
}

-(void)stopProgression{
    [self changePlayImage];
}

-(void)changePlayImage{
    [play setImage:[UIImage imageNamed:@"ic_MainCuaqPlay.png" ] forState:UIControlStateNormal];
    [play setContentEdgeInsets:UIEdgeInsetsMake(0, 7, 0, 0)];
    
    // Stop the timer
    [_playerTimer invalidate];
    _playerTimer = nil;
    
    [self.progressView setHidden:YES];
    [self.border setHidden:NO];
    [self.progressView setProgress:0.0f animated:YES];
}

- (void) audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    [self changePlayImage];
}

- (void)progressChange
{
    CGFloat progress = self.progressView.progress + progressPixelInterval;
    [_progressView setProgress:progress animated:YES];
    
    // Si llegamos al límite de
    if (_progressView.progress >= 1.0f && [_playerTimer isValid]) {
        [self stopProgression];
    }
    
    NSLog(@"%f",_progressView.progress);
}

- (void)startAnimation
{
    _playerTimer = [NSTimer scheduledTimerWithTimeInterval:progressTimerInterval
                                                  target:self
                                                selector:@selector(progressChange)
                                                userInfo:nil
                                                 repeats:YES];
}

#pragma mark - Private
/**
 *  Checks for the current Twitter configuration on the device / simulator.
 *
 *  First, we check to make sure that we've got keys to work with inside Info.plist (see README)
 *
 *  Then we check to see if the device has accounts available via +[TWAPIManager isLocalTwitterAccountAvailable].
 *
 *  Next, we ask the user for permission to access his/her accounts.
 *
 *  Upon completion, the button to continue will be displayed, or the user will be presented with a status message.
 */
- (void)refreshTwitterAccounts
{
    TWDLog(@"Refreshing Twitter Accounts \n");
    
    if (![TWAPIManager hasAppKeys]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(ERROR_TITLE_MSG, nil) message:NSLocalizedString(ERROR_NO_KEYS, nil) delegate:nil cancelButtonTitle:NSLocalizedString(ERROR_OK, nil) otherButtonTitles:nil];
        [alert show];
        
        /*SwitchCell *twitterCell = (SwitchCell *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
        [twitterCell.switchElement setOn:NO animated:YES];*/
    }
    else if (![TWAPIManager isLocalTwitterAccountAvailable]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(ERROR_TITLE_MSG, nil) message:NSLocalizedString(ERROR_NO_ACCOUNTS, nil) delegate:nil cancelButtonTitle:NSLocalizedString(ERROR_OK, nil) otherButtonTitles:nil];
        [alert show];
        
        /*SwitchCell *twitterCell = (SwitchCell *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
        [twitterCell.switchElement setOn:NO animated:YES];*/
    }
    else {
        [self obtainAccessToAccountsWithBlock:^(BOOL granted) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (granted) {
                    //_reverseAuthBtn.enabled = YES;
                    printf("Granted Access to Twitter Accounts");
                    
                    [self performReverseAuthTwitter:self];
                }
                else {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(ERROR_TITLE_MSG, nil) message:NSLocalizedString(ERROR_PERM_ACCESS, nil) delegate:nil cancelButtonTitle:NSLocalizedString(ERROR_OK, nil) otherButtonTitles:nil];
                    [alert show];
                    TWALog(@"You were not granted access to the Twitter accounts.");
                    
                    /*SwitchCell *twitterCell = (SwitchCell *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
                    [twitterCell.switchElement setOn:NO animated:YES];*/
                }
            });
        }];
    }
}

- (void)obtainAccessToAccountsWithBlock:(void (^)(BOOL))block
{
    ACAccountType *twitterType = [_accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    
    ACAccountStoreRequestAccessCompletionHandler handler = ^(BOOL granted, NSError *error) {
        if (granted) {
            self.accounts = [_accountStore accountsWithAccountType:twitterType];
        }
        
        block(granted);
    };
    
    //  This method changed in iOS6. If the new version isn't available, fall back to the original (which means that we're running on iOS5+).
    if ([_accountStore respondsToSelector:@selector(requestAccessToAccountsWithType:options:completion:)]) {
        [_accountStore requestAccessToAccountsWithType:twitterType options:nil completion:handler];
    }
    else {
        //[_accountStore requestAccessToAccountsWithType:twitterType withCompletionHandler:handler]; // Deprecated
        [_accountStore requestAccessToAccountsWithType:twitterType options:nil completion:handler];
    }
}

/**
 *  Handles the button press that initiates the token exchange.
 *
 *  We check the current configuration inside -[UIViewController viewDidAppear].
 */
- (void)performReverseAuthTwitter:(id)sender
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"Choose an Account", nil) delegate:(id)self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    for (ACAccount *acct in _accounts) {
        [sheet addButtonWithTitle:acct.username];
    }
    sheet.cancelButtonIndex = [sheet addButtonWithTitle:NSLocalizedString(@"Cancel", nil)];
    
    UIWindow* window = [[[UIApplication sharedApplication] delegate] window];
    if (![window.subviews containsObject:self.view]) {
        //[sheet showInView:window];
    } else {
        [sheet showInView:self.view];
    }
}

- (void)shareTwitterAction:(id)sender {
    NSLog(@"shareTwitterAction");
    
    UISwitch *aSwitch = (UISwitch *)sender;
    [CQACuaqeaSettings setShareByTwitter:aSwitch.on];
    
    if (![CQAUserInfo isLoggedByTwitter] && ![CQAUserInfo shareByTwitter]){
        [self refreshTwitterAccounts];
    }
}

- (void)shareFacebookAction:(id)sender {
    NSLog(@"shareFacebookAction");
    
    UISwitch *aSwitch = (UISwitch *)sender;
    [CQACuaqeaSettings setShareByFacebook:aSwitch.on];
    
    if (![CQAUserInfo isLoggedByFacebook] && ![CQAUserInfo shareByFacebook]){
        /*AppDelegate* appDelegate = [[UIApplication sharedApplication] delegate];
        [appDelegate openSession];*/
        NSLog(@"TODO: Compartido por Facebook");
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:SHARE_BY_FACEBOOK];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)shareCuaqeaAction:(id)sender {
    NSLog(@"shareCuaqeaAction");
    UISwitch *aSwitch = (UISwitch *)sender;
    [CQACuaqeaSettings setShareByCuaqea:aSwitch.on];
}

#pragma mark Effects

- (void) initOptionsTable{
    NSDictionary *titleObject = [NSDictionary dictionaryWithObjectsAndKeys:
                                 @"ic_RecorderPublishTitle.png", @"image",
                                 NSLocalizedString(@"Choose a title", nil), @"label",
                                 @"input", @"type", nil];
    
    NSDictionary *shareTwitterObject = [NSDictionary dictionaryWithObjectsAndKeys:
                                        @"ic_RecorderPublishTwitter.png", @"image",
                                        NSLocalizedString(@"Share with Twitter", nil), @"label",
                                        @"shareTwitter", @"type", nil];
    
    NSDictionary *shareFacebookObject = [NSDictionary dictionaryWithObjectsAndKeys:
                                         @"ic_RecorderPublishFacebook.png", @"image",
                                         NSLocalizedString(@"Share with Facebook", nil), @"label",
                                         @"shareFacebook", @"type", nil];
    
    NSDictionary *makePublicObject = [NSDictionary dictionaryWithObjectsAndKeys:
                                         @"ic_ProfileCuaqs.png", @"image",
                                         NSLocalizedString(@"Share with cuaQea", nil), @"label",
                                         @"makePublic", @"type", nil];
    
    elements = [[NSMutableArray alloc] init];
    
    [elements addObjectsFromArray:[NSArray arrayWithObjects:
                                   titleObject,
                                   shareTwitterObject,
                                   shareFacebookObject,
                                   makePublicObject, nil]];
    
    [playButtonView setFrame:CGRectMake(playButtonView.frame.origin.x, 30 + publishTableView.frame.size.height + (self.view.frame.size.height - publishTableView.frame.size.height)/2 - playButtonView.frame.origin.y/2, playButtonView.frame.size.width, playButtonView.frame.size.height)];
}

- (void) initEffectsTable{
    
    effects = [CQAVoiceEffects getAvailableEffects];
    
    int tableHeight = [effects count]*44;
    if (tableHeight > 176) { //si hay más de 4 elementos
        tableHeight = 195;
        [publishTableView setScrollEnabled:YES];
    }
    
    //[effectsTableView setFrame:CGRectMake(0, self.view.frame.size.height - tableHeight, 320, tableHeight)];
    [playButtonView setFrame:CGRectMake(playButtonView.frame.origin.x, 30 + (self.view.frame.size.height - tableHeight)/2 - playButtonView.frame.origin.y/2, playButtonView.frame.size.width, playButtonView.frame.size.height)];
    
}


// Crea un nuevo wav desde el original aplicando el efecto deseado
- (NSURL *) performSoundEffect:(NSDictionary *)effect{
    
    NSArray *pathComponents = [NSArray arrayWithObjects:
                               [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject], // NSUserDomainMask
                               @"cuaqWithEffect.wav",
                               nil];
    
    NSURL *outputFileURL = [NSURL fileURLWithPathComponents:pathComponents];
    
    NSString *performEffect = [effect objectForKey:@"effectString"];
    
    int _argc = 4;
    const char *_argv[]={"createWavWithEffect",[[audioOriginal path] UTF8String], [[outputFileURL path] UTF8String], [performEffect UTF8String]};
    createWavWithEffect(_argc, _argv);
    
    // Añadimos el tamaño al wav
    [[CQAAudioUtils alloc] setAudioFileSize:outputFileURL];
    
    return outputFileURL;
}

- (void) publishCuaqControl{
    [self publishCuaq];
}

#pragma mark TextField

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return (newLength > 30) ? NO : YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    if(!moved) {
        [self animateViewToPosition:self.view directionUP:YES];
        moved = YES;
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    [textField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    /*[textField resignFirstResponder];
     return NO;*/
    
    [textField resignFirstResponder];
    if(moved) {
        [self animateViewToPosition:self.view directionUP:NO];
    }
    moved = NO;
    return YES;
}

-(void)animateViewToPosition:(UIView *)viewToMove directionUP:(BOOL)up {
    
    const int movementDistance = -0; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? movementDistance : -movementDistance);
    [UIView beginAnimations: @"animateTextField" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    viewToMove.frame = CGRectOffset(viewToMove.frame, 0, movement);
    [UIView commitAnimations];
}

#pragma mark TableView Functions
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([tableView tag] == 0){
        return [elements count];
    }
    return [effects count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *item;
    
    if ([tableView tag] == 0){
        item = [elements objectAtIndex:indexPath.item];
    } else {
        item = [effects objectAtIndex:indexPath.item];
    }
    
    NSString *cellId = [item objectForKey:@"type"];
    
    if ([cellId isEqualToString:@"input"]) {
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellId];
        
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault
                                         reuseIdentifier:cellId];
        }
        
        [cell.imageView setImage:[UIImage imageNamed:[item objectForKey:@"image"]]];

        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 8, 253, 30)];
        [textField setPlaceholder:[item objectForKey:@"label"]];
        [textField setDelegate:self];
        [cell setAccessoryView:textField]; //[cell addSubview:textField];
        
        return cell;
    } else if ([cellId isEqualToString:@"shareTwitter"] || [cellId isEqualToString:@"shareFacebook"] ) {
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellId];
        
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault
                                         reuseIdentifier:cellId];
        }
        
        [cell.imageView setImage:[UIImage imageNamed:[item objectForKey:@"image"]]];
        [cell.textLabel setText:[item objectForKey:@"label"]];
        //[cell.switchElement setOn:NO];
        UISwitch *share = [[UISwitch alloc] initWithFrame:CGRectZero];
        if ([cellId isEqualToString:@"shareTwitter"]){
            [share addTarget:self action:@selector(shareTwitterAction:) forControlEvents:UIControlEventValueChanged];
            [share setOn:[CQACuaqeaSettings shareByTwitter]];
        } else {
            [share addTarget:self action:@selector(shareFacebookAction:) forControlEvents:UIControlEventValueChanged];
            [share setOn:[CQACuaqeaSettings shareByFacebook]];
        }
        [cell setAccessoryView:share];
        
        return cell;
    } else if ([cellId isEqualToString:@"makePublic"]) {
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellId];
        
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault
                                         reuseIdentifier:cellId];
        }
        
        [cell.imageView setImage:[UIImage imageNamed:[item objectForKey:@"image"]]];
        [cell.textLabel setText:[item objectForKey:@"label"]];
        UISwitch *share = [[UISwitch alloc] initWithFrame:CGRectZero];
        [share setOn:[CQACuaqeaSettings shareByCuaqea]];
        [share addTarget:self action:@selector(shareCuaqeaAction:) forControlEvents:UIControlEventValueChanged];
        [cell setAccessoryView:share];
        
        return cell;
    } else if ([cellId isEqualToString:@"effect"]) {
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"effectCell"];
        
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"effectCell"];
        }
        
        [cell.textLabel setText:[item objectForKey:@"label"]];

        [cell.imageView setImage:[UIImage imageNamed:[item objectForKey:@"image"]]];
        [cell.imageView setHighlightedImage:[UIImage imageNamed:[item objectForKey:@"selected"]]];
        [cell.textLabel setTextColor:[[CQAColors alloc] aquaMedium]];
        [cell.textLabel setHighlightedTextColor:[[CQAColors alloc] lightgray]];
        lastCell.contentView.backgroundColor = nil;
        
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView tag] == 1) {
        effectType = [[effects objectAtIndex:indexPath.row] objectForKey:@"effectType"];
        effectSelected = [effects objectAtIndex:indexPath.row];

        audioURL = [[CQAVoiceEffects alloc] performEffect:audioOriginal
                                                output:nil
                                            effectType:[[effects objectAtIndex:indexPath.row] objectForKey:@"effectType"]];
        [self playCuaq:audioURL];
    }
}

- (void) backButtonClick {
    NSLog(@"backButtonClick local");
    [[CQANavigationBarUtils alloc] backButtonClick:self.navigationController];
}

@end
