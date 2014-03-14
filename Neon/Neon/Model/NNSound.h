//
//  NNSound.h
//  Neon
//
//  Created by Brad Zeis on 3/13/14.
//
//

#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>

@interface NNSound : NSObject

@property AVAudioPlayer *audioPlayer;

- (instancetype)initWithURL:(NSURL *)url;
- (void)play;
- (void)pause;

- (void)setURL:(NSURL *)url;

@end
