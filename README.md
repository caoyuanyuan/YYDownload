# YYDownload
断点下载管理器（NSURLSession）

##################################################################
说明：
****************Version：1.0*************************************
功能：实现了单个或多个下载任务的一次性下载或断点续传。
类： >1.YYDownloader:继承NSOperation，内部实现了NSURLSession的代理方法处理下载任务，数据以文件保存，通过代理和block两种形式返回下载请求结果。
    >2.YYDownloadManager:YYDownloader的管理类，对YYDownloader进行封装。

