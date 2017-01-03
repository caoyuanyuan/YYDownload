//
//  YYDownloadManager.m
//
//  Created by CaoYuanyuan on 2016/12/27.
//  Copyright © 2016年 cyy. All rights reserved.
//

#import "YYDownloadManager.h"
#import "YYDownloader.h"

@implementation YYDownloadManager

@dynamic downloadCount;
@dynamic currentDownloadCount;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.operationQueue = [[NSOperationQueue alloc] init];
        self.defaultDownloadPath = [NSString stringWithString:NSTemporaryDirectory()];
    }
    return self;
}

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static id sharedManager = nil;
    dispatch_once(&onceToken, ^{
        sharedManager = [[[self class] alloc] init];
        [sharedManager setOperationQueueName:@"YYDownloadManager_Instance_Queue"];
    });
    return sharedManager;
}

- (YYDownloader *)startDownloadWithURL:(NSURL *)url customPath:(NSString *)customPathOrNil delegate:(id<YYDownloaderDelegate>)delegate
{
    if (!customPathOrNil) {
        customPathOrNil = self.defaultDownloadPath;
    }
    YYDownloader *downloader = [[YYDownloader alloc] initWithURL:url
                                                    downloadPath:customPathOrNil
                                                        delegate:delegate];
    [self.operationQueue addOperation:downloader];
    return downloader;
}

- (YYDownloader *)startDownloadWithURL:(NSURL *)url customPath:(NSString *)customPathOrNil firstResponse:(void (^)(NSURLResponse *))firstResponseBlock progress:(void (^)(uint64_t, uint64_t, NSInteger, float))progressBlock error:(void (^)(NSError *))errorBlock complete:(void (^)(BOOL, NSString *))completeBlock
{
    if (!customPathOrNil) {
        customPathOrNil = self.defaultDownloadPath;
    }
    YYDownloader *downloader = [[YYDownloader alloc] initWithURL:url
                                                    downloadPath:customPathOrNil
                                                   firstResponse:firstResponseBlock
                                                        progress:progressBlock
                                                           error:errorBlock
                                                        complete:completeBlock];
    [self.operationQueue addOperation:downloader];
    return downloader;
}

- (void)startDownload:(YYDownloader *)download
{
    [download cancelDownloadAndRemoveFile:NO];

    [self.operationQueue addOperation:download];
}

- (void)startDownloads:(NSMutableArray<YYDownloader *> *)downloads
{
    [self.operationQueue cancelAllOperations];
    [self.operationQueue addOperations:downloads waitUntilFinished:NO];
}

- (void)cancelAllDownloadsAndRemoveFile:(BOOL)remove
{
    [self.operationQueue cancelAllOperations];
    NSArray <YYDownloader *>*operationsArr = self.operationQueue.operations;
    [operationsArr enumerateObjectsUsingBlock:^(YYDownloader * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj cancelDownloadAndRemoveFile:remove];
    }];
}

- (void)setOperationQueueName:(NSString *)queueName
{
    self.operationQueue.name = queueName;
}


@end
