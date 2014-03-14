//
//  NNSound.m
//  Neon
//
//  Created by Brad Zeis on 3/13/14.
//
//

#import "NNSound.h"
#import "NNUtility.h"
#import "AudioFileReader.h"

@interface NNSound ()

@property CGFloat length;
@property NSInteger currentSegment;
@property NSInteger carryFrames;

@end

@implementation NNSound

- (instancetype)initWithURL:(NSURL *)url audioManager:(Novocaine *)audioManager
{
    self = [super init];
    if (self) {
        self.audioReader = [[AudioFileReader alloc] initWithAudioFileURL:url
                                                             samplingRate:audioManager.samplingRate
                                                             numChannels:audioManager.numOutputChannels];
    }
    return self;
}

- (void)play
{
    [self.audioReader play];
    self.audioReader.currentTime = 0;
}

- (void)getData:(float *)data numFrames:(UInt32)numberFrames numChannels:(UInt32)numChannels
{
    [self.audioReader retrieveFreshAudio:data numFrames:numberFrames numChannels:numChannels];
}

@end
