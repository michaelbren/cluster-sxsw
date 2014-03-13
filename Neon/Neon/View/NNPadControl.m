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
        ((CAShapeLayer *)self.layer).fillColor = [UIColor colorWithRed:247/255.0 green:118/255.0 blue:252/255.0 alpha:1].CGColor;
        
        self.padTop = [[CAShapeLayer alloc] init];
        self.padTop.path = [UIBezierPath bezierPathWithRoundedRect:CGRectOffset(self.bounds, 0, -6) cornerRadius:cornderRadius].CGPath;
        self.padTop.fillColor = [UIColor colorWithRed:238/255.0 green:35/255.0 blue:235/255.0 alpha:1].CGColor;
        [self.layer addSublayer:self.padTop];
        
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
        tap.numberOfTapsRequired = 1;
        [self addGestureRecognizer:tap];

        UILongPressGestureRecognizer *doubleTap = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
        doubleTap.numberOfTapsRequired = 1;
        doubleTap.minimumPressDuration = 0;
        [self addGestureRecognizer:doubleTap];
        
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        longPress.minimumPressDuration = 0.25;
        [self addGestureRecognizer:longPress];
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

- (void)setIsTapped
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.fromValue = [NSValue valueWithCATransform3D:self.padTop.transform];
    self.padTop.transform = CATransform3DMakeTranslation(0, 3, 0);
    animation.toValue = [NSValue valueWithCATransform3D:self.padTop.transform];
    animation.duration = .00003;
    [self.padTop addAnimation:animation forKey:@"tapping"];
}

- (void)setIsUntapped
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.fromValue = [NSValue valueWithCATransform3D:self.padTop.transform];
    self.padTop.transform = CATransform3DIdentity;
    animation.toValue = [NSValue valueWithCATransform3D:self.padTop.transform];
    animation.duration = .05;
    [self.padTop addAnimation:animation forKey:@"untapping"];
}

#pragma mark Touch Events

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self setIsTapped];
}

- (void)singleTap:(UIGestureRecognizer *)gesture
{
    // TODO: make that shit play
    [self setIsUntapped];
}

- (void)doubleTap:(UILongPressGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateBegan) {
        // TODO: make that shit loop
        [self setIsTapped];
        
    } else if (gesture.state == UIGestureRecognizerStateEnded) {
        [self setIsUntapped];
    }
}

- (void)longPress:(UILongPressGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateBegan) {
        // TODO: recording zoom
        
    } else if (gesture.state == UIGestureRecognizerStateEnded) {
        [self setIsUntapped];
    }
}

@end
