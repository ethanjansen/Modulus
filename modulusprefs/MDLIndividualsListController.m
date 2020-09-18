#import "MDLIndividualsListController.h"
#import <Preferences/PSSpecifier.h>

@implementation MDLIndividualsListController

- (NSArray *)specifiers
{
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Individuals" target:self];
	}
	[(UINavigationItem *)self.navigationItem setTitle:@"Individual Modules"];

	return _specifiers;
}

@end
