# MRJAttributedMarkup

[![CI Status](http://img.shields.io/travis/mrjlovetian@gmail.com/MRJAttributedMarkup.svg?style=flat)](https://travis-ci.org/mrjlovetian@gmail.com/MRJAttributedMarkup)
[![Version](https://img.shields.io/cocoapods/v/MRJAttributedMarkup.svg?style=flat)](http://cocoapods.org/pods/MRJAttributedMarkup)
[![License](https://img.shields.io/cocoapods/l/MRJAttributedMarkup.svg?style=flat)](http://cocoapods.org/pods/MRJAttributedMarkup)
[![Platform](https://img.shields.io/cocoapods/p/MRJAttributedMarkup.svg?style=flat)](http://cocoapods.org/pods/MRJAttributedMarkup)

## Example


```
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
```
## show

![](show.png)

## Installation

MRJAttributedMarkup is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'MRJAttributedMarkup'
```

## Author

mrjlovetian@gmail.com, mrjlovetian@gmail.com

## License

MRJAttributedMarkup is available under the MIT license. See the LICENSE file for more info.


