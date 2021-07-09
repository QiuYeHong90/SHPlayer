//
//  NSString+exten.h
//  AppShareDemo
//
//  Created by ray on 2021/7/9.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (exten)
-(NSMutableAttributedString *)keyWords:(NSString *)keyWords withKeyWordsColor:(UIColor *)color;

-(NSMutableAttributedString *)normalkeyWords:(NSString *)keyWords withKeyWordsColor:(UIColor *)color;
@end

NS_ASSUME_NONNULL_END
