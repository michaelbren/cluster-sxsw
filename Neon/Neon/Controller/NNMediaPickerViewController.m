//
//  NNMediaPickerViewController.m
//  Neon
//
//  Created by Michael Brennan on 3/12/14.
//
//

#import "NNMediaPickerViewController.h"

@interface NNMediaPickerViewController ()

@end

@implementation NNMediaPickerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    MPMediaPickerController *mediaPicker = [[MPMediaPickerController alloc] initWithMediaTypes:MPMediaTypeAnyAudio];
    mediaPicker.delegate = self;
    mediaPicker.prompt = NSLocalizedString (@"Add songs to play", "Prompt in media item picker");
    [self presentViewController:mediaPicker animated:YES completion:^{}];
}

- (void) mediaPicker: (MPMediaPickerController *) mediaPicker didPickMediaItems: (MPMediaItemCollection *) mediaItemCollection {
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
