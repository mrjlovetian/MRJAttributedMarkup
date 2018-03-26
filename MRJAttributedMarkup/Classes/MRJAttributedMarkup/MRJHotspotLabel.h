//
//  MRJAttributedMarkup
//
//  Created by mrjlovetian@gmail.com on 03/09/2018.
//  Copyright (c) 2018 mrjlovetian@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^OnTapBlock)(CGPoint);

@interface MRJHotspotLabel : UILabel

@property (nonatomic, readwrite, copy) OnTapBlock onTap;

@end
