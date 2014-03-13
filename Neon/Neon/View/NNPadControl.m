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

@property NNColor color;
@property CAShapeLayer *padTop;

@end

@implementation NNPadControl

- (id)initWithPosition:(NSInteger)position color:(NNColor)color
{
    CGRect frame = ({
        CGRect frame = CGRectZero;
        frame.origin = [NNPadControl padOriginForPosition:position];
        frame.size = [NNPadControl padSize];
        frame;
    });
    frame = CGRectInset(frame, kPadPadding, kPadPadding);
    self = [super initWithFrame:frame];
    
    if (self) {
        ((CAShapeLayer *)self.layer).path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:kCornerRadius].CGPath;
        
        self.padTop = [[CAShapeLayer alloc] init];
        self.padTop.path = [UIBezierPath bezierPathWithRoundedRect:CGRectOffset(self.bounds, 0, -6) cornerRadius:kCornerRadius].CGPath;
        [self.layer addSublayer:self.padTop];
        
        [self setPadColor:color];
        
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
        tap.numberOfTapsRequired = 1;
        [self addGestureRecognizer:tap];

        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
        doubleTap.numberOfTapsRequired = 2;
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

+ (CGSize)padSize
{
    return CGSizeMake((CGRectGetWidth([UIScreen mainScreen].applicationFrame) - kPadPadding * 2) / kColumnCount,
                      (CGRectGetHeight([UIScreen mainScreen].applicationFrame) - kPadPadding - kTopPadding) / (kPadCount / kColumnCount));
}

+ (CGPoint)padOriginForPosition:(NSInteger)position
{
    CGSize size = [NNPadControl padSize];
    NSInteger i = position % kColumnCount;
    NSInteger j = position / kColumnCount;
    return CGPointMake(size.width * i + kPadPadding,
                       size.height * j + kTopPadding);
}

#pragma mark Appearence

- (void)setPadColor:(NNColor)color
{
    NSArray *colors;
    if (color == NNGrayColor) {
        colors = @[[UIColor colorWithRed:194/255.0 green:191/255.0 blue:192/255.0 alpha:1],
                   [UIColor colorWithRed:203/255.0 green:201/255.0 blue:202/255.0 alpha:1]];
    } else {
        colors = @[[UIColor colorWithRed:238/255.0 green:35/255.0 blue:355/255.0 alpha:1],
                   [UIColor colorWithRed:247/255.0 green:118/255.0 blue:252/255.0 alpha:1]];
    }
    
    self.padTop.fillColor = ((UIColor *)colors[0]).CGColor;
    ((CAShapeLayer *)self.layer).fillColor = ((UIColor *)colors[1]).CGColor;
}

- (void)setIsPlaying:(BOOL)isPlaying
{
    _isPlaying = isPlaying;
    if (!_isPlaying) {
        [self setPadColor:NNGrayColor];
    } else {
        [self setPadColor:self.color];
    }
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

- (void)animateToRecording
{
    [self.superview bringSubviewToFront:self];
    
    CGRect frame = CGRectOffset([UIScreen mainScreen].applicationFrame, -self.frame.origin.x, -self.frame.origin.y - 3);
    UIBezierPath *newPath = [UIBezierPath bezierPathWithRoundedRect:frame cornerRadius:0.1];
    
    CABasicAnimation *connectorAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    connectorAnimation.duration = 0.24;
    connectorAnimation.fromValue = (__bridge id)self.padTop.path;
    self.padTop.path = newPath.CGPath;
    connectorAnimation.toValue = (__bridge id)self.padTop.path;
    [self.padTop addAnimation:connectorAnimation forKey:@"animatePath"];
}

- (void)animateFromRecording
{
    self.padTop.path = [UIBezierPath bezierPathWithRoundedRect:CGRectOffset(self.bounds, 0, -6) cornerRadius:10].CGPath;
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

- (void)doubleTap:(UITapGestureRecognizer *)gesture
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
        [self animateToRecording];
        [self.delegate padControlWasHeld:self];
        
    } else if (gesture.state == UIGestureRecognizerStateEnded) {
        [self setIsUntapped];
        [self animateFromRecording];
        [self.delegate padControlWasReleased:self];
    }
}

@end
