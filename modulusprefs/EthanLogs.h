@interface EthanLogs : NSString
{
	NSString *_log;
	NSString *_logPath;
}

+ (void)logWithString:(NSString *)string;
@end
