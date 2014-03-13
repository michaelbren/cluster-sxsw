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

- (id)initWithSongChoice:(MPMediaItemCollection *) mediaItemCollection
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    [self.navigationController setToolbarHidden:YES];
    
    NNMediaPickerViewController *michaelsFuckingTired = [[NNMediaPickerViewController alloc] init];
    [self presentViewController:michaelsFuckingTired animated:YES completion:^{}];
    
    self.view.backgroundColor = [UIColor colorWithRed:.88 green:.88 blue:.88 alpha:1];
    
    for (NSInteger i = 0; i < kPadCount; i++) {
        NNPadControl *control = [[NNPadControl alloc] initWithPosition:i color:NNPinkColor];
        
        if (i % 3 == 0) {
            control.isPlaying = NO;
        }
        
        [self.view addSubview:control];
    }
}

@end
