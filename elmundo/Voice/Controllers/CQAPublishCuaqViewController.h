//
//  CQAPublishCuaqViewController.h
//  diary
//
//  Created by Enrique Ismael Mendoza Robaina on 7/11/14.
//  Copyright (c) 2014 cuaQea SL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DACircularProgressView.h"
#import "CQACuaqModel.h"

@interface CQAPublishCuaqViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,AVAudioRecorderDelegate, AVAudioPlayerDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@property (strong, nonatomic) CQACuaqModel *model;
@property AVAudioPlayer *player;
@property AVAudioSession *session;
@property NSURL *audioURL;
@property NSString *audioURLString;
@property int durationEffect;
@property int duration;
@property BOOL playing;
@property NSURL *audioOriginal;
@property NSURL *audioEffect;
@property NSString *effectType;
@property double progressPixelInterval;
@property double progressTimerInterval;
@property (weak, nonatomic) NSTimer *playerTimer;
@property (weak, nonatomic) IBOutlet UIView *playButtonView;
@property (weak, nonatomic) IBOutlet UISwitch *switchTwitter;
@property (weak, nonatomic) IBOutlet UISwitch *switchFacebook;
@property (weak, nonatomic) IBOutlet UIView *loadingView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (weak, nonatomic) IBOutlet UIButton *play;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *publish;
@property (weak, nonatomic) IBOutlet DACircularProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIImageView *border;
@property (weak, nonatomic) IBOutlet UITableView *publishTableView;
@property (weak, nonatomic) IBOutlet UITableView *effectsTableView;

// Designado
- (id)initWithCuaq:(CQACuaqModel *)aCuaq;

- (IBAction)playAction:(id)sender;

@end
