//
//  ViewController.m
//  YYDownloadTest
//
//  Created by CaoYuanyuan on 2017/1/3.
//  Copyright © 2017年 cyy. All rights reserved.
//

#import "ViewController.h"
#import "YYDownload.h"
#import "YYProgressView.h"

#define kFileDownloadPath [NSString pathWithComponents:@[[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0], @"medias"]]

@interface ViewController ()<YYDownloaderDelegate>

@property (nonatomic, strong) YYProgressView *progressView;
@property (nonatomic, strong) YYDownloader *downloader;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _progressView = [[YYProgressView alloc] init];
    _progressView.trackImage = [[UIImage imageNamed:@"downloading_schedule_frame"] stretchableImageWithLeftCapWidth:2.5 topCapHeight:2.5];
    _progressView.progressImage = [[UIImage imageNamed:@"downloading_schedule_article"] stretchableImageWithLeftCapWidth:2.5 topCapHeight:2.5];
    
    _progressView.frame = CGRectMake(10, 100, self.view.frame.size.width - 10*2, 20);
    [self.view addSubview:_progressView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)start:(id)sender {
    if (self.downloader) {
        self.downloader = nil;
    }
    YYDownloadManager *downloadManager = [YYDownloadManager sharedInstance];
    NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/resources/videos/minion_03.mp4"];
    self.downloader = [downloadManager startDownloadWithURL:url customPath:kFileDownloadPath delegate:self];
}

- (IBAction)cancel:(id)sender {
    [self.downloader cancelDownloadAndRemoveFile:NO];
    
}

- (IBAction)deleteAction:(id)sender {
    [self.downloader cancelDownloadAndRemoveFile:YES];
    self.progressView.progress = 0;
    self.rateLabel.text = @"0";
}


- (void)download:(YYDownloader *)blobDownload didReceiveFirstResponse:(NSURLResponse *)response
{
    
}

- (void)download:(YYDownloader *)blobDownload didReceiveData:(uint64_t)receivedLength onTotal:(uint64_t)totalLength progress:(float)progress
{
    self.progressView.progress = progress;
    self.rateLabel.text = [NSString stringWithFormat:@"%.2f%@",progress*100,@"%"];
}

- (void)download:(YYDownloader *)blobDownload didFinishWithSuccess:(BOOL)downloadFinished atPath:(NSString *)pathToFile
{
    
}

- (void)download:(YYDownloader *)blobDownload didStopWithError:(NSError *)error
{
    
}















@end
