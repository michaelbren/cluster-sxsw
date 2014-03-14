//
//  NNSoundEngine.h
//  Neon
//
//  Created by Brad Zeis on 3/13/14.
//
//

#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "Novocaine.h"

@interface NNSoundEngine : NSObject

@property Novocaine *audioManager;

- (instancetype)initWithMediaItem:(MPMediaItem *)item;

- (void)start;

- (void)enqueuePalette:(NSInteger)palette looping:(BOOL)looping;
- (void)processQueue;

@end
