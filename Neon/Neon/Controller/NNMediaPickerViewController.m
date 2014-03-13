//
//  NNMediaPickerViewController.m
//  Neon
//
//  Created by Michael Brennan on 3/12/14.
//
//

#import "NNMediaPickerViewController.h"
#import "NNPadViewController.h"

@interface NNMediaPickerViewController ()

@end

@implementation NNMediaPickerViewController

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
    [self.navigationController setNavigationBarHidden:YES];
    [self.navigationController setToolbarHidden:YES];
    
    // Do any additional setup after loading the view.
    MPMediaPickerController *mediaPicker = [[MPMediaPickerController alloc] initWithMediaTypes:MPMediaTypeAnyAudio];
    mediaPicker.delegate = self;
    mediaPicker.prompt = NSLocalizedString (@"Add songs to play", "Prompt in media item picker");
    [self presentViewController:mediaPicker animated:YES completion:^{}];
}

- (void) mediaPicker: (MPMediaPickerController *) mediaPicker didPickMediaItems: (MPMediaItemCollection *) mediaItemCollection {
    [self.navigationController dismissViewControllerAnimated:YES completion:^{}];
    NNPadViewController *padViewController = [[NNPadViewController alloc] initWithSongChoice:mediaItemCollection.items[0]];
    [self.navigationController pushViewController:padViewController animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
