#import "MDLIndividualsButtonsListController.h"
#import <Preferences/PSSpecifier.h>

@implementation MDLIndividualsButtonsListController

- (NSArray *)specifiers
{
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"IndividualsButtons" target:self];
	}
	[(UINavigationItem *)self.navigationItem setTitle:@"Module"];

	return _specifiers;
}

@end
