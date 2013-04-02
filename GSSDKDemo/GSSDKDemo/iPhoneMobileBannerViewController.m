//
//  iPhoneMobileBannerViewController.m
//  GSSDKDemo
//
//  Created by Jeffrey Carlson on 9/16/12.
//  Copyright (c) 2012 Greystripe. All rights reserved.
//

#import "iPhoneMobileBannerViewController.h"

#import "GSMobileBannerAdView.h"
#import "GSSDKInfo.h"

@interface iPhoneMobileBannerViewController ()

@end

@implementation iPhoneMobileBannerViewController

@synthesize statusLabel, bannerButton, myBannerAd;

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
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

//Button methods

- (IBAction)bannerButtonPressed: (id) sender {
    self.statusLabel.text = @"Fetching an ad...";
    [bannerButton setEnabled:NO];

    //Fetch Banner Ad
    [myBannerAd fetch];
}

//Protocol methods
- (UIViewController *)greystripeBannerDisplayViewController
{
    return self;
}

- (NSString *)greystripeGUID {
    NSLog(@"Accessing GUID");
    
    // The Greystripe GUID is defined in Constants.h and preloaded in GSSDKDemo-Prefix.pch in this example
    // Alternate example: You can also set the Greystripe GUID in the AppDelegate.m as well
    return GSGUID;
}

- (BOOL)greystripeBannerAutoload {
    return TRUE;
}

- (BOOL)greystripeShouldLogAdID {
    return TRUE;
}

- (void)textViewDidChangeSelection:(UITextView *)textView {
    [textView resignFirstResponder];
}
- (void)greystripeAdFetchSucceeded:(id<GSAd>)a_ad {
    if (a_ad == myBannerAd) {
        self.statusLabel.text = @"Small banner successfully fetched.";
        [bannerButton setEnabled:YES];
    }
}

- (void)greystripeAdFetchFailed:(id<GSAd>)a_ad withError:(GSAdError)a_error {
    NSString *errorString =  @"";
    
    switch(a_error) {
        case kGSNoNetwork:
            errorString = @"Error: No network connection available.";
            break;
        case kGSNoAd:
            errorString = @"Error: No ad available from server.";
            break;
        case kGSTimeout:
            errorString = @"Error: Fetch request timed out.";
            break;
        case kGSServerError:
            errorString = @"Error: Greystripe returned a server error.";
            break;
        case kGSInvalidApplicationIdentifier:
            errorString = @"Error: Invalid or missing application identifier.";
            break;
        case kGSAdExpired:
            errorString = @"Error: Previously fetched ad expired.";
            break;
        case kGSFetchLimitExceeded:
            errorString = @"Error: Too many requests too quickly.";
            break;
        case kGSUnknown:
            errorString = @"Error: An unknown error has occurred.";
            break;
        default:
            errorString = @"An invalid error code was returned. Thats really bad!";
    }
    self.statusLabel.text = [NSString stringWithFormat:@"Greystripe failed with error: %@",errorString];
    [bannerButton setEnabled:YES];
}

- (void)greystripeAdClickedThrough:(id<GSAd>)a_ad {
    self.statusLabel.text = @"Greystripe ad was clicked.";
}
- (void)greystripeBannerAdWillExpand:(id<GSAd>)a_ad {
    self.statusLabel.text = @"Greystripe ad expanded.";
}
- (void)greystripeBannerAdDidCollapse:(id<GSAd>)a_ad {
    self.statusLabel.text = @"Greystripe ad collapsed.";
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end