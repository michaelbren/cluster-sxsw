//
//  NNSoundEngine.m
//  Neon
//
//  Created by Brad Zeis on 3/13/14.
//
//

#import "NNSoundEngine.h"
#import "Novocaine.h"

#import "NNSound.h"

@interface NNSoundEngine ()

@property Novocaine *soundManager;
@property NSMutableArray *queue;

@end

@implementation NNSoundEngine

- (instancetype)initWithMediaItem:(MPMediaItem *)item
{
    self = [super init];
    if (self) {
        self.sound = [[NNSound alloc] initWithMediaItem:item];
        //[self.sound play];
    }
    return self;
}

- (void)enqueuePalette:(NSInteger)palette looping:(BOOL)looping
{
    
}

- (void)processQueue
{
}

@end
