/* vim: set ft=objc fenc=utf-8 sw=2 ts=2 et: */
/*
 *  DOUAudioStreamer - A Core Audio based streaming audio player for iOS/Mac:
 *
 *      https://github.com/douban/DOUAudioStreamer
 *
 *  Copyright 2013-2016 Douban Inc.  All rights reserved.
 *
 *  Use and distribution licensed under the BSD license.  See
 *  the LICENSE file for full text.
 *
 *  Authors:
 *      Chongyu Zhu <i@lembacon.com>
 *
 */

#import "Track.h"

@implementation Track

+ (instancetype)gkbbTrackWithTitle:(NSString *)title urlString:(NSString *)urlString {
    Track *track = [Track new];
    track.title = [title copy];
    track.artist = @"高考必备";
    track.audioFileURL = [NSURL URLWithString:urlString];
    return track;
}

@end
