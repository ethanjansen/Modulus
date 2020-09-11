#import "EthanLogs.h"

@implementation EthanLogs
+ (void)logWithString:(NSString *)string
{
	NSString *log = @"modulusprefs.log";
	NSString *logPath = [NSString stringWithFormat:@"/var/mobile/Documents/%@", log];

	NSData *stringData = [string dataUsingEncoding:NSUTF8StringEncoding];
	NSFileManager *fileManager = [NSFileManager defaultManager];
	BOOL isWritable = [fileManager isWritableFileAtPath:@"/var/mobile/Documents"];

	if (isWritable) {
		if (![fileManager fileExistsAtPath:logPath]) {
			[fileManager createFileAtPath:logPath
													 contents:stringData
												 attributes:nil];
		} else {
			NSFileHandle *fileHandler = [NSFileHandle fileHandleForUpdatingAtPath:logPath];
			[fileHandler seekToEndOfFile];
			[fileHandler writeData:stringData];
			[fileHandler closeFile];
		}
	}
}

@end
