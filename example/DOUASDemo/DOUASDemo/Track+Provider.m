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

#import "Track+Provider.h"
#import <MediaPlayer/MediaPlayer.h>

@implementation Track (Provider)

+ (void)load {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        [self remoteTracks];
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        [self musicLibraryTracks];
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        [self testTracks];
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        [self gkbbTracks];
    });
}

+ (NSArray *)remoteTracks
{
  static NSArray *tracks = nil;

  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://douban.fm/j/mine/playlist?type=n&channel=1004693&from=mainsite"]];
    NSData *data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:NULL
                                                     error:NULL];
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[string dataUsingEncoding:NSUTF8StringEncoding] options:0 error:NULL];

    NSMutableArray *allTracks = [NSMutableArray array];
    for (NSDictionary *song in [dict objectForKey:@"song"]) {
      Track *track = [[Track alloc] init];
      [track setArtist:[song objectForKey:@"artist"]];
      [track setTitle:[song objectForKey:@"title"]];
      [track setAudioFileURL:[NSURL URLWithString:[song objectForKey:@"url"]]];
      [allTracks addObject:track];
    }

    tracks = [allTracks copy];
  });

  return tracks;
}

+ (NSArray *)musicLibraryTracks
{
  static NSArray *tracks = nil;

  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    NSMutableArray *allTracks = [NSMutableArray array];
    for (MPMediaItem *item in [[MPMediaQuery songsQuery] items]) {
      if ([[item valueForProperty:MPMediaItemPropertyIsCloudItem] boolValue]) {
        continue;
      }

      Track *track = [[Track alloc] init];
      [track setArtist:[item valueForProperty:MPMediaItemPropertyArtist]];
      [track setTitle:[item valueForProperty:MPMediaItemPropertyTitle]];
      [track setAudioFileURL:[item valueForProperty:MPMediaItemPropertyAssetURL]];
      [allTracks addObject:track];
    }

    for (NSUInteger i = 0; i < [allTracks count]; ++i) {
      NSUInteger j = arc4random_uniform((u_int32_t)[allTracks count]);
      [allTracks exchangeObjectAtIndex:i withObjectAtIndex:j];
    }

    tracks = [allTracks copy];
  });

  return tracks;
}

+ (NSArray *)testTracks {
    static NSArray *tracks = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSMutableArray *trackArray = [NSMutableArray arrayWithCapacity:41];
        for (int i = 0; i < 41; i++) {
            Track *track = [Track new];
            track.artist = @"张悬";
            track.title = [NSString stringWithFormat:@"music:%i", i];
            track.audioFileURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://192.168.2.1/Music/xuan/%i.mp3", i]];
            [trackArray addObject:track];
        }
        tracks = [trackArray copy];
    });
    return tracks;
}

+ (NSArray *)gkbbTracks {
    static NSArray *tracks = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tracks =
        @[
          [self gkbbTrackWithTitle:@"01-生命的追求"
                         urlString:@"http://www.gkbbapp.com/Support/Download.aspx?DownloadAudio=2015/10/2015_10_1457.mp3&AudioFileID=1457&type=download&version=814&USERID=0"],
          [self gkbbTrackWithTitle:@"02-姚明：新式中锋"
                         urlString:@"http://www.gkbbapp.com/Support/Download.aspx?DownloadAudio=2015/11/2015_11_1651.mp3&AudioFileID=1651&type=download&version=814&USERID=0"],
          [self gkbbTrackWithTitle:@"03-吹牛"
                         urlString:@"http://www.gkbbapp.com/Support/Download.aspx?DownloadAudio=2015/11/2015_11_1654.mp3&AudioFileID=1654&type=download&version=814&USERID=0"],
          [self gkbbTrackWithTitle:@"04-纳米科技，超越终极想象"
                         urlString:@"http://www.gkbbapp.com/Support/Download.aspx?DownloadAudio=2015/11/2015_11_1658.mp3&AudioFileID=1658&type=download&version=814&USERID=0"],
          [self gkbbTrackWithTitle:@"05-几米：画给大人看的漫画"
                         urlString:@"http://www.gkbbapp.com/Support/Download.aspx?DownloadAudio=2015/11/2015_11_1662.mp3&AudioFileID=1662&type=download&version=814&USERID=0"],
          [self gkbbTrackWithTitle:@"06-双城记(节选)"
                         urlString:@"http://www.gkbbapp.com/Support/Download.aspx?DownloadAudio=2015/11/2015_11_1663.mp3&AudioFileID=1663&type=download&version=814&USERID=0"],
          [self gkbbTrackWithTitle:@"07-诗两首"
                         urlString:@"http://www.gkbbapp.com/Support/Download.aspx?DownloadAudio=2015/11/2015_11_1664.mp3&AudioFileID=1664&type=download&version=814&USERID=0"],
          [self gkbbTrackWithTitle:@"08-青春"
                         urlString:@"http://www.gkbbapp.com/Support/Download.aspx?DownloadAudio=2015/11/2015_11_1665.mp3&AudioFileID=1665&type=download&version=814&USERID=0"],
          [self gkbbTrackWithTitle:@"09-大山的故事"
                         urlString:@"http://www.gkbbapp.com/Support/Download.aspx?DownloadAudio=2015/11/2015_11_1666.mp3&AudioFileID=1666&type=download&version=814&USERID=0"],
          [self gkbbTrackWithTitle:@"10-寓言两则"
                         urlString:@"http://www.gkbbapp.com/Support/Download.aspx?DownloadAudio=2015/11/2015_11_1667.mp3&AudioFileID=1667&type=download&version=814&USERID=0"],
          ];
    });
    return tracks;
}

@end
