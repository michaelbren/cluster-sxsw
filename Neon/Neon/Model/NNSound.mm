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

- (instancetype)initWithURL:(NSURL *)url
{
    self = [super init];
    if (self) {
        
        self.audioManager = [Novocaine audioManager];
        [self.audioManager play];
        
        self.audioReader = [[AudioFileReader alloc] initWithAudioFileURL:url
                                                             samplingRate:self.audioManager.samplingRate
                                                             numChannels:self.audioManager.numOutputChannels];
    }
    return self;
}

- (void)play
{
    [self.audioReader play];
    self.audioReader.currentTime = 0;
    
    __block NNSound *wkSelf = self;
    [self.audioManager setOutputBlock:^(float *data, UInt32 numFrames, UInt32 numChannels) {
        [wkSelf.audioReader retrieveFreshAudio:data numFrames:numFrames numChannels:numChannels];
    }];
}

- (void)loadSegments:(NSArray *)segments
{
    self.segments = [[NSMutableArray alloc] init];
    
    for (NSDictionary *segment in segments) {
        [(NSMutableArray *)self.segments addObject:@{@"start" : @([segment[@"start"] floatValue]),
                                                     @"duration" : @((NSInteger)([segment[@"duration"] floatValue] * self.audioManager.samplingRate))}];
        NSLog(@"%@ %@", segment[@"duration"], self.segments.lastObject[@"duration"]);
    }
}

@end
