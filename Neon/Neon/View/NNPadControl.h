//
//  NNPadControl.h
//  Neon
//
//  Created by Brad Zeis on 3/12/14.
//
//

#import <UIKit/UIKit.h>

#define kPadCount 8
#define kColumnCount 2
#define kPadPadding 10
#define kCornerRadius 10
#define kTopPadding 10

typedef NS_ENUM(NSInteger, NNColor) {
    NNYellowColor,
    NNOrangeColor,
    NNRedColor,
    NNGreenColor,
    NNBlueColor,
    NNDarkBlueColor,
    NNPinkColor,
    NNPurpleColor,
    NNGrayColor,
};

@class NNPadControl;

@protocol NNPadControlDelegate <NSObject>

- (void)padControlWasHeld:(NNPadControl *)padControl;
- (void)padControlWasReleased:(NNPadControl *)padControl;

@end

@interface NNPadControl : UIControl

@property id<NNPadControlDelegate> delegate;
@property (nonatomic) BOOL isPlaying;

- (instancetype)initWithPosition:(NSInteger)position color:(NNColor)color;

+ (CGSize)padSize;
+ (CGPoint)padOriginForPosition:(NSInteger)position;

- (void)animateToRecording;
- (void)animateFromRecording;

@end
