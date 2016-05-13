//
//  ViewController.m
//  Adjustabletextview
//
//  Created by Anton Chikin on 5/12/16.
//  Copyright © 2016 chikin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic, weak) IBOutlet UITextView *textView;
@property(nonatomic, weak) IBOutlet NSLayoutConstraint *textViewHeightConstraint;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTextView];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void) setupTextView {
    self.textView.scrollsToTop = NO;
    self.textView.backgroundColor = [UIColor redColor];
    self.textView.scrollEnabled = YES;
    [self.textView addObserver:self
                    forKeyPath:NSStringFromSelector(@selector(contentSize))
                       options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew
                       context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
    if (object == self.textView
        && [keyPath isEqualToString:NSStringFromSelector(@selector(contentSize))]) {
        
        CGSize oldContentSize = [[change objectForKey:NSKeyValueChangeOldKey] CGSizeValue];
        CGSize newContentSize = [[change objectForKey:NSKeyValueChangeNewKey] CGSizeValue];
        
        CGFloat dy = newContentSize.height - oldContentSize.height;
        self.textViewHeightConstraint.constant = self.textViewHeightConstraint.constant + dy;
        [self.view layoutIfNeeded];
        CGPoint contentOffsetToShowLastLine = CGPointMake(0.0f, self.textView.contentSize.height - CGRectGetHeight(self.textView.bounds));
        self.textView.contentOffset = contentOffsetToShowLastLine;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
