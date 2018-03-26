//
//  MRJAttributedMarkup
//
//  Created by mrjlovetian@gmail.com on 03/09/2018.
//  Copyright (c) 2018 mrjlovetian@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ActionBlock)(void);

@interface MRJAttributedStyleAction : NSObject

@property (readwrite, copy) ActionBlock action;

- (instancetype)initWithAction:(ActionBlock)action;
+ (NSArray *)styledActionWithAction:(ActionBlock)action;
- (NSArray *)styledAction;

@end
