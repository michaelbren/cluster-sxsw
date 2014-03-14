//
//  NNSound.h
//  Neon
//
//  Created by Brad Zeis on 3/13/14.
//
//

#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>

#import "Novocaine.h"
#import "AudioFileReader.h"

@interface NNSound : NSObject

@property Novocaine *audioManager;
@property AudioFileReader *audioReader;
@property BOOL paused;

- (instancetype)initWithURL:(NSURL *)url audioManager:(Novocaine *)audioManager;
- (void)play;

- (void)getData:(float *)data numFrames:(UInt32)numberFrames numChannels:(UInt32)numChannels;

@end
