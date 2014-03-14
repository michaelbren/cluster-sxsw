
//
//  NNPadViewController.m
//  Neon
//
//  Created by Michael Brennan on 3/12/14.
//
//

#import "NNPadViewController.h"

#import "NNSoundEngine.h"
#import "NNSound.h"

#import "NNPadControl.h"

@interface NNPadViewController ()

@property NNSoundEngine *soundEngine;
@property AVAudioRecorder *recorder;

@end

@implementation NNPadViewController

- (id)initWithSongChoice:(MPMediaItem *)mediaItem
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.soundEngine = [[NNSoundEngine alloc] initWithMediaItem:mediaItem];
        [self.soundEngine start];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    [self.navigationController setToolbarHidden:YES];
    
    self.view.backgroundColor = [UIColor colorWithRed:.88 green:.88 blue:.88 alpha:1];
    
    // Instantiate Pads
    for (NSInteger i = 0; i < kPadCount; i++) {
        NNPadControl *control = [[NNPadControl alloc] initWithPosition:i color:(NNColor)i];
        control.delegate = self;
        [self.view addSubview:control];
    }
}



- (void)padControlWasTapped:(NNPadControl *)padControl
{
    [self.soundEngine enqueuePalette:padControl.padPosition looping:NO];
}

- (void)padControlWasDoubleTapped:(NNPadControl *)padControl
{
    [self.soundEngine enqueuePalette:padControl.padPosition looping:YES];
}

- (void)padControlWasHeld:(NNPadControl *)padControl
{
    NSLog(@"held");
    NSArray *pathComponents = [NSArray arrayWithObjects:
                               [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject],
                               @"MyAudioMemo.m4a",
                               nil];
    NSURL *outputFileURL = [NSURL fileURLWithPathComponents:pathComponents];
    
    // Setup audio session
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryRecord error:nil];
    
    // Define the recorder setting
    NSMutableDictionary *recordSetting = [[NSMutableDictionary alloc] init];
    
    [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
    [recordSetting setValue:[NSNumber numberWithFloat:44100.0] forKey:AVSampleRateKey];
    [recordSetting setValue:[NSNumber numberWithInt: 2] forKey:AVNumberOfChannelsKey];
    
    // Initiate and prepare the recorder
    self.recorder = [[AVAudioRecorder alloc] initWithURL:outputFileURL settings:recordSetting error:NULL];
    self.recorder.delegate = self;
    self.recorder.meteringEnabled = YES;
    [self.recorder prepareToRecord];
   
    if(!self.recorder.recording)
    {
        [self.recorder record];
    }
}

- (void)padControlWasReleased:(NNPadControl *)padControl
{
    NSLog(@"released");
    if (self.recorder.recording)
    {
        // Stop recording
        [self.recorder stop];
        
        [self.soundEngine setURL:self.recorder.url forPalette:padControl.padPosition];
        
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        [audioSession setActive:NO error:nil];
    }
}

@end
