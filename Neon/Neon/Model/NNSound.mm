//
//  NNSound.m
//  Neon
//
//  Created by Brad Zeis on 3/13/14.
//
//

#import "NNSound.h"
#import "NNUtility.h"

@implementation NNSound

- (instancetype)initWithMediaItem:(MPMediaItem *)item
{
    self = [super init];
    if (self) {
        
        self.audioManager = [Novocaine audioManager];
        [self.audioManager play];
        
        NSURL *url = [item valueForProperty:MPMediaItemPropertyAssetURL];
        self.audioReader = [[AudioFileReader alloc] initWithAudioFileURL:url
                                                             samplingRate:self.audioManager.samplingRate
                                                             numChannels:self.audioManager.numOutputChannels];
        [self.audioReader play];
    }
    return self;
}

- (void)play
{
    __block NNSound *wkSelf = self;
    [self.audioManager setOutputBlock:^(float *data, UInt32 numFrames, UInt32 numChannels) {
        [wkSelf.audioReader retrieveFreshAudio:data numFrames:numFrames numChannels:numChannels];
    }];
}

@end
