//
//  SOAudio.h
//  DOUASDemo
//
//  Created by xueyi on 2017/6/8.
//  Copyright © 2017年 Douban Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreAudio/CoreAudioTypes.h>

@interface SOAudio : NSObject

@end

FOUNDATION_EXPORT NSString * NSStringFromAudioStreamBasicDescription(AudioStreamBasicDescription des);
FOUNDATION_EXPORT NSString * NSStringFromAudioFormatID(AudioFormatID fmt);
