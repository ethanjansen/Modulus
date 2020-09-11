#import "MDLIndividualsListController.h"
#import <Preferences/PSSpecifier.h>
//#import "MDLArrayCell.h"
//#import "CustomCell.m"

@implementation MDLIndividualsListController

- (NSArray *)specifiers
{
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Individuals" target:self];
	}
	[(UINavigationItem *)self.navigationItem setTitle:@"Individual Modules"];

	/*
	PSSpecifier *arraySpecifier = [PSSpecifier preferenceSpecifierNamed:@"array"
																													target:self
																														 set:nil
																														 get:nil
																													detail:nil
																														cell:PSGroupCell
																														edit:nil];
	[arraySpecifier setProperty:@"MDLArrayCell" forKey:@"cellClass"];
	[arraySpecifier setProperty:@YES forKey:@"enabled"];

	_specifiers = [plistSpec arrayByAddingObject:arraySpecifier];
	*/
	return _specifiers;
}

@end
