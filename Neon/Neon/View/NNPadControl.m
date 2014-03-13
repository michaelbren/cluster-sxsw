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
@property CAShapeLayer *padTop;

@end

@implementation NNPadControl

- (id)initWithFrame:(CGRect)frame
{
    CGFloat padding = 10;
    CGFloat cornderRadius = 10;
    
    frame = CGRectInset(frame, padding, padding);
    self = [super initWithFrame:frame];
    
    if (self) {
    
        self.hue = randomFloat(0, 1);
        
        ((CAShapeLayer *)self.layer).path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:cornderRadius].CGPath;
        ((CAShapeLayer *)self.layer).fillColor = [UIColor colorWithHue:self.hue saturation:0.6 brightness:0.75 alpha:1].CGColor;
        
        self.padTop = [[CAShapeLayer alloc] init];
        self.padTop.path = [UIBezierPath bezierPathWithRoundedRect:CGRectOffset(self.bounds, 0, -6) cornerRadius:cornderRadius].CGPath;
        self.padTop.fillColor = [UIColor colorWithHue:self.hue saturation:1 brightness:1 alpha:1].CGColor;
        [self.layer addSublayer:self.padTop];
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

- (void)setIsTapped
{
    self.padTop.transform = CATransform3DMakeTranslation(0, 3, 0);
}

- (void)setIsUntapped
{
    self.padTop.transform = CATransform3DIdentity;
}

#pragma mark Touch Events

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self setIsTapped];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self setIsUntapped];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self setIsUntapped];
}

@end
