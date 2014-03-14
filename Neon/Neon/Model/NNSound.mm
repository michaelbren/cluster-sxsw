//
//  NNSound.m
//  Neon
//
//  Created by Brad Zeis on 3/13/14.
//
//

#import "NNSound.h"
#import "NNUtility.h"

@interface NNSound ()

@end

@implementation NNSound

- (instancetype)initWithURL:(NSURL *)url
{
    self = [super init];
    if (self) {
        NSError *error;
        self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    }
    return self;
}

- (void)play
{
    self.audioPlayer.currentTime = 0;
    [self.audioPlayer prepareToPlay];
    [self.audioPlayer play];
}

- (void)pause
{
    [self.audioPlayer pause];
}

- (void)setURL:(NSURL *)url
{
    [self pause];
    NSError *error;
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
}

@end
