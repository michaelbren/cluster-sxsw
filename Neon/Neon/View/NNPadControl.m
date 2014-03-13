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
        self.padPosition = position;
        
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
        tap.numberOfTapsRequired = 1;
        [self addGestureRecognizer:tap];

        UILongPressGestureRecognizer *doubleTap = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
        doubleTap.numberOfTapsRequired = 1;
        doubleTap.minimumPressDuration = 0;
        [self addGestureRecognizer:doubleTap];
        
        //Maybe later
        /*UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        longPress.minimumPressDuration = 0.25;
        [self addGestureRecognizer:longPress];*/
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
//YELLOW: f1f828
//YELLOW1: f9fe75
//ORANGE: ff9600
//ORANGE1: feab52
//RED: eb2662
//RED1: ff598c
//GREEN: 3deb26
//GREEN1: 91ff4e
//PINK: eb26c6
//PINK1: f995e6
//GREY: c2bfc0
//GREY1: cfcfcf
//BLUE: 26a3eb
//BLUE1: 5dc3fd
//PURPLE: a326eb
//PURPLE1: c461fe
    
    NSArray *colors;
    
    switch (color) {
        case NNYellowColor:
            colors = @[[UIColor colorWithRed:241/255.0 green:248/255.0 blue:40/255.0 alpha:1],
                       [UIColor colorWithRed:249/255.0 green:254/255.0 blue:117/255.0 alpha:1]];
            break;
        case NNOrangeColor:
            colors = @[[UIColor colorWithRed:255/255.0 green:150/255.0 blue:0/255.0 alpha:1],
                       [UIColor colorWithRed:254/255.0 green:171/255.0 blue:82/255.0 alpha:1]];
            break;
        case NNRedColor:
            colors = @[[UIColor colorWithRed:235/255.0 green:28/255.0 blue:98/255.0 alpha:1],
                       [UIColor colorWithRed:255/255.0 green:89/255.0 blue:140/255.0 alpha:1]];
            break;
        case NNGreenColor:
            colors = @[[UIColor colorWithRed:61/255.0 green:235/255.0 blue:38/255.0 alpha:1],
                       [UIColor colorWithRed:145/255.0 green:255/255.0 blue:78/255.0 alpha:1]];
            break;
        case NNPinkColor:
            colors = @[[UIColor colorWithRed:238/255.0 green:35/255.0 blue:198/255.0 alpha:1],
                       [UIColor colorWithRed:249/255.0 green:149/255.0 blue:230/255.0 alpha:1]];
            break;
        case NNBlueColor:
            colors = @[[UIColor colorWithRed:38/255.0 green:163/255.0 blue:235/255.0 alpha:1],
                       [UIColor colorWithRed:93/255.0 green:193/255.0 blue:253/255.0 alpha:1]];
            break;
        case NNDarkBlueColor:
            colors = @[[UIColor colorWithRed:38/255.0 green:80/255.0 blue:235/255.0 alpha:1],
                       [UIColor colorWithRed:65/255.0 green:105/255.0 blue:254/255.0 alpha:1]];
            break;
        case NNPurpleColor:
            colors = @[[UIColor colorWithRed:163/255.0 green:38/255.0 blue:235/255.0 alpha:1],
                       [UIColor colorWithRed:196/255.0 green:97/255.0 blue:254/255.0 alpha:1]];
            break;
        default:
            colors = @[[UIColor colorWithRed:194/255.0 green:191/255.0 blue:192/255.0 alpha:1],
                       [UIColor colorWithRed:203/255.0 green:201/255.0 blue:202/255.0 alpha:1]];
            break;
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
    [self.delegate padControlWasTapped:self];
}

- (void)doubleTap:(UILongPressGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateBegan) {
        // TODO: make that shit loop
        [self setIsTapped];
        [self.delegate padControlWasDoubleTapped:self];
        
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
