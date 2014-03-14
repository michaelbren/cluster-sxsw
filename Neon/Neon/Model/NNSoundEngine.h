//
//  NNSoundEngine.h
//  Neon
//
//  Created by Brad Zeis on 3/13/14.
//
//

#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>

@interface NNSoundEngine : NSObject

- (instancetype)initWithMediaItem:(MPMediaItem *)item;

- (void)start;

- (void)enqueuePalette:(NSInteger)palette looping:(BOOL)looping;
- (void)setURL:(NSURL *)url forPalette:(NSInteger)palette;
- (void)processQueue;

@end
