//
//  LoadingViewController.m
//  KeynoteBingo
//
//  Created by Nicklas Ansman on 01-7-2009.
//  Copyright 2009 Nicklas Ansman. All rights reserved.
//

#import "LoadingViewController.h"

@interface LoadingViewController (PrivateMethods)

- (void) addCancelButton;

@end


@implementation LoadingViewController

@synthesize delegate;

- (void) setLoadingText:(NSString *)loadingText {
	[progressLabel setText:loadingText];
}


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
	
	UIImageView *backgroundImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)] autorelease];
	backgroundImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Default" ofType:@"png"]];
	backgroundImageView.userInteractionEnabled = NO;
	
	[self.view addSubview:backgroundImageView];
	
	UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	indicator.frame = CGRectMake(140, 289, 40, 40);
	
	[self.view addSubview:indicator];
	[indicator startAnimating];
	
	[indicator release];
	
	[progressLabel release];
	progressLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 349, 320, 30)];
	progressLabel.textAlignment = UITextAlignmentCenter;
	progressLabel.font = [UIFont boldSystemFontOfSize:20];
	progressLabel.textColor = [UIColor whiteColor];
	progressLabel.backgroundColor = [UIColor clearColor];
	[self.view addSubview:progressLabel];
	
	[cancelButton release];
	cancelButton = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
	cancelButton.frame = CGRectMake(95, 399, 120, 37);
	[cancelButton addTarget:delegate action:@selector(cancelUpdate) forControlEvents:UIControlEventTouchUpInside];
	[cancelButton setTitle:@"Cancel Update" forState:UIControlStateNormal];
}

- (void)updateStarted {
	[self performSelector:@selector(addButton) withObject:nil afterDelay:3]; 
}

- (void)addButton {
	cancelButton.alpha = 0;
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	[UIView setAnimationDuration:0.50];
	[self.view addSubview:cancelButton];
	cancelButton.alpha = 1;
	[UIView commitAnimations];
}

- (void)viewDidDisappear:(BOOL)animated {
	[cancelButton removeFromSuperview];
}

- (void)dealloc {
	[progressLabel release];
	[cancelButton release];
    [super dealloc];
}


@end
