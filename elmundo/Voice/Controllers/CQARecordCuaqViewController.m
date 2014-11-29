//
//  CQARecordCuaqViewController.m
//  diary
//
//  Created by Enrique Ismael Mendoza Robaina on 6/11/14.
//  Copyright (c) 2014 cuaQea SL. All rights reserved.
//

#import "CQARecordCuaqViewController.h"
#import "CQADeviceInfo.h"
#import "CQAPublishCuaqViewController.h"

@interface CQARecordCuaqViewController ()
{
    NSURL *file;
    int progressTime;
    double progressTimerInterval;
    double progressPixelInterval;
    double cuaqDuration;
    double delay;
    BOOL alreadyFinished; // Para saber cuando cancelar el delay que te para la grabacion a los 12 segundos
}
@end

@implementation CQARecordCuaqViewController

@synthesize countdown, cancelButton, recordButton, recorderView, recorder, player;

int hours, minutes, seconds;
int secondsLeft;

- (IBAction)cancel:(id)sender {
    [self.tabBarController setSelectedIndex:0];
}

- (id)initWithUser:(CQAUserModel *)aUserModel
             title:(NSString *)aTitle
{
    if (self = [super init]) {
        _model = aUserModel;
        self.title = aTitle;
        UITabBarItem* item = [[UITabBarItem alloc] initWithTitle:nil
                                                           image:[UIImage imageNamed:@"ic_TabBarMicroOld"]
                                                   selectedImage:[UIImage imageNamed:@"ic_TabBarMicroOld"]];
        self.tabBarItem = item;
        self.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
        
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [recorderView setFrame:CGRectMake(recorderView.frame.origin.x, self.view.frame.size.height/2 - recorderView.frame.size.height/2, recorderView.frame.size.width, recorderView.frame.size.height)];
    
    progressTime = 1200;
    delay = 12.0;
    
    if ([[[CQADeviceInfo alloc] init] isMaxPower]){
        progressTimerInterval = 0.01;
        progressPixelInterval = 1.0/(double)(progressTime/1.0);
    } else {
        progressTimerInterval = 1;
        progressPixelInterval = 1.0/(double)(progressTime/105);
    }
    
    //[self configureAVAudioSession];
    
    // Set the audio file
    NSArray *pathComponents = [NSArray arrayWithObjects:
                               [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject], // NSUserDomainMask
                               @"MyAudioMemo.wav",
                               nil];
    
    NSURL *outputFileURL = [NSURL fileURLWithPathComponents:pathComponents];
    file = outputFileURL;
    
    // Setup audio session
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    
    // Define the recorder setting
    NSMutableDictionary *recordSetting = [[NSMutableDictionary alloc] init];
    
    [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatLinearPCM] forKey:AVFormatIDKey];
    [recordSetting setValue:[NSNumber numberWithFloat:16000.0] forKey:AVSampleRateKey];
    [recordSetting setValue:[NSNumber numberWithInt: 1] forKey:AVNumberOfChannelsKey];
    [recordSetting setValue:[NSNumber numberWithBool:0] forKey:AVLinearPCMIsBigEndianKey];
    [recordSetting setValue:[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
    //[recordSetting setValue:[NSNumber numberWithFloat:8.0] forKey:AVAudioTimePitchAlgorithmVarispeed];
    
    // Initiate and prepare the recorder
    recorder = [[AVAudioRecorder alloc] initWithURL:outputFileURL settings:recordSetting error:NULL];
    recorder.delegate = self;
    recorder.meteringEnabled = YES;
    
    [recorder prepareToRecord];
    
    alreadyFinished = NO;

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    CQAAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    if (appDelegate.goToRootFromRecord){
        [appDelegate setGoToRootFromRecord:NO];
        [self.tabBarController setSelectedIndex:0];
    } else {
        self.navigationController.navigationBar.hidden = YES;
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
        self.parentViewController.navigationItem.title = self.title;
        [self.tabBarController.tabBar setHidden:YES];
        [self countdownTimer:3];
    
        [recorderView setUserInteractionEnabled:YES];
        alreadyFinished = NO;
        CALayer *layer = self.recordButton.layer;
        [layer setCornerRadius:64]; // 79
        [layer setMasksToBounds:YES];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [self.tabBarController.tabBar setHidden:NO];
    alreadyFinished = YES;
    [self setupFinishRecording]; // A veces se llama cuando ya lo hemos llamado...
    [recorderView setHidden:YES];
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

// Countdown
- (void)updateCounter:(NSTimer *)theTimer {
    if(secondsLeft > 0 ){
        
        hours = secondsLeft / 3600;
        minutes = (secondsLeft % 3600) / 60;
        seconds = (secondsLeft %3600) % 60;
        if (minutes == 0 && hours == 0){
            [countdown setText:[NSString stringWithFormat:@"%d", seconds]];
        } else if (hours == 0) {
            [countdown setText:[NSString stringWithFormat:@"%02d:%02d", minutes, seconds]];
        } else {
            [countdown setText:[NSString stringWithFormat:@"%02d:%02d:%02d", hours, minutes, seconds]];
        }
        secondsLeft -- ;
    }
    else{
        [_countdownTimer invalidate];
        [countdown setHidden:YES];
        [cancelButton setHidden:NO];
        [self recordAction];
        [recorderView setHidden:NO];
    }
}

-(void)countdownTimer:(int)timeInSeconds{
    [cancelButton setHidden:YES];
    [countdown setHidden:NO];
    [countdown setText:NSLocalizedString(@"Are you ready?", nil)];
    hours = minutes = seconds = 0;
    secondsLeft = timeInSeconds;
    _countdownTimer = [NSTimer scheduledTimerWithTimeInterval:0.85f target:self selector:@selector(updateCounter:) userInfo:nil repeats:YES];
}

// Recorder

- (IBAction)record:(id)sender {
    [self recordAction];
}

-(void)recordAction{
    // Stop the audio player before recording
    if (player.playing) {
        [player stop];
    }
    
    if (!recorder.recording) {
        AVAudioSession *session = [AVAudioSession sharedInstance];
        [session setActive:YES error:nil];
        
        // Start recording
        [recorder record];
        [recordButton setImage:[UIImage imageNamed:@"ic_RecorderStopLight"] forState:UIControlStateNormal];
        [recordButton setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        
        [self.progressView setHidden:NO];
        self.progressView.roundedCorners = YES;
        self.progressView.trackTintColor = [UIColor clearColor];
        self.progressView.progressTintColor = [[CQAColors alloc ] lightgray];
        self.progressView.thicknessRatio = 0.1f;
        
        [self startAnimation];
        [self performSelector:@selector(finishRecordingAfterTwelveSeconds) withObject:nil afterDelay:delay];
    } else {
        
        // Pause recording
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        [audioSession setActive:NO error:nil];
        
        [self finishRecording];
        
        //[recordButton setImage:[UIImage imageNamed:@"ic_RecorderRec.png"] forState:UIControlStateNormal];
    }

}

- (void) audioRecorderDidFinishRecording:(AVAudioRecorder *)avrecorder successfully:(BOOL)flag{
    NSLog(@"I have finished recording");
}

- (void) audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: NSLocalizedString(@"Done", nil)
                                                    message: NSLocalizedString(@"Finished playing cuaQ!", nil)
                                                   delegate: nil
                                          cancelButtonTitle: NSLocalizedString(@"Ok", nil)
                                          otherButtonTitles:nil];
    [alert show];
}

/*- (void) configureAVAudioSession
{
    //get your app's audioSession singleton object
    AVAudioSession* session = [AVAudioSession sharedInstance];
    
    //error handling
    BOOL success;
    NSError* error;
    
    //set the audioSession category.
    //Needs to be Record or PlayAndRecord to use audioRouteOverride:
    success = [session setCategory:AVAudioSessionCategoryPlayAndRecord
                             error:&error];
    
    if (!success)  NSLog(@"AVAudioSession error setting category:%@",error);
    
    //set the audioSession override
    success = [session overrideOutputAudioPort:AVAudioSessionPortOverrideSpeaker
                                         error:&error];
    if (!success)  NSLog(@"AVAudioSession error overrideOutputAudioPort:%@",error);
    
    //activate the audio session
    success = [session setActive:YES error:&error];
    if (!success) NSLog(@"AVAudioSession error activating: %@",error);
    else NSLog(@"audioSession active");
}*/

- (void)progressChange
{
    CGFloat progress = self.progressView.progress + progressPixelInterval;
    [self.progressView setProgress:progress];

}

- (void)startAnimation
{
    _recorderTimer = [NSTimer scheduledTimerWithTimeInterval:progressTimerInterval
                                                  target:self
                                                selector:@selector(progressChange)
                                                userInfo:nil
                                                 repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:_recorderTimer forMode:NSRunLoopCommonModes];
}

- (void) finishRecording {
    
    [self setupFinishRecording];
    
    // Go to the next view
    [self goToPublish];
}

- (void) goToPublish{
    NSLog(@"Finished");
    
    int durationInt = cuaqDuration * progressTime * 10;
    //NSString *duration = [NSString stringWithFormat:@"%i",durationInt];
    
    NSMutableData *audioData = [NSMutableData dataWithContentsOfURL:file];
    // Quitamos el FLLR
    [audioData replaceBytesInRange:NSMakeRange(36, 4052) withBytes:NULL length:0];
    
    // Creamos .wav
    NSArray *pathComponents = [NSArray arrayWithObjects:
                               [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject], // NSUserDomainMask
                               @"WAVsinFLLR.wav",
                               nil];
    
    NSURL *outputFileURL = [NSURL fileURLWithPathComponents:pathComponents];
    
    [audioData writeToFile:[outputFileURL path] atomically:YES];
    
    NSString *base64String = [audioData base64EncodedStringWithOptions:0];
    
    NSDate *now = [[NSDate alloc] init];
    
    CQAUserModel *user = [CQAUserModel userWithId:@"anonymous"
                                         username:@"anonymous"
                                            email:@"anonymous@diary.cuaqea.com"
                                             type:@"user"];
    
    CQACuaqModel *newCuaq = [CQACuaqModel cuaqWithContentBase64:base64String
                                                       datetime:now
                                                       duration:durationInt
                                                           user:user
                                                         format:@"opus"
                                                       localURL:outputFileURL];
    
    CQAPublishCuaqViewController *publishVC = [[CQAPublishCuaqViewController alloc] initWithCuaq:newCuaq];
    [self.navigationController pushViewController:publishVC animated:YES];
}

- (void) setupFinishRecording {
    // Stop the timer
    [_recorderTimer invalidate];
    _recorderTimer = nil;
    
    cuaqDuration = self.progressView.progress;
    
    // Reset progressCircle
    [self.progressView setProgress:0.0f animated:YES];
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setActive:NO error:nil];
    
    [recorder stop];
    
    //[recordButton setImage:[UIImage imageNamed:@"ic_RecorderRec.png"] forState:UIControlStateNormal];
    
    alreadyFinished = YES;
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self]; // To cancel delay of 12 seconds
}

- (void) finishRecordingAfterTwelveSeconds {
    if (!alreadyFinished){
        [self setupFinishRecording];
        [self goToPublish];
    }
    
    alreadyFinished = NO;
}
@end
