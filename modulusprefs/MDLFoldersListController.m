#import "MDLFoldersListController.h"

@implementation MDLFoldersListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Folders" target:self];
	}
	[(UINavigationItem *)self.navigationItem setTitle:@"Folder Modules"];
	return _specifiers;
}

@end
