//
//  NNSoundEngine.h
//  Neon
//
//  Created by Brad Zeis on 3/13/14.
//
//

#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>

@class NNSound;

@interface NNSoundEngine : NSObject

@property NNSound *sound;

- (instancetype)initWithMediaItem:(MPMediaItem *)item;

- (void)start;

- (void)enqueuePalette:(NSInteger)palette looping:(BOOL)looping;
- (void)processQueue;

@end
