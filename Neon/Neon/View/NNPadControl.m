//
//  NNPadControl.m
//  Neon
//
//  Created by Brad Zeis on 3/12/14.
//
//

#import "NNPadControl.h"
#import "NNUtility.h"

@implementation NNPadControl

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [NNPadControl randomColor];
    }
    return self;
}

#pragma mark Layout

+ (CGSize)padSizeForPadCount:(NSInteger)padCount
{
    return CGSizeMake(CGRectGetWidth([UIScreen mainScreen].applicationFrame) / kColumnCount,
                      CGRectGetHeight([UIScreen mainScreen].applicationFrame) / (padCount / kColumnCount));
}

+ (CGPoint)padCenterForPosition:(NSInteger)position padCount:(NSInteger)padCount
{
    CGSize size = [NNPadControl padSizeForPadCount:padCount];
    NSInteger i = position % kColumnCount;
    NSInteger j = position / kColumnCount;
    return CGPointMake(size.width * i,
                       size.height * j);
}

+ (float)randomFloatBetween:(float)smallNumber and:(float)bigNumber {
    float diff = bigNumber - smallNumber;
    return (((float) (arc4random() % ((unsigned)RAND_MAX + 1)) / RAND_MAX) * diff) + smallNumber;
}

+ (UIColor *)randomColor
{
    return [UIColor colorWithHue:randomFloat(0, 1) saturation:1 brightness:0.95 alpha:1];
}

@end
