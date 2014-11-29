//
//  CQARecordCuaqViewController.h
//  diary
//
//  Created by Enrique Ismael Mendoza Robaina on 6/11/14.
//  Copyright (c) 2014 cuaQea SL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreAudio/CoreAudioTypes.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioServices.h>
#import "CQAUserModel.h"
#import "DACircularProgressView.h"

@interface CQARecordCuaqViewController : UIViewController<AVAudioRecorderDelegate, AVAudioPlayerDelegate>

@property (strong, nonatomic) CQAUserModel *model;
@property (weak, nonatomic) IBOutlet UILabel *countdown;
@property (strong, nonatomic) NSTimer* countdownTimer;
@property (strong, nonatomic) NSTimer* recorderTimer;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIView *recorderView;
@property (strong, nonatomic) AVAudioRecorder *recorder;
@property (strong, nonatomic) AVAudioPlayer *player;
@property (weak, nonatomic) IBOutlet DACircularProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIButton *recordButton;

- (id)initWithUser:(CQAUserModel *)aUserInfo
             title:(NSString *)aTitle;
- (IBAction)cancel:(id)sender;
- (IBAction)record:(id)sender;

@end
