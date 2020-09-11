#import "MDLRootListController.h"
#import <spawn.h>

@implementation MDLRootListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
	}
	return _specifiers;
}

- (void)respring
{
	pid_t pid;
	int status;
	const char* args[] = {"sbreload", NULL};
	posix_spawn(&pid, "/usr/bin/sbreload", NULL, NULL, (char* const*)args, NULL);
	waitpid(pid, &status, WEXITED);
}

@end
