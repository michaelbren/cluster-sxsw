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
@property NSMutableDictionary *loops;

@property NSMutableArray *queue, *loopingQueue;
@property NSMutableSet *playing, *looping;

@end

@implementation NNSoundEngine

- (instancetype)initWithMediaItem:(MPMediaItem *)item
{
    self = [super init];
    if (self) {
        
        self.tempo = 120;
        self.sperbeat = 1.0 / self.tempo * 60;
        
        self.loops = [[NSMutableDictionary alloc] init];
        self.playing = [[NSMutableSet alloc] init];
        self.looping = [[NSMutableSet alloc] init];
        
        // Load loops
        for (NSInteger i = 0; i < 8; i++) {
        }
        
        self.sound = [[NNSound alloc] initWithMediaItem:item];
    }
    return self;
}

- (void)start
{
    [self processQueue];
}

- (void)enqueuePalette:(NSInteger)palette looping:(BOOL)looping
{
    // TODO: If looping is YES, always enqueue
    // TODO: Else, stop the palette if it is currently playing/looping
    // TODO: Else, enqueue the palette
}

- (void)processQueue
{
    // TODO: First, loop any looping loops again
    // TODO: Then, play/loop new loops
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.sperbeat * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self processQueue];
    });
}

@end
