//
//  YYDownloadManager.h
//
//  Created by CaoYuanyuan on 2016/12/27.
//  Copyright © 2016年 cyy. All rights reserved.
//
/**
 YYDownloadManager 是 YYDownloader的管理类，通过NSOperationQueue来添加、移除下载类
 它提供了开始和取消一个下载操作的方法，同时可以定义最大下载量
 使用单例来创建类的实例
 */

@class YYDownloader;
@protocol YYDownloaderDelegate;
#import <Foundation/Foundation.h>

@interface YYDownloadManager : NSObject

@property (nonatomic, strong) NSOperationQueue *operationQueue;

/**
 defaultDownloadPath用于未设置customPath下
 默认值为`/tmp`
 */
@property (nonatomic, copy) NSString *defaultDownloadPath;

//当前队列的总下载数
@property (nonatomic, assign) NSUInteger downloadCount;

//当前队列中正在执行的下载数
@property (nonatomic, assign) NSUInteger currentDownloadCount;

+ (instancetype)sharedInstance;

/**
 !* 根据指定的URL，自定义的下载路径，可选代理来创建一个下载类（YYDownloader类型），该类是NSOperation的子类，执行于后台线程中。
 @param1 url 文件的下载路径。
 @param2 customPathOrNil 文件下载到路径（可为nil，为空时，使用默认路径）
 @param3 delegate 设置代理（可不设）
 @return YYDownloader 返回创建并执行的下载对象
 */
- (YYDownloader *)startDownloadWithURL:(NSURL *)url
                            customPath:(NSString *)customPathOrNil
                              delegate:(id<YYDownloaderDelegate>)delegate;

/**
 !* 提供与`startDownloadWithURL: customPath: delegate:`相似的方法，block的形式更新View
 @param1 url 文件的下载路径。
 @param2 customPathOrNil 文件下载到路径（可为nil，为空时，使用默认路径）
 @param3 firstResponseBlock block回调，第一次请求服务器返回的参数
 @param4 progressBlock 进度block回调，（如果剩余时间尚未计算，remainingTime = -1）
 @param5 errorBlock 错误信息返回，当下载请求发生错误时调用
 @param6 completeBlock 下载完成回调block
 @return YYDownloader 返回创建并执行的下载对象
 */
- (YYDownloader *)startDownloadWithURL:(NSURL *)url
                            customPath:(NSString *)customPathOrNil
                         firstResponse:(void(^)(NSURLResponse *response))firstResponseBlock
                              progress:(void(^)(uint64_t receivedLength, uint64_t totalLength, NSInteger remainingTime, float progress))progressBlock
                                 error:(void(^)(NSError *error))errorBlock
                              complete:(void(^)(BOOL downloadFinished, NSString *fileToPath))completeBlock;

//一个请求任务开始下载
- (void)startDownload:(YYDownloader *)download;

//多个请求任务开始下载
- (void)startDownloads:(NSMutableArray <YYDownloader *>*)downloads;

- (void)setOperationQueueName:(NSString *)queueName;

- (BOOL)setDefaultDownloadPath:(NSString *)fileToDL error:(NSError *__autoreleasing)error;

- (void)setMaxConcurrentDownload:(NSInteger)count;

- (void)cancelAllDownloadsAndRemoveFile:(BOOL)remove;

@end
