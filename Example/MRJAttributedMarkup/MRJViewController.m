//
//  MRJViewController.m
//  MRJAttributedMarkup
//
//  Created by mrjlovetian@gmail.com on 03/09/2018.
//  Copyright (c) 2018 mrjlovetian@gmail.com. All rights reserved.
//

#import "MRJViewController.h"
#import "MRJHotspotLabel.h"
#import "MRJAttributedStyleAction.h"
#import "NSString+MRJAttributedMarkup.h"
#import <CoreText/CoreText.h>

@interface MRJViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet MRJHotspotLabel *label2;

@end

@implementation MRJViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDictionary *style = @{@"body":[UIFont fontWithName:@"HelveticaNeue" size:18.0],
                             @"bold":[UIFont fontWithName:@"HelveticaNeue-Bold" size:18.0],
                             @"red": [UIColor redColor]};
    
    
    NSDictionary *style1 = @{@"body" :
                                 @[[UIFont fontWithName:@"HelveticaNeue-Bold" size:18.0],
                                   [UIColor darkGrayColor]],
                             @"u": @[[UIColor blueColor],
                                     @{NSUnderlineStyleAttributeName : @(kCTUnderlineStyleSingle|kCTUnderlinePatternSolid)}
                                     ],
                             @"thumb":[UIImage imageNamed:@"thumbIcon"]};
    
    NSDictionary *style2 = @{@"body":[UIFont fontWithName:@"HelveticaNeue" size:22.0],
                             @"help":[MRJAttributedStyleAction styledActionWithAction:^{
                                 NSLog(@"Help action");
                             }],
                             @"settings":[MRJAttributedStyleAction styledActionWithAction:^{
                                 NSLog(@"Settings action");
                             }],
                             @"link": [UIColor orangeColor]};
    
    
    self.label.attributedText = [@"属性 <bold>粗体</bold> <red>红色</red> 文本" attributedStringWithStyleBook:style];
    self.label1.attributedText = [@"<thumb> </thumb> 图标 <u>下划线</u> 文本 <thumb> </thumb>" attributedStringWithStyleBook:style1];
    self.label2.attributedText = [@"点击 <help>这里</help> 显示帮助或者 <settings>这里</settings> 显示设置" attributedStringWithStyleBook:style2];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
