//
//  YYDownloader.h
//  Demo
//
//  Created by CaoYuanyuan on 2016/12/27.
//  Copyright © 2016年 cyy. All rights reserved.
//
#define NO_LOG
#if defined(DEBUG) && !defined(NO_LOG)
#define YYLog(format, ...) NSLog(format, ## __VA_ARGS__)
#else
#define YYLog(format, ...)
#endif

#import <Foundation/Foundation.h>

extern NSString * const YYDownloadErrorDomain;
extern NSString * const YYDownloadErrorHTTPStatusKey;

typedef NS_ENUM(NSUInteger, YYDownloadError) {
    YYDownloadErrorInvalidURL = 0,//无效的URL
    YYDownloadErrorHTTPError,//HTTP请求错误
    YYDownloadErrorNotEnoughFreeDiskSpace//剩余磁盘空间不足
};

typedef NS_ENUM(NSUInteger, YYDownloadState) {
    YYDownloadStateReady = 0,
    YYDownloadStateDownloading,
    YYDownloadStateDone,
    YYDownloadStateCanceled,
    YYDownloadStateFailed
};

@class YYDownloader;
@protocol YYDownloaderDelegate <NSObject>

@optional
- (void)download:(YYDownloader *)blobDownload didReceiveFirstResponse:(NSURLResponse *)response;

- (void)download:(YYDownloader *)blobDownload
  didReceiveData:(uint64_t)receivedLength
         onTotal:(uint64_t)totalLength
        progress:(float)progress;

- (void)download:(YYDownloader *)blobDownload
didStopWithError:(NSError *)error;

- (void)download:(YYDownloader *)blobDownload
didFinishWithSuccess:(BOOL)downloadFinished
          atPath:(NSString *)pathToFile;

@end


@protocol YYDownloaderDelegate;
@interface YYDownloader : NSOperation<NSURLSessionDataDelegate>

@property (nonatomic, strong, readonly) NSURLSession *session;

@property (nonatomic, strong) NSRunLoop *runloop;
@property (nonatomic, strong) id model;

@property (nonatomic, weak) id<YYDownloaderDelegate> delegate;

@property (nonatomic, copy, readonly) NSString *pathToDownloadDirectory;

@property (nonatomic, copy, readonly) NSString *pathToFile;

@property (nonatomic, copy, readonly) NSURL *downloadURL;

@property (nonatomic, strong, readonly) NSMutableURLRequest *fileRequest;

@property (nonatomic, copy, getter = fileName) NSString *fileName;

@property (nonatomic, assign, readonly) NSInteger speedRate;

@property (nonatomic, assign, readonly, getter = remainingTime) NSInteger remainingTime;

@property (nonatomic, assign, readonly, getter = progress) float progress;

@property (nonatomic, assign, readonly) YYDownloadState state;


- (instancetype)initWithURL:(NSURL *)url
               downloadPath:(NSString *)pathToDL
                   delegate:(id<YYDownloaderDelegate>)delegateOrNil;


- (instancetype)initWithURL:(NSURL *)url
               downloadPath:(NSString *)pathToDL
              firstResponse:(void (^)(NSURLResponse *response))firstResponseBlock
                   progress:(void (^)(uint64_t receivedLength, uint64_t totalLength, NSInteger remainingTime, float progress))progressBlock
                      error:(void (^)(NSError *error))errorBlock
                   complete:(void (^)(BOOL downloadFinished, NSString *pathToFile))completeBlock;

- (void)cancelDownloadAndRemoveFile:(BOOL)remove;

- (void)addDependentDownload:(YYDownloader *)download;



@end



