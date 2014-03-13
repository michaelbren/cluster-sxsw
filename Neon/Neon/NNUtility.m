//
//  NNUtility.m
//  Neon
//
//  Created by Brad Zeis on 3/13/14.
//
//

#import "NNUtility.h"

float randomFloat(float min, float max) {
    float diff = max - min;
    return (((float) (arc4random() % ((unsigned)RAND_MAX + 1)) / RAND_MAX) * diff) + min;
}
