//
//  NNPadViewController.h
//  Neon
//
//  Created by Michael Brennan on 3/12/14.
//
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "NNMediaPickerViewController.h"
#import "NNPadControl.h"
//import AVAudioRecorder shit

@interface NNPadViewController : UIViewController <NNPadControlDelegate, AVAudioRecorderDelegate, AVAudioPlayerDelegate>

- (id)initWithSongChoice:(MPMediaItem *)item;

@end
