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
        
        self.backgroundColor = randomColor();
        
//        ((CAShapeLayer *)self.layer).path = [UIBezierPath bezierPathWithRect:frame].CGPath;
//        ((CAShapeLayer *)self.layer).strokeColor = [UIColor whiteColor].CGColor;
//        ((CAShapeLayer *)self.layer).lineWidth = 14;
    }
    return self;
}

+ (Class)layerClass
{
    return [CAShapeLayer class];
}

#pragma mark Layout

+ (CGSize)padSizeForPadCount:(NSInteger)padCount
{
    return CGSizeMake(CGRectGetWidth([UIScreen mainScreen].applicationFrame) / kColumnCount,
                      CGRectGetHeight([UIScreen mainScreen].applicationFrame) / (padCount / kColumnCount));
}

+ (CGPoint)padOriginForPosition:(NSInteger)position padCount:(NSInteger)padCount
{
    CGSize size = [NNPadControl padSizeForPadCount:padCount];
    NSInteger i = position % kColumnCount;
    NSInteger j = position / kColumnCount;
    return CGPointMake(size.width * i,
                       size.height * j);
}

@end
