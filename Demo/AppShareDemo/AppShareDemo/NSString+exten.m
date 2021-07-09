//
//  NSString+exten.m
//  AppShareDemo
//
//  Created by ray on 2021/7/9.
//


#import "NSString+exten.h"

@implementation NSString (exten)
-(NSMutableAttributedString *)keyWords:(NSString *)keyWords withKeyWordsColor:(UIColor *)color
{
    
    NSMutableAttributedString *mutableAttributedStr = [[NSMutableAttributedString alloc] initWithString:self];
    if (color == nil) {
        color = [UIColor redColor];
    }
    
    if (keyWords.length<=0) {
         return mutableAttributedStr;
    }
    
    for (NSInteger j=0; j<=keyWords.length-1; j++) {
        
        NSRange searchRange = NSMakeRange(0, [self length]);
        NSRange range;
        NSString *singleStr = [keyWords substringWithRange:NSMakeRange(j, 1)];
        while
            ((range = [self rangeOfString:singleStr options:0 range:searchRange]).location != NSNotFound) {
                //改变多次搜索时searchRange的位置
                searchRange = NSMakeRange(NSMaxRange(range), [self length] - NSMaxRange(range));
                //设置富文本
                [mutableAttributedStr addAttribute:NSForegroundColorAttributeName value:color range:range];
                
            }
    }
    
    return mutableAttributedStr;
    
    
    
}

-(NSMutableAttributedString *)normalkeyWords:(NSString *)keyWords withKeyWordsColor:(UIColor *)color
{
    
    NSMutableAttributedString *mutableAttributedStr = [[NSMutableAttributedString alloc] initWithString:self];
    if (color == nil) {
        color = [UIColor redColor];
    }
    
    if (keyWords.length<=0) {
         return mutableAttributedStr;
    }
    
    NSRange searchRange = NSMakeRange(0, [self length]);
    NSRange range;
    NSString *singleStr = keyWords;
    while
        ((range = [self rangeOfString:singleStr options:0 range:searchRange]).location != NSNotFound) {
            //改变多次搜索时searchRange的位置
            searchRange = NSMakeRange(NSMaxRange(range), [self length] - NSMaxRange(range));
            //设置富文本
            [mutableAttributedStr addAttribute:NSForegroundColorAttributeName value:color range:range];
            
        }
    
    return mutableAttributedStr;
    
    
    
}

@end
