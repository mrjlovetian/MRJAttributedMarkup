//
//  MRJAttributedMarkup
//
//  Created by mrjlovetian@gmail.com on 03/09/2018.
//  Copyright (c) 2018 mrjlovetian@gmail.com. All rights reserved.
//

#import "MRJHotspotLabel.h"
#import "MRJAttributedStyleAction.h"
#import <CoreText/CoreText.h>

@implementation MRJHotspotLabel

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self addHotspotHandler];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addHotspotHandler];
    }
    return self;
}

- (void)addHotspotHandler {
    __weak MRJHotspotLabel *weakSelf = self;
    [self setOnTap:^(CGPoint pt) {
        // 找到触摸位置的文本属性
        NSDictionary* attributes = [weakSelf textAttributesAtPoint:pt];
        // 如果所触及的属性包含我们的自定义操作风格，请执行操作块
        MRJAttributedStyleAction* actionStyle = attributes[@"MRJAttributedStyleAction"];
        if (actionStyle) {
            actionStyle.action();
        }
    }];
}

- (NSDictionary *)textAttributesAtPoint:(CGPoint)pt {
    // 在指定点处找到标签内文本的属性
    NSDictionary* dictionary = nil;
    
    // 首先，创建一个coretext framesetter
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)self.attributedText);
    
    CGMutablePathRef framePath = CGPathCreateMutable();
    CGPathAddRect(framePath, NULL, CGRectMake(0, 0, self.frame.size.width, self.frame.size.height));
    // 获取将执行渲染的框架。
    CFRange currentRange = CFRangeMake(0, 0);
    CTFrameRef frameRef = CTFramesetterCreateFrame(framesetter, currentRange, framePath, NULL);
    CGPathRelease(framePath);

    // 获取每个排版行
    NSArray *lines = (__bridge id)CTFrameGetLines(frameRef);
    
    CFIndex linesCount = [lines count];
    CGPoint *lineOrigins = (CGPoint *) malloc(sizeof(CGPoint) * linesCount);
    CTFrameGetLineOrigins(frameRef, CFRangeMake(0, linesCount), lineOrigins);
    
    CTLineRef line = NULL;
    CGPoint lineOrigin = CGPointZero;
    
    // 将每个排版行（原点（0,0））修改为正确的方向（排版框架底部的偏移量）
    
    CGFloat bottom = self.frame.size.height;
    for(CFIndex i = 0; i < linesCount; ++i) {
        lineOrigins[i].y = self.frame.size.height - lineOrigins[i].y;
        bottom = lineOrigins[i].y;
    }
    
    // 用标签框顶部与文本之间的空间量偏移触摸点
    pt.y -= (self.frame.size.height - bottom)/2;
    
    
    // 扫描每条线以找到包含触摸点y位置的线
    for(CFIndex i = 0; i < linesCount; ++i) {
        line = (__bridge CTLineRef)[lines objectAtIndex:i];
        lineOrigin = lineOrigins[i];
        CGFloat descent, ascent;
        CGFloat width = CTLineGetTypographicBounds(line, &ascent, &descent, nil);
        
        if(pt.y < (floor(lineOrigin.y) + floor(descent))) {
            
            // 迎合在标签中设置的文本对齐方式（不在属性字符串中）
            if (self.textAlignment == NSTextAlignmentCenter) {
                pt.x -= (self.frame.size.width - width)/2;
            } else if (self.textAlignment == NSTextAlignmentRight) {
                pt.x -= (self.frame.size.width - width);
            }
            
            // 用实际的排版线原点偏移触摸位置。pt现在是线边界的正确触摸位置
            pt.x -= lineOrigin.x;
            pt.y -= lineOrigin.y;
            
            // 在这一行中找到触摸位置的文本索引
            CFIndex i = CTLineGetStringIndexForPosition(line, pt);
            
            // 遍历每个字形运行以查找包含字符索引的运行
            NSArray* glyphRuns = (__bridge id)CTLineGetGlyphRuns(line);
            CFIndex runCount = [glyphRuns count];
            for (CFIndex run=0; run<runCount; run++) {
                CTRunRef glyphRun = (__bridge CTRunRef)[glyphRuns objectAtIndex:run];
                CFRange range = CTRunGetStringRange(glyphRun);
                if (i >= range.location && i<= range.location+range.length) {
                    dictionary = (__bridge NSDictionary*)CTRunGetAttributes(glyphRun);
                    break;
                }
            }
            if (dictionary) {
                break;
            }
        }
    }
    
    free(lineOrigins);
    CFRelease(frameRef);
    CFRelease(framesetter);
    return dictionary;
}

@end
