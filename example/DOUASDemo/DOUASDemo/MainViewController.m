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

#import "MainViewController.h"
#import "PlayerViewController.h"
#import "Track+Provider.h"

@interface MainViewController ()

@property (strong, nonatomic) NSArray *cellTitles;
@property (strong, nonatomic) NSArray *subArrays;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [self setTitle:@"DOUAudioStreamer ♫"];
    self.cellTitles = @[@"Remote Music", @"Local Music Library", @"我的测试音乐", @"高考必备测试音频"];
    self.subArrays =
    @[
      [Track remoteTracks],
      [Track musicLibraryTracks],
      [Track testTracks],
      [Track gkbbTracks]
      ];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.cellTitles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *const kCellIdentifier = @"MainViewController_CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellIdentifier];
    }
    cell.textLabel.text = self.cellTitles[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PlayerViewController *playerViewController = [[PlayerViewController alloc] init];
    playerViewController.title = self.cellTitles[indexPath.row];
    playerViewController.tracks = self.subArrays[indexPath.row];
    [[self navigationController] pushViewController:playerViewController
                                           animated:YES];
}

@end
