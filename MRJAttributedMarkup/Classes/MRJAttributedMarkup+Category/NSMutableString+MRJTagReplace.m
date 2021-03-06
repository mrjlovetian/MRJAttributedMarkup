//
//  MRJAttributedMarkup
//
//  Created by mrjlovetian@gmail.com on 03/09/2018.
//  Copyright (c) 2018 mrjlovetian@gmail.com. All rights reserved.
//

#import "NSMutableString+MRJTagReplace.h"

@implementation NSMutableString (MRJTagReplace)

- (BOOL)replaceFirstTagItoArray:(NSMutableArray *)array {
    NSRange openTagRange = [self rangeOfString:@"<"];
    if (openTagRange.length == 0) {
        return NO;
    }
    NSRange closeTagRange = [self rangeOfString:@">" options:NSCaseInsensitiveSearch range:NSMakeRange(openTagRange.location + openTagRange.length, self.length - (openTagRange.location + openTagRange.length))];
    if (closeTagRange.length == 0) {
        return NO;
    }
    
    NSRange range = NSMakeRange(openTagRange.location, closeTagRange.location - openTagRange.location + 1);
    NSString *tag = [self substringWithRange:range];
    [self replaceCharactersInRange:range withString:@""];
    
    BOOL isEndTag = [tag rangeOfString:@"</"].length == 2;
    
    if (isEndTag) {
        // 找到匹配的开放标签
        NSString *openTag = [tag stringByReplacingOccurrencesOfString:@"</" withString:@"<"];
        NSInteger count = array.count;
        for (NSInteger i = count - 1; i >= 0; i--) {
            NSDictionary *dict = array[i];
            NSString *dtag = dict[@"tag"];
            if ([dtag isEqualToString:openTag]) {
                NSNumber *loc = dict[@"loc"];
                if ([loc integerValue] < range.location) {
                    [array removeObjectAtIndex:i];
                    NSString *strippedTag = [openTag substringWithRange:NSMakeRange(1, openTag.length - 2)];
                    [array addObject:@{@"loc":loc, @"tag":strippedTag, @"endloc":@(range.location)}];
                }
                break;
            }
        }
    } else {
        [array addObject:@{@"loc":@(range.location), @"tag":tag}];
    }
    return YES;
}

- (void)replaceAllTagsIntoArray:(NSMutableArray *)array {
    while ([self replaceFirstTagItoArray:array]) {};
}

@end
