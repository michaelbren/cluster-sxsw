//
//  NNSoundEngine.m
//  Neon
//
//  Created by Brad Zeis on 3/13/14.
//
//

#import <AVFoundation/AVFoundation.h>
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
        
        self.queue = [[NSMutableArray alloc] init];
        self.loopingQueue = [[NSMutableArray alloc] init];
        
        self.playing = [[NSMutableDictionary alloc] init];
        self.looping = [[NSMutableDictionary alloc] init];
        
        self.tempo = 112;
        self.sperbeat = 1.0 / self.tempo * 60;
        
        self.loops = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < 8; i++) {
            NSURL *url = [[NSBundle mainBundle] URLForResource:[NSString stringWithFormat:@"%ld", (long)i] withExtension:@"wav"];
            
            NNSound *sound = [[NNSound alloc] initWithURL:url];
            [self.loops addObject:sound];
        }
    }
    return self;
}

- (void)start
{
    [self processQueue];
}

- (void)enqueuePalette:(NSInteger)palette looping:(BOOL)looping
{
    if (looping) {
        [self.loopingQueue addObject:@(palette)];
        [self.queue removeObject:@(palette)];
        
        NNSound *sound = self.loops[palette];
        [sound pause];
        [self.playing removeObjectForKey:@(palette)];
        
    } else {
        if (self.looping[@(palette)]) {
            // Remove looping loops
            NNSound *sound = self.loops[palette];
            [sound pause];
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
        } else {
            NNSound *sound = newPlaying[loopNumber];
            [sound pause];
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
