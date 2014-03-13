//
//  NNPadViewController.h
//  Neon
//
//  Created by Michael Brennan on 3/12/14.
//
//

#import <UIKit/UIKit.h>
#import "NNMediaPickerViewController.h"
#import "NNPadControl.h"

@interface NNPadViewController : UIViewController <NNPadControlDelegate>

- (id)initWithSongChoice:(MPMediaItem *)item;

@end
