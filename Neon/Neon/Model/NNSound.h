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
@property NSInteger tempo;
@property NSDictionary *slices;

- (instancetype)initWithMediaItem:(MPMediaItem *)item;

- (void)play;

@end
