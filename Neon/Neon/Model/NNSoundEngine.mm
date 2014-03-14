//
//  NNSoundEngine.m
//  Neon
//
//  Created by Brad Zeis on 3/13/14.
//
//

#import "NNSoundEngine.h"
#import "NNSound.h"

@interface NNSoundEngine ()

@property CGFloat tempo;
@property CGFloat sperbeat;
@property NSMutableArray *loops;

@property NSInteger currentBeat;

@property NSMutableArray *queue, *loopingQueue;
@property NSMutableDictionary *playing, *looping;

@end

@implementation NNSoundEngine

- (instancetype)initWithMediaItem:(MPMediaItem *)item
{
    self = [super init];
    if (self) {
        
        self.audioManager = [Novocaine audioManager];
        
        self.queue = [[NSMutableArray alloc] init];
        self.loopingQueue = [[NSMutableArray alloc] init];
        
        self.playing = [[NSMutableDictionary alloc] init];
        self.looping = [[NSMutableDictionary alloc] init];
        
        self.tempo = 112;
        self.sperbeat = 1.0 / self.tempo * 60;
        
        self.loops = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < 8; i++) {
            NSURL *url = [[NSBundle mainBundle] URLForResource:[NSString stringWithFormat:@"%ld", (long)i] withExtension:@"wav"];
            
            NNSound *sound = [[NNSound alloc] initWithURL:url audioManager:self.audioManager];
            [self.loops addObject:sound];
        }
    }
    return self;
}

- (void)start
{
    [self processQueue];
    
    __block NNSoundEngine *wkSelf = self;
    [self.audioManager setOutputBlock:^(float *data, UInt32 numFrames, UInt32 numChannels) {
        NSMutableArray *sounds = [[wkSelf.playing allKeys] mutableCopy];
        [sounds addObjectsFromArray:[wkSelf.looping allKeys]];
        
        for (NSInteger i = 0; i < numFrames * numChannels; i++) {
            data[i] = 0;
        }
        
        for (NSNumber *loopNumber in sounds) {
            NNSound *sound = wkSelf.loops[[loopNumber integerValue]];
            
            float *soundData = (float *)malloc(sizeof(float) * numFrames * numChannels);
            [sound getData:soundData numFrames:numFrames numChannels:numChannels];
            
            for (NSInteger i = 0; i < numFrames * numChannels; i++) {
                data[i] = data[i] + soundData[i];
                NSLog(@"%f", data[i]);
            }
            
            free(soundData);
        }
    }];
    
    [self.audioManager play];
}

- (void)enqueuePalette:(NSInteger)palette looping:(BOOL)looping
{
    if (looping) {
        [self.loopingQueue addObject:@(palette)];
        [self.queue removeObject:@(palette)];
        
    } else {
        if (self.looping[@(palette)]) {
            // Remove looping loops
            NNSound *sound = self.loops[palette];
            sound.paused = YES;
            [self.looping removeObjectForKey:@(palette)];
            
        } else if (![self.queue containsObject:@(palette)]) {
            [self.queue addObject:@(palette)];
        }
    }
}

- (void)processQueue
{
    for (NSNumber *loopNumber in self.loopingQueue) {
        self.looping[loopNumber] = @(self.currentBeat);
    }
    
    // Play looping shit
    for (NSNumber *loopNumber in self.looping) {
        NNSound *sound = self.loops[[loopNumber intValue]];
        if ([self.looping[loopNumber] integerValue] == self.currentBeat) {
            [sound play];
        }
    }
    
    // Kill finished playing sounds
    NSMutableDictionary *newPlaying = [[NSMutableDictionary alloc] init];
    for (NSNumber *loopNumber in self.playing) {
        if ([self.playing[loopNumber] integerValue] != self.currentBeat) {
            newPlaying[loopNumber] = self.playing[loopNumber];
        }
    }
    self.playing = newPlaying;
    
    for (NSNumber *loopNumber in self.queue) {
        self.playing[loopNumber] = loopNumber;
        [(NNSound *)self.loops[[loopNumber integerValue]] play];
    }
    
    [self.queue removeAllObjects];
    [self.loopingQueue removeAllObjects];
    
    // .5 because 8th notes
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.sperbeat * .5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.currentBeat += 1;
        self.currentBeat %= 16; // 2 bars
        [self processQueue];
    });
}

@end
