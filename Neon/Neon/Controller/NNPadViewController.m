//
//  NNPadViewController.m
//  Neon
//
//  Created by Michael Brennan on 3/12/14.
//
//

#import "NNPadViewController.h"

#import "NNPadControl.h"

@interface NNPadViewController ()

@end

@implementation NNPadViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSInteger padCount = 12;
    
    for (NSInteger i = 0; i < 12; i++) {
        NNPadControl *control = [[NNPadControl alloc] initWithFrame:({
            CGRect frame = CGRectZero;
            frame.origin = [NNPadControl padOriginForPosition:i padCount:padCount];
            frame.size = [NNPadControl padSizeForPadCount:padCount];
            frame;
        })];
        
        [self.view addSubview:control];
    }
}

@end
