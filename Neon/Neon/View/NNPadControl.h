//
//  NNPadControl.h
//  Neon
//
//  Created by Brad Zeis on 3/12/14.
//
//

#import <UIKit/UIKit.h>

#define kColumnCount 3
#define kPadPadding 10

@interface NNPadControl : UIControl

+ (CGSize)padSizeForPadCount:(NSInteger)padCount;
+ (CGPoint)padOriginForPosition:(NSInteger)position padCount:(NSInteger)padCount;

@end
