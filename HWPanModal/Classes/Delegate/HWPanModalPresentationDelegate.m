//
//  HWPanModalPresentationDelegate.m
//  HWPanModal
//
//  Created by heath wang on 2019/4/29.
//

#import "HWPanModalPresentationDelegate.h"
#import "HWPanModalPresentationAnimator.h"
#import "HWPanModalPresentationController.h"
#import "HWPanModalInteractiveAnimator.h"

@interface HWPanModalPresentationDelegate ()

@property (nonatomic, strong) HWPanModalPresentationAnimator *presentationAnimator;
@property (nonatomic, strong) HWPanModalPresentationAnimator *dismissalAnimator;
@property (nonatomic, strong) HWPanModalInteractiveAnimator *interactiveDismissalAnimator;

@end

@implementation HWPanModalPresentationDelegate

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
	return self.presentationAnimator;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
	return self.dismissalAnimator;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator {
	if (self.interactive) {
		return self.interactiveDismissalAnimator;
	}

	return nil;
}

- (nullable UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(nullable UIViewController *)presenting sourceViewController:(UIViewController *)source {
	UIPresentationController *controller = [[HWPanModalPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
	controller.delegate = self;
	return controller;
}

#pragma mark - UIAdaptivePresentationControllerDelegate

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller traitCollection:(UITraitCollection *)traitCollection {
	return UIModalPresentationNone;
}

#pragma mark - Getter

- (HWPanModalPresentationAnimator *)presentationAnimator {
	if (!_presentationAnimator) {
		_presentationAnimator = [[HWPanModalPresentationAnimator alloc] initWithTransitionStyle:TransitionStylePresentation];
	}
	return _presentationAnimator;
}

- (HWPanModalPresentationAnimator *)dismissalAnimator {
	if (!_dismissalAnimator) {
		_dismissalAnimator = [[HWPanModalPresentationAnimator alloc] initWithTransitionStyle:TransitionStyleDismissal];
	}
	return _dismissalAnimator;
}

- (HWPanModalInteractiveAnimator *)interactiveDismissalAnimator {
	if (!_interactiveDismissalAnimator) {
		_interactiveDismissalAnimator = [[HWPanModalInteractiveAnimator alloc] init];
	}
	return _interactiveDismissalAnimator;
}


@end
