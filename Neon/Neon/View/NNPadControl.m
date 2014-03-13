//
//  NNPadControl.m
//  Neon
//
//  Created by Brad Zeis on 3/12/14.
//
//

#import "NNPadControl.h"
#import "NNUtility.h"

@interface NNPadControl ()

@end

@implementation NNPadControl

- (id)initWithFrame:(CGRect)frame
{
    CGFloat padding = 10;
    
    frame = CGRectInset(frame, padding, padding);
    self = [super initWithFrame:frame];
    
    if (self) {
    
        CGFloat hue = randomFloat(0, 1);
        
        ((CAShapeLayer *)self.layer).path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:8].CGPath;
        ((CAShapeLayer *)self.layer).fillColor = [UIColor colorWithHue:hue saturation:1 brightness:0.95 alpha:1].CGColor;
        
        self.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(self.bounds, -4, -4) cornerRadius:16].CGPath;
        self.layer.shadowOpacity = .2;
        self.layer.shadowColor = ((CAShapeLayer *)self.layer).fillColor;
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
