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
    
    for (NSInteger i = 0; i < kPadCount; i++) {
        NNPadControl *control = [[NNPadControl alloc] initWithPosition:i color:(NNColor)i];
        
        [self.view addSubview:control];
    }
}



- (void)padControlWasTapped:(NNPadControl *)padControl
{
    [self.soundEngine enqueuePalette:padControl.padPosition looping:NO];
}

- (void)padControlWasDoubleTapped:(NNPadControl *)padControl
{
//    [self.soundEngine enqueuePalette:padControl.padPosition looping:YES];
}

@end
