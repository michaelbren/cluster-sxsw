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

@property CGFloat hue;

@end

@implementation NNPadControl

- (id)initWithFrame:(CGRect)frame
{
    CGFloat padding = 10;
    
    frame = CGRectInset(frame, padding, padding);
    self = [super initWithFrame:frame];
    
    if (self) {
    
        self.hue = randomFloat(0, 1);
        
        ((CAShapeLayer *)self.layer).path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:8].CGPath;
        ((CAShapeLayer *)self.layer).fillColor = [UIColor colorWithHue:self.hue saturation:1 brightness:0.95 alpha:1].CGColor;
        
        self.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(self.bounds, 4, 4) cornerRadius:16].CGPath;
        self.layer.shadowOpacity = .1;
        self.layer.shadowRadius = 16;
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
    return CGSizeMake(CGRectGetWidth([UIScreen mainScreen].applicationFrame) / kColumnCount - kPadPadding / 2,
                      CGRectGetHeight([UIScreen mainScreen].applicationFrame) / (padCount / kColumnCount) - kPadPadding / 2);
}

+ (CGPoint)padOriginForPosition:(NSInteger)position padCount:(NSInteger)padCount
{
    CGSize size = [NNPadControl padSizeForPadCount:padCount];
    NSInteger i = position % kColumnCount;
    NSInteger j = position / kColumnCount;
    return CGPointMake(size.width * i + kPadPadding,
                       size.height * j + kPadPadding);
}

#pragma mark Glow

- (void)setGlowLow
{
    self.layer.shadowOpacity = .1;
}

- (void)setGlowHigh
{
    self.layer.shadowOpacity = .24;
}

#pragma mark Touch Events

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    ((CAShapeLayer *)self.layer).fillColor = [UIColor colorWithHue:self.hue saturation:1 brightness:0.4 alpha:1].CGColor;
    [self setGlowHigh];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    ((CAShapeLayer *)self.layer).fillColor = [UIColor colorWithHue:self.hue saturation:1 brightness:0.95 alpha:1].CGColor;
    [self setGlowLow];
}

@end
