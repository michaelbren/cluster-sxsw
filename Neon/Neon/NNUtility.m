//
//  NNUtility.m
//  Neon
//
//  Created by Brad Zeis on 3/13/14.
//
//

#import "NNUtility.h"
#import <AVFoundation/AVFoundation.h>
#import <CoreMedia/CoreMedia.h>

float randomFloat(float min, float max) {
    float diff = max - min;
    return (((float) (arc4random() % ((unsigned)RAND_MAX + 1)) / RAND_MAX) * diff) + min;
}

UIColor *randomColor() {
    return [UIColor colorWithHue:randomFloat(0, 1) saturation:1 brightness:1 alpha:1];
}
